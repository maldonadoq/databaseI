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

ev = [["Bueno",4],["Muy bueno",5],["Regular",3],["Me sorprende",4],["Investiga un poco mas",2],["Esplicaciones claras",3]]

#############################
query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(1)
cur.execute(query)
comp = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(2)
cur.execute(query)
fisi = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(3)
cur.execute(query)
mate = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(4)
cur.execute(query)
civi = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(5)
cur.execute(query)
soci = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(6)
cur.execute(query)
psic = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(7)
cur.execute(query)
meca = cur.fetchall()

query = "SELECT id_revisor FROM esp_revisor WHERE id_campo='%s';"%(8)
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


query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(1)
cur.execute(query)
comp1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(2)
cur.execute(query)
fisi1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(3)
cur.execute(query)
mate1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(4)
cur.execute(query)
civi1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(5)
cur.execute(query)
soci1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(6)
cur.execute(query)
psic1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(7)
cur.execute(query)
meca1 = cur.fetchall()

query = "SELECT id_director FROM esp_director WHERE id_campo='%s';"%(8)
cur.execute(query)
elec1 = cur.fetchall()

def direc(idr):
	if idr==1:
		return comp1[randint(0,len(comp1)-1)][0]
	elif idr==2:
		return fisi1[randint(0,len(fisi1)-1)][0]
	elif idr==3:
		return mate1[randint(0,len(mate1)-1)][0]
	elif idr==4:
		return civi1[randint(0,len(civi1)-1)][0]
	elif idr==5:
		return soci1[randint(0,len(soci1)-1)][0]
	elif idr==6:
		return psic1[randint(0,len(psic1)-1)][0]
	elif idr==7:
		return meca1[randint(0,len(meca1)-1)][0]
	elif idr==8:
		return elec1[randint(0,len(elec1)-1)][0]

end = (time.time()-start_time)/60
print("%s minutos| primer calculo" %end)


start_time = time.time()
con = 0
id_evaluacion = 800000
id_md = 800001
contad = 0
while id_md<=1000000:
	query = "SELECT año FROM md WHERE id_md='%s';"%(id_md)
	cur.execute(query)
	result = cur.fetchall()
	fecha = result[0][0] + timedelta(days=randint(0,10), hours=randint(0,24), minutes=randint(0,59), seconds=randint(0,59))

	query = "SELECT id_autor FROM libro_autor WHERE id_md='%s';"%(id_md)
	cur.execute(query)
	result = cur.fetchall()
	id_autor = result[randint(0,len(result)-1)][0]

	query = "SELECT id_campo FROM md_campo WHERE id_md='%s';"%(id_md)
	cur.execute(query)
	result = cur.fetchall()
	id_campo = result[0][0]

	id_director = direc(id_campo)

	query = "INSERT INTO enviar(id_autor,id_md,id_director,fecha) VALUES('%s','%s','%s','%s');"%(id_autor,id_md,id_director,fecha)
	cur.execute(query)

	query1 = "INSERT INTO eval_cabecera(id_evaluacion,id_md, id_director,fecha) VALUES('%s','%s','%s','%s');"%(id_evaluacion,id_md,id_director,fecha)
	cur.execute(query1)

	result = espr(id_campo)

	ra = randint(0,len(result)-3)
	t = randint(0,len(ev)-1)
	query = "INSERT INTO eval_detalle(id_evaluacion,id_revisor,comentario,nota) VALUES('%s','%s','%s','%s');"%(id_evaluacion,result[ra][0],ev[t][0],ev[t][1])
	cur.execute(query)
	
	t = randint(0,len(ev)-1)
	query = "INSERT INTO eval_detalle(id_evaluacion,id_revisor,comentario,nota) VALUES('%s','%s','%s','%s');"%(id_evaluacion,result[ra+1][0],ev[t][0],ev[t][1])
	cur.execute(query)
	
	t = randint(0,len(ev)-1)
	query = "INSERT INTO eval_detalle(id_evaluacion,id_revisor,comentario,nota) VALUES('%s','%s','%s','%s');"%(id_evaluacion,result[ra+2][0],ev[t][0],ev[t][1])
	cur.execute(query)

	id_evaluacion+=1
	id_md += 1

conn.commit()
conn.close()

end = (time.time()-start_time)/60
print("%s minutos" %end)