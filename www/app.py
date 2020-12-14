#!/usr/bin/env python3
# -*- coding:utf-8 -*-

__author__ = 'JM'

"""
async web application
"""

import asyncio
import os
import json
import time

from datetime import datetime
from aiohttp import web
from jinja2 import Environment, FileSystemLoader

import orm
from coreweb import add_routes, add_static
from config import configs
import logging
logging.basicConfig(level=logging.INFO)


def init_jinja2(app, **kw):
    logging.info('init jinja2...')
    options = dict(
        autoescape=kw.get('autoescape', True),
        block_start_string=kw.get('block_start_string', '{%'),
        block_end_string=kw.get('block_end_string', '%}'),
        variable_start_string=kw.get('variable_start_string', '{{'),
        variable_end_string=kw.get('variable_end_string', '}}'),
        auto_reload=kw.get('auto_reload', True)
    )
    path = kw.get('path', None)
    if path is None:
        path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
    logging.info('set jinja2 template path: %s' % path)
    env = Environment(loader=FileSystemLoader(path), **options)
    filters = kw.get('filters', None)
    if filters is not None:
        for name, f in filters.items():
            env.filters[name] = f
    app['__templating__'] = env


async def logger_factory(app, handler):
    async def logger(request):
        logging.info('Request: %s %s' % (request.method, request.path))
        # await asyncio.sleep(0.3)
        return (await handler(request))
    return logger


async def response_factory(app, handler):
    async def response(request):
        logging.info('Response handler...')
        r = await handler(request)
        if isinstance(r, web.StreamResponse):
            return r
        if isinstance(r, bytes):
            resp = web.Response(body=r)
            resp.content_type = 'application/octet-stream'
            return resp
        if isinstance(r, str):
            if r.startswith('redirect:'):
                return web.HTTPFound(r[9:])
            resp = web.Response(body=r.encode('utf-8'))
            resp.content_type = 'text/html;charset=utf-8'
            return resp
        if isinstance(r, dict):
            template = r.get('__template__')
            if template is None:
                resp = web.Response(body=json.dumps(r, ensure_ascii=False, default=lambda o: o.__dict__).encode('utf-8'))
                resp.content_type = 'application/json;charset=utf-8'
                return resp
            else:
                resp = web.Response(body=app['__templating__'].get_template(template).render(**r).encode('utf-8'))
                resp.content_type = 'text/html;charset=utf-8'
                return resp
        if isinstance(r, int) and 100 <= r < 600:
            return web.Response(r)
        if isinstance(r, tuple) and len(r) == 2:
            t, m = r
            if isinstance(t, int) and 100 <= t < 600:
                return web.Response(t, str(m))
        # default:
        resp = web.Response(body=str(r).encode('utf-8'))
        resp.content_type = 'text/plain;charset=utf-8'
        return resp
    return response


def datetime_filter(t):
    delta = int(time.time() - t)
    if delta < 60:
        return u'1分钟前'
    if delta < 3600:
        return u'%s分钟前' % (delta // 60)
    if delta < 86400:
        return u'%s小时前' % (delta // 3600)
    if delta < 604800:
        return u'%s天前' % (delta // 86400)
    dt = datetime.fromtimestamp(t)
    return u'%s年%s月%s日' % (dt.year, dt.month, dt.day)


async def init():
    host = configs.db.host
    port = configs.db.port
    user = configs.db.user
    pw = configs.db.password
    db = configs.db.db
    await orm.create_pool(host=host, port=port, user=user, password=pw, db=db)
    app = web.Application(middlewares=[
        logger_factory, response_factory
    ])
    init_jinja2(app, filters=dict(datetime=datetime_filter))
    add_routes(app, "handlers")
    add_static(app)
    return app


if __name__ == '__main__':
    logging.info("Server started at 127.0.0.1:9000")
    web.run_app(init(), host='127.0.0.1', port=9000)


# async def init(loop):
#     await orm.create_pool(loop=loop, host='127.0.0.1', port=3306, user='root', password='etonkids', db='awesome')
#     app = web.Application(loop=loop, middlewares=[
#         logger_factory, response_factory
#     ])
#     init_jinja2(app, filters=dict(datetime=datetime_filter))
#     add_routes(app, 'handlers')
#     add_static(app)
#     srv = await loop.create_server(app.make_handler(), '127.0.0.1', 9000)
#     logging.info('server started at http://127.0.0.1:9000')
#     return srv
#
# loop = asyncio.get_event_loop()
# loop.run_until_complete(init(loop))
# loop.run_forever()

# async def handle(request):
#     name = request.match_info.get('name', "Anonymous")
#     text = "Hello, " + name
#     return web.Response(text=text, content_type='text/html')
#
#
# app = web.Application()
# app.add_routes([web.get('/', handle), web.get('/{name}', handle)])
# logging.info('server started at http://127.0.0.1:9000...')
#
# if __name__ == '__main__':
#     web.run_app(app, host='127.0.0.1', port=9000)


