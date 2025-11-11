from tortoise import fields, models

class Product(models.Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=100)
    price = fields.FloatField()

    class Meta:
        table = "products"

    def __str__(self):
        return f"{self.name} - {self.price}"