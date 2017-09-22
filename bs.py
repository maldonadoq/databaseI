import psycopg2

conn_string = "host='localhost' dbname='image' user='maldonado' password='maldonado'"
conn = psycopg2.connect(conn_string)

mypic=open('/home/maldonado/Database/repository/images/feynman.jpg','rb').read()

cursor = conn.cursor()
cursor.execute("INSERT INTO imag(name,im) VALUES (%s,%s);", ('feynman', psycopg2.Binary(mypic)))
conn.commit()

cursor = conn.cursor()
cursor.execute("SELECT (im) FROM imag WHERE name='feynman';")
mypic2 = cursor.fetchone()

open('/home/maldonado/feynman.jpg', 'wb').write(str(mypic2[0]))
