--create or replace function upda(in id integer, in _nombre varchar, in _apellido varchar, in _nickname varchar, in _info_ac text, in pswo varchar, in pswn varchar)
--select *from upda(1,'Alonso','Cerpa Salas','','','','')

--drop function pass(varchar,varchar,integer,integer);
/*CREATE OR REPLACE FUNCTION pass(in pswo varchar,in pswn varchar, in id_user integer, in b integer)
RETURNS boolean AS 
$$
	import psycopg2
	
	conn = psycopg2.connect("dbname='repository' user='maldonado' host='localhost' password='maldonado'")
	cur = conn.cursor()
	cur.execute("SELECT *FROM usuarios WHERE password='%s';"%(pswo))
	user = cur.fetchall()
	for x in xrange(0,len(user)):
		if(user[x][0]==id_user):
			if b==0:
				cur.execute("UPDATE usuarios SET state='%s' WHERE id_user='%s';"%(False,id_user))
			elif b==1:
				cur.execute("UPDATE usuarios SET password='%s' WHERE id_user='%s';"%(pswn,id_user))
			conn.commit()
			return True
	return False
$$
LANGUAGE plpythonu;*/

--create or replace function md_asignar(in id_cm integer)


/*select 
	au.id_autor,
	us.nombre,
	cmp.nombre
from esp_autor as espa
inner join autor as au on au.id_autor = espa.id_autor
inner join usuarios as us on us.id_user = au.id_user
inner join campos as cmp on cmp.id_campo = espa.id_campo;

select
	dir.id_director,
	us.nombre,
	cmp.nombre
from dir_editorial as dir
inner join usuarios as us on us.id_user = dir.id_user
inner join esp_director as espd on espd.id_director = dir.id_director
inner join campos as cmp on cmp.id_campo = espd.id_campo;*/

/*insert into md(titulo, citas, precio, estado,año) 
values 
  ('Singularidades Cuánticas en el Campo Electromagnético',3,'168.50'::float8::numeric::money,0,'2002-01-02'),
  ('Discussion of Probability Relations Between Separated Systems',2,'158.65'::float8::numeric::money,0,'2002-02-03'),
  ('El universo de Georges Lemaître',4,'148.99'::float8::numeric::money,0,'2002-04-28');*/

/*	insert into enviar(id_autor,id_md, id_director, fecha)
values
	(12,14,1,'2002-01-02 15:05:48'),
	(13,15,1,'2002-03-03 18:14:45'),
	(14,16,1,'2002-05-04 15:48:06');*/
--now()

/*delete from eval_cabecera where id_evaluacion=14;
alter sequence eval_cabecera_id_evaluacion_seq restart with 14;
select *from asignar(16,1,1,2,3);*/


/*CREATE OR REPLACE FUNCTION public.revisor_md(IN id_re integer)
  RETURNS TABLE(id_md integer, titulo character varying, autor character varying, comentario character varying, nota integer, campo character varying, fecha timestamp without time zone) AS
$BODY$
	with tab as(
	select
		la.id_md,
		string_agg(us.nombre || ' ' || us.apellido, ' - ') as autor
	from libro_autor as la
	inner join autor as au on au.id_autor = la.id_autor
	inner join usuarios as us on us.id_user = au.id_user
	group by la.id_md
	)
	select
		md.id_md,
		md.titulo,
		tab.autor,
		evd.comentario,
		evd.nota,
		cmp.nombre,
		evc.fecha
	from revisor as re
	inner join eval_detalle as evd on evd.id_revisor = re.id_revisor
	inner join eval_cabecera as evc on evc.id_evaluacion = evd.id_evaluacion
	inner join md on md.id_md = evc.id_md
	inner join tab on tab.id_md = md.id_md
	inner join md_campo as mdc on mdc.id_md = md.id_md
	inner join campos as cmp on cmp.id_campo = mdc.id_campo
	and re.id_revisor = id_re
	and evd.eval_realizada=True;
$BODY$
  LANGUAGE sql VOLATILE;*/

--select *from buscar_usuarios('nombre','','','','',NULL,NULL,False,False,False,True,True);



create or replace function insert_user(nombre_ varchar, apellido_ varchar, nick_ varchar, correo_ varchar, password_ chkpass, titulo_ text) returns void
as
$$
begin
	INSERT INTO usuarios(nombre, apellido, nickname, correo, info_ac, password,fecha) VALUES(nombre_, apellido_, nick_, correo_ , titulo_, password_,now());
end;
$$ LANGUAGE plpgsql;