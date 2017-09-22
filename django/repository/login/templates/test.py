#!/usr/bin/python
import psycopg2
try:
    conn = psycopg2.connect("dbname='test' user='maldonado' host='localhost' password='maldonado'")
    print "I am connecting"
except:
    print "I am unable to connect to the database"

cur = conn.cursor()
cur.execute("""SELECT * from md""")
rows = cur.fetchall()
print "test:"
for row in rows:
    print row

conn.close()