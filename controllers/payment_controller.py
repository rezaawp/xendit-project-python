import web
# from services.xendit_service import create_invoice
import time
import xendit
from xendit.apis import InvoiceApi
from xendit.invoice.model.invoice_item import InvoiceItem
from xendit.invoice.model.create_invoice_request import CreateInvoiceRequest
import os
import json
from xendit.apis import RefundApi
from xendit.refund.model.create_refund import CreateRefund
import asyncio
from models.transaction import Transaction, TransactionDetail
import datetime

render = web.template.render('templates')
loop = asyncio.get_event_loop()
       
class Invoice:
    def POST(self):
        data = json.loads(web.data())

        name = data["name"]
        email = data["email"]
        total = data["total"]
        items = data["items"]  # [{name, price}, ...]

        # Convert items → format yang sesuai Xendit
        xendit_items = [
            InvoiceItem(
                name=item["name"],
                price=float(item["price"]),
                quantity=float(1)
            )
            for item in items
        ]
        # Set API Key
        secret_key = os.getenv("XENDIT_API_KEY")
        xendit.set_api_key(secret_key)

        api = InvoiceApi(xendit.ApiClient())

        # Gunakan CreateInvoiceRequest ✅
        create_invoice_request = CreateInvoiceRequest(
            external_id=f"order_{email}_{int(time.time())}",
            payer_email=email,
            description=f"Pembayaran oleh {name}",
            amount=float(total),
            items=xendit_items,
            invoice_duration=float(600),  # berlaku 10 menit
        )

        try:
            api_response = api.create_invoice(create_invoice_request)
            # Redirect ke invoice_url agar user bisa bayar
            invoice_url = api_response.invoice_url if hasattr(api_response, "invoice_url") else None
            
            transaction = loop.run_until_complete(Transaction.create(
                invoice_id=api_response.id,                  # ID invoice dari Xendit
                external_id=api_response.external_id,       # ID internal kita
                status=api_response.status,                 # PENDING / SETTLED / EXPIRED
                amount=float(api_response.amount),          # total pembayaran
                payer_email=api_response.payer_email,       # email customer
                description=api_response.description,       # deskripsi
                metadata=api_response.metadata or {}       # simpan metadata Xendit
            ))

            details = [
                TransactionDetail(
                    transaction=transaction,        # FK ke Transaction
                    product_name=item["name"],
                    qty=int(1),
                    price=float(item["price"]),
                    subtotal=float(item["price"])
                )
                for item in items
            ]

            loop.run_until_complete(TransactionDetail.bulk_create(details))

            if invoice_url:
                 # # Kembalikan invoice_url ke frontend
                web.header('Content-Type', 'application/json')
                return json.dumps({
                    "success": True,
                    "invoice_url": invoice_url
                })
                # raise web.seeother(invoice_url)
            else:
                return "Invoice berhasil dibuat, tapi invoice_url tidak ditemukan"
        except Exception as e:
            print("Exception when creating invoice: %s\n" % e)
            return "Error creating invoice"

class InvoiceDetail:
    def GET(self, invoice_id=None):
        secret_key = os.getenv("XENDIT_API_KEY")
        if not secret_key:
            return "XENDIT_API_KEY belum diset di .env"

        # Set API Key
        xendit.set_api_key(secret_key)

        # Buat instance API
        api = InvoiceApi(xendit.ApiClient())

        # Ambil list invoices berdasarkan external_id
        invoices = api.get_invoices(external_id=invoice_id)

        # Convert tiap invoice object ke dict
        invoices_list = [inv.to_dict() for inv in invoices]

        web.header('Content-Type', 'application/json')
        return json.dumps(invoices_list, default=str)

class Success:
    def GET(self):
        return render.success()

class CallbackPaid:
    def POST(self):
        payload = web.data()
        data = json.loads(payload)

        transaction_id = data["id"]
        status = data["status"]

        transaction = loop.run_until_complete(Transaction.get_or_none(invoice_id=transaction_id))
        transaction.status = status
        transaction.metadata = payload  # Simpan seluruh payload callback sebagai metadata
        loop.run_until_complete(transaction.save())

        return json.dumps({"success": True})

class Refund:
    def POST(self):
        data = json.loads(web.data())

        invoice_id = data["invoice_id"]

        transaction = loop.run_until_complete(Transaction.filter(invoice_id=invoice_id).first().values())
        amount = transaction['amount'] if transaction else 0

        reason = "CANCELLATION"

        # Set API Key
        secret_key = os.getenv("XENDIT_API_KEY")
        xendit.set_api_key(secret_key)

        api = RefundApi(xendit.ApiClient())

        idempotency_key = f"refund_{invoice_id}"

        create_refund_request = CreateRefund(
            invoice_id=invoice_id,
            amount=float(amount),
            reason=reason
        )

        try:
            api_response = api.create_refund(create_refund=create_refund_request, idempotency_key=idempotency_key)
            web.header('Content-Type', 'application/json')
            return json.dumps({
                "success": True,
                "refund": api_response.to_dict()
            }, default=str)
        except Exception as e:
            print("Exception when creating refund: %s\n" % e)
            return "Error creating refund"

class CallbackRefunded:
    def POST(self):
        payload = web.data()
        data = json.loads(payload)

        invoice_id = data["data"]["invoice_id"]
        status = data["data"]["status"]

        if status == "SUCCEEDED":
            transaction = loop.run_until_complete(Transaction.get_or_none(invoice_id=invoice_id))
            if transaction:
                transaction.status = "REFUNDED"
                transaction.metadata = payload  # Simpan seluruh payload callback sebagai metadata
                loop.run_until_complete(transaction.save())

            return json.dumps({"success": True})
        
        return json.dumps({"success": False, "message": "Invalid status"})
