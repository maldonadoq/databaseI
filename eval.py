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

con = 0

ev = [["Bueno",4],["Muy bueno",5],["Regular",3],["Me sorprende",4],["Investiga un poco mas",2],["Esplicaciones claras",3]]

while con<5:
	query = "SELECT id_mdeval_cabecera"
	p = randint(80,17)
	print p
	con+=1

conn.commit()
conn.close()

end = (time.time()-start_time)/60
print("%s minutos" %end)