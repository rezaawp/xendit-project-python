import web

render = web.template.render('templates')

class TestController:
    def GET(self):
        return web.seeother('/products')  # Nama bebas diganti
