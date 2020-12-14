#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Configuration
"""

__author__ = 'JM'

import config_default
import config_override


class Dict(dict):
    """
    Simple dict but support access as x.y style
    """
    def __init__(self, names=(), values=(), **kw):
        super(Dict, self).__init__(**kw)
        for k, v in zip(names, values):
            self[k] = v

    def __getattr__(self, key):
        try:
            return self[key]
        except KeyError:
            raise AttributeError(r"'Dict' object has no attribute '%s'" % key)

    def __setattr__(self, key, value):
        self[key] = value


def merge(defaults, override):
    r = {}
    for k, v in defaults.items():
        if k in override:
            if isinstance(v, dict):
                r[k] = merge(v, override[k])
            else:
                r[k] = override[k]
        else:
            r[k] = v
    return r


def to_dict(d):
    d = Dict()
    for k, v in d.items():
        d[k] = to_dict(v) if isinstance(v, dict) else v
    return d


configs = config_default.configs


try:
    configs = merge(configs, config_override.configs)
except ImportError:
    pass


configs = to_dict(configs)
