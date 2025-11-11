# controllers/history_controller.py
import web
from models.transaction import Transaction
import asyncio

render = web.template.render('templates')
loop = asyncio.get_event_loop()

class History:
    def GET(self, email=None):
        transactions = loop.run_until_complete(Transaction.filter(payer_email=email).order_by('-created_at').values())
        return render.history(transactions)
