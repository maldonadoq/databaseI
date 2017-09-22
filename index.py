#!/usr/bin/python
# coding=utf-8
import psycopg2
import sys
import time
import random
from datetime import datetime, timedelta
from random import randint

try:
    conn = psycopg2.connect("dbname='test' user='maldonado' host='localhost' password='maldonado'")
    print "I am connecting"
except:
    print "I am unable to connect to the database"

cur = conn.cursor()
start_time = time.time()

inicio = datetime(1997,01,30)
final =  datetime(2017,05,28)


#############################
query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(1)
cur.execute(query)
comp = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(2)
cur.execute(query)
fisi = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(3)
cur.execute(query)
mate = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(4)
cur.execute(query)
civi = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(5)
cur.execute(query)
soci = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(6)
cur.execute(query)
psic = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(7)
cur.execute(query)
meca = cur.fetchall()

query = "SELECT id_autor FROM esp_autor WHERE id_campo='%s';"%(8)
cur.execute(query)
elec = cur.fetchall()

def espr(idr):
	if idr==1:
		return comp
	elif idr==2:
		return fisi
	elif idr==3:
		return mate
	elif idr==4:
		return civi
	elif idr==5:
		return soci
	elif idr==6:
		return psic
	elif idr==7:
		return meca
	elif idr==8:
		return elec



id_md = 21
while id_md<=800000:
	query =  "SELECT id_campo FROM md_campo WHERE id_md='%s';"%(id_md)
	cur.execute(query)
	result = cur.fetchall()
	id_campo = result[0][0]

	result = espr(id_campo)
	id_autor = result[randint(0,len(result)-1)][0]

	query =  "INSERT INTO libro_autor(id_autor, id_md) VALUES (%s,%s);"%(id_autor,id_md)
	cur.execute(query)
	id_md+=1

conn.commit()
conn.close()
#falta 200000 repetidos
end = (time.time()-start_time)/60
print("%s minutos" %end)