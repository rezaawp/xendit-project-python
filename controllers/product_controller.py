import web
from models.product import Product
import asyncio

render = web.template.render('templates')

loop = asyncio.get_event_loop()

class ProductList:
    def GET(self):
        products = loop.run_until_complete(Product.all().values())
        return render.products(products)
        
class CartView:
    def GET(self):
        return render.cart()