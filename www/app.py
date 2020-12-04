import logging
from aiohttp import web


async def handle(request):
    name = request.match_info.get('name', "Anonymous")
    text = "Hello, " + name
    return web.Response(text=text, content_type='text/html')


app = web.Application()
app.add_routes([web.get('/', handle), web.get('/{name}', handle)])
logging.info('server started at http://127.0.0.1:9000...')

if __name__ == '__main__':
    web.run_app(app, host='127.0.0.1', port=9000)