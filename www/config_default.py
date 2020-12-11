#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Default configuration.
"""


__author__ = 'JM'


configs = {
    'debug': True,
    'db': {
        'host': '127.0.0.1',
        'port': 3306,
        'user': 'root',
        'password': 'passwd',
        'db': 'awesome'
    },
    'session': {
        'secret': 'Awesome'
    }
}