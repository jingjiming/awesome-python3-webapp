#!/usr/bin/env python3
# -*- coding: utf-8 -*-

__author__ = 'JM'

import logging

import aiomysql
from MySQLdb.compat import StandardError


def log(sql, args=()):
	logging.info('SQL: %s' % sql)


async def create_pool(**kw):
	logging.info('create database connection pool...')
	global __pool
	__pool = await aiomysql.create_pool(
		host=kw.get('host', 'localhost'),
		port=kw.get('port', 3306),
		user=kw['user'],
		password=kw['password'],
		db=kw['db'],
		charset=kw.get('charset', 'utf-8'),
		autocommit=kw.get('autocommit', True),
		maxsize=kw.get('maxsize', 10),
		minsize=kw.get('minsize', 1)
	)


async def select(sql, args, size=None):
	log(sql, args)
	global __pool
	async with __pool.get() as conn:
		async with conn.cursor(aiomysql.DictCursor) as cur:
			await cur.execute(sql.replace('?', '%s'), args or ())
			if size:
				rs = await cur.fetchmany(size)
			else:
				rs = await cur.fetchall()
		logging.info('rows returned: %s' % len(rs))
		return rs


# 要执行INSERT、UPDATE、DELETE语句，
# 可以定义一个通用的execute()函数，
# 因为这3种SQL的执行都需要相同的参数，以及返回一个整数表示影响的行数
async def execute(sql, args, autocommit=True):
	log(sql)
	async with __pool.get() as conn:
		if not autocommit:
			await conn.begin()
		try:
			async with conn.cursor(aiomysql.DictCursor) as cur:
				await cur.execute(sql.replace('?', '%s'), args)
				affected = cur.rowcount
			if not autocommit:
				await conn.commit()
		except BaseException as e:
			if not autocommit:
				await conn.rollback()
			raise
		return affected


def create_args_string(num):
	lst = []
	for n in range(num):
		lst.append('?')
	return ', '.join(lst)


class Field(object):

	def __init__(self, name, column_type, primary_key, default):
		self.name = name
		self.column_type = column_type
		self.primary_key = primary_key
		self.default = default

	def __str__(self):
		return '<%s, %s:%s>' % (self.__class__.__name__, self.column_type, self.name)


class StringField(Field):

	def __init__(self, name=None, primary_key=False, default=None, ddl='varchar(100)'):
		super().__init__(name, ddl, primary_key, default)


class BooleanField(Field):

	def __init__(self, name=None, default=False):
		super.__init__(name, 'boolean', False, default)


class IntegerField(Field):

	def __init__(self, name=None, primary_key=False, default=0):
		super().__init__(name, 'bigint', primary_key, default)


class FloatField(Field):
	def __init__(self, name=None, primary_key=False, default=0.0):
		super().__init__(name, 'real', primary_key, default)


class TextField(Field):
	def __init__(self, name=None, default=None):
		super().__init__(name, 'text', False, default)


class ModelMetaclass(type):
	def __new__(mcs, name, bases, attrs):
		# 排除Model类本身
		if name == 'Model':
			return type.__new__(mcs, name, bases, attrs)
		# 获取table名称
		table_name = attrs.get('__table__', None) or name
		logging.info('found model: %s (table: %s)' % (name, table_name))
		# 获取所有的Field和主键名
		mappings = dict()
		fields = []
		primary_key = None
		for k, v in attrs.items():
			if isinstance(v, Field):
				logging.info('  found mapping: %s ==> %s' % (k, v))
				mappings[k] = v
				if v.primary_key:
					# 找到主键
					if primary_key:
						raise StandardError('Duplicate primary key for field: %s' % k)
					primary_key = k
				else:
					fields.append(k)
		if not primary_key:
			raise StandardError('Primary key not found.')
		for k in mappings.keys():
			attrs.pop(k)
		escaped_fields = list(map(lambda f: '`%s`' % f, fields))
		attrs['__mappings__'] = mappings  # 保存属性和列的映射关系
		attrs['__table__'] = table_name
		attrs['__primary_key__'] = primary_key  # 主键属性名
		attrs['__fields__'] = fields  # 除主键外的属性名
		attrs['__select__'] = 'select `%s`, %s from `%s`' % (primary_key, ', '.join(escaped_fields), table_name)
		attrs['__insert__'] = 'insert into `%s` (%s, `%s`) values (%s)' % \
			(table_name, ', '.join(escaped_fields), primary_key, create_args_string(len(escaped_fields) + 1))
		attrs['__update__'] = 'update `%s` set %s where `%s`=?' % \
			(table_name, ', '.join(map(lambda f: '`%s`=?' % (mappings.get(f).name or f), fields)), primary_key)
		attrs['__delete__'] = 'delete from `%s` where `%s`=?' % (table_name, primary_key)
		return type.__new__(mcs, name, bases, attrs)


# 定义所有ORM映射的基类
class Model(dict, metaclass=ModelMetaclass):

	def __init__(self, **kw):
		super(Model, self).__init__(**kw)

	def __getattr__(self, key):
		try:
			return self[key]
		except KeyError:
			raise AttributeError(r"'Model' object has no attribute '%s'" % key)

	def __setattr__(self, key, value):
		self[key] = value

	def get_value(self, key, value):
		return getattr(self, key, None)

	def get_value_isnone(self, key):
		value = getattr(self, key, None)
		if value is None:
			field = self.__mappings__[key]
			if field.default is not None:
				value = field.default() if callable(field.default) else field.default
				logging.debug('using default value for %s: %s' % (key, str(value)))
				setattr(self, key, value)
		return value

	async def save(self):
		args = list(map(self.get_value_isnone(), self.__fields__))
		args.append(self.get_value_isnone(self.__primary_key__))
		rows = await execute(self.__insert__, args)
		if rows != 1:
			logging.warn('failed to insert record: affected rows: %s' % rows)

	async def update(self):
		args = list(map(self.get_value(), self.__fields__))
		args.append(self.get_value(self.__primary_key__))
		rows = await execute(self.__update__, args)
		if rows != 1:
			logging.warn('failed to update by primary key: affected rows: %s' % rows)

	async def remove(self):
		args = [self.getValue(self.__primary_key__)]
		rows = await execute(self.__delete__, args)
		if rows != 1:
			logging.warn('failed to remove by primary key: affected rows: %s' % rows)

	@classmethod
	async def find(cls, pk):
		""" find object by primary key. """
		rs = await select('%s where `%s`=?' % (cls.__select__, cls.__primary_key__), [pk], 1)
		if len(rs) == 0:
			return None
		return cls(**rs[0])

	@classmethod
	async def find_all(cls, where=None, args=None, **kw):
		""" find objects by where clause. """
		sql = [cls.__select__]
		if where:
			sql.append('where')
			sql.append(where)
		if args is None:
			args = []
		order_by = kw.get('orderBy', None)
		if order_by:
			sql.append('order by')
			sql.append(order_by)
		limit = kw.get('limit', None)
		if limit is not None:
			sql.append('limit')
			if isinstance(limit, int):
				sql.append('?')
				args.append(limit)
			elif isinstance(limit, tuple) and len(limit) == 2:
				sql.append('?, ?')
				args.extend(limit)
			else:
				raise ValueError('Invalid limit value: %s' % str(limit))
		rs = await select(' '.join(sql), args)
		return [cls(**r) for r in rs]

	@classmethod
	async def find_number(cls, select_field, where=None, args=None):
		""" find number by select and where. """
		sql = ['select %s _num_ from `%s`' % (select_field, cls.__table__)]
		if where:
			sql.append('where')
			sql.append(where)
		rs = await select(' '.join(sql), args, 1)
		if len(rs) == 0:
			return None
		return rs[0]['_num_']
