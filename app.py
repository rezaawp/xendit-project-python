import os
import web
from xendit.invoice.model.invoice import Invoice
from dotenv import load_dotenv
from controllers.test_controller import TestController
from controllers.payment_controller import Invoice, InvoiceDetail, CallbackPaid, CallbackRefunded, Refund
from controllers.history_controller import History
from tortoise import Tortoise
import asyncio
from controllers.product_controller import ProductList, CartView
load_dotenv()

urls = (
    '/', TestController,
    '/products', ProductList,
    '/cart', CartView,
    '/invoice', Invoice, # POST
    '/invoice/(.*)', InvoiceDetail, # GET
    '/callback/paid', CallbackPaid,
    '/callback/refunded', CallbackRefunded,
    '/history/(.*)', History,
    '/refund', Refund
)

loop = asyncio.get_event_loop()

async def init_db():
    db_url = f"postgres://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
    await Tortoise.init(
        db_url=db_url,
        modules={'models': ['models.product', 'models.transaction']}
    )
    await Tortoise.generate_schemas()

loop.run_until_complete(init_db())

if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()
