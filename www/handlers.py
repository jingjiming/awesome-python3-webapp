#!/usr/bin/env python3
# -*- coding: utf-8 -*-


__author__ = 'JM'


'url handlers'
import re
import time
import json
import logging
import hashlib
import base64
import asyncio
from coreweb import get, post
from models import User, Commenet, Blog, next_id


@get('/')
async def index(request):
    users = await User.find_all()
    return {
        '__template__': 'test.html',
        'users': users
    }