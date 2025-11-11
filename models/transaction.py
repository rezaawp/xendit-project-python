from tortoise import fields
from tortoise.models import Model
import datetime


class Transaction(Model):
    id = fields.IntField(pk=True)
    invoice_id = fields.CharField(max_length=100, unique=True)  # ID dari Xendit
    external_id = fields.CharField(max_length=100)  # ID internal kamu
    status = fields.CharField(max_length=50)  # e.g. PENDING, SETTLED, EXPIRED
    amount = fields.FloatField()
    payer_email = fields.CharField(max_length=255, null=True)
    description = fields.TextField(null=True)
    metadata = fields.JSONField(null=True)  # Menyimpan data tambahan dari Xendit
    created_at = fields.DatetimeField(default=datetime.datetime.utcnow)
    updated_at = fields.DatetimeField(auto_now=True)
    # Relasi ke detail
    details: fields.ReverseRelation["TransactionDetail"]

    # Contoh: total dihitung dari detail
    async def get_total(self):
        return await TransactionDetail.filter(transaction=self).sum("subtotal")

    def __str__(self):
        return self.code

class TransactionDetail(Model):
    id = fields.IntField(pk=True)
    transaction = fields.ForeignKeyField(
        "models.Transaction",
        related_name="details",
        on_delete=fields.CASCADE
    )
    product_name = fields.CharField(max_length=100)
    qty = fields.IntField()
    price = fields.DecimalField(max_digits=12, decimal_places=2)
    subtotal = fields.DecimalField(max_digits=12, decimal_places=2)

    def __str__(self):
        return f"{self.product_name} x {self.qty}"