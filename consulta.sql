/*-- autores con sus md $
select
	au.id_user,
	usa.nombre,
	md.id_md,
	md.titulo,
	md.estado
from 
	public.md
inner join libro_autor as la on la.id_md = md.id_md
inner join autor as au on au.id_autor = la.id_autor
inner join usuarios as usa on usa.id_user = au.id_user
order by md.estado desc;*/



/*-- todos los revisores que han revisado md en el año 2016 en computer science $
select
  	usr.nombre as "revisor",
  	md.titulo,
  	ec.fecha,
  	cm.nombre as "especialidad de md"
from
  	public.eval_cabecera as ec

inner join eval_detalle as ed on ec.id_evaluacion = ed.id_evaluacion
inner join revisor as re on re.id_revisor = ed.id_revisor
inner join usuarios as usr on usr.id_user = re.id_user
inner join md on md.id_md = ec.id_md
inner join md_campo as mdc on mdc.id_md = md.id_md
inner join campos as cm on mdc.id_campo = cm.id_campo and 
cm.nombre = 'Computer Science' and
ec.fecha between '2016-01-01' and '2016-12-31' 
order by ec.fecha asc
limit 4;

-- los 4 autores primeros con sus respectivos materiales, el campo del autor y del md y no mayor a las fecha '2016-06-10' $
select 
	usa.nombre,
	cma.nombre as "especilidad autor",
	md.titulo,
	ec.fecha,
	cmd.nombre as "especilidad md"
from
	public.eval_cabecera as ec

inner join md on md.id_md = ec.id_md
inner join libro_autor as la on la.id_md = md.id_md
inner join autor as au on au.id_autor = la.id_autor
inner join usuarios as usa on usa.id_user = au.id_user
inner join md_campo as mc on mc.id_md = md.id_md
inner join campos as cmd on cmd.id_campo = mc.id_campo
inner join esp_autor as esa on esa.id_autor = au.id_autor
inner join campos as cma on esa.id_campo = cma.id_campo
and ec.fecha<='2016-06-10'
order by ec.fecha,md.titulo
limit 4;

-- todos los autores con nota mayor a 10, en el mes de abril, autor, titulo del md, fecha, director
select 
	--sum(coalesce(ed.nota,0)) as "nota total",
	--ec.id_md,
	usa.nombre as "autor",
	md.titulo,
	cm.nombre as "especilidad md",
	ec.fecha,
	usd.nombre as "director"
from
	public.eval_cabecera as ec

inner join md on md.id_md = ec.id_md
inner join libro_autor as la on la.id_md = md.id_md
inner join autor as au on au.id_autor = la.id_autor
inner join usuarios as usa on usa.id_user = au.id_user
inner join md_campo as mc on mc.id_md = md.id_md
inner join campos as cm on cm.id_campo = mc.id_campo
inner join dir_editorial as dir on dir.id_director = ec.id_director
inner join usuarios as usd on usd.id_user = dir.id_user
and cm.nombre='Computer Science'
--inner join eval_detalle as ed on ec.id_evaluacion=ed.id_evaluacion
--group by ec.id_md
--order by "nota total" asc
order by md.titulo
limit 2;

-- mostrar los 3 md qu han sido revisado por usuarios que empiezan con M.| y con buena nota
select 
	usr.nombre as "revisor",
	md.titulo,
	ed.comentario,
	ed.nota,
	ec.fecha as "fecha de aisgnacion"
from 
	public.eval_cabecera as ec
inner join eval_detalle as ed on ed.id_evaluacion = ec.id_evaluacion
inner join revisor as re on re.id_revisor = ed.id_revisor
inner join usuarios as usr on usr.id_user = re.id_user
inner join md on md.id_md = ec.id_md
and ed.nota>=4
and usr.nombre like 'J%'
order by ed.nota desc
limit 3;

-- 2 primeros usuarios que han comprado md en el area de fisica entre el año 2016 $
select 
	mda.id_user,
	usc.nombre as "comprador",
	md.titulo,
	mda.fecha as "fecha de compra",
	cm.nombre as "especilidad"
from
	public.libro_autor as la
inner join md on md.id_md = la.id_md
inner join md_campo as mdc on mdc.id_md = md.id_md
inner join campos as cm on cm.id_campo = mdc.id_campo
inner join md_adquirido as mda on mda.id_md = md.id_md
inner join usuarios as usc on usc.id_user = mda.id_user and
cm.nombre = 'Fisica Pura' and
mda.fecha between '2016-01-01' and '2016-12-31'
order by mda.fecha desc
limit 2;
*/



/*--md con nota mayor igual a 3 $
select 
	(usa.nombre || ' ' || usa.apellido) as "autor",
	md.titulo as "titulo",
	avg(ed.nota) as "nota total"
	--concat_ws(usa.nombre,usa.apellido) as "autor"
	
from
	public.eval_cabecera as ec
inner join eval_detalle as ed on ec.id_evaluacion=ed.id_evaluacion
inner join md on md.id_md = ec.id_md
inner join libro_autor as la on la.id_md = ec.id_md
inner join autor as au on au.id_autor = la.id_autor
inner join usuarios as usa on usa.id_user = au.id_user
group by md.id_md, autor
having avg(ed.nota)>=3
order by autor, titulo desc
limit 4;

-- numero de publicaciones por autor en el area de computer science
-- y de estas solo los que tienen de 1 a mas publicaciones $
select
	(usa.nombre || ' ' || usa.apellido) as "autor",
	count(md.id_md) as "publicaciones"
from
	public.libro_autor as la
inner join autor as au on au.id_autor = la.id_autor
inner join md on md.id_md = la.id_md
inner join usuarios as usa on usa.id_user = au.id_user
inner join md_campo as mdc on mdc.id_md = md.id_md
inner join campos as cmp on cmp.id_campo = mdc.id_campo
where cmp.nombre = 'Computer Science'
group by "autor",usa.id_user
having count(md.id_md)>=1
order by "publicaciones" desc;

-- director por especialidad que tiene mayor numero de md %
select 
	cmp.id_campo as "campo",
	usd.nombre as "director",
	cmp.nombre as "especialidad",
	count(md.id_md) as "numero de md"
from 
	public.md
inner join md_campo as mdc on mdc.id_md = md.id_md
inner join campos as cmp on cmp.id_campo = mdc.id_campo
inner join esp_director as espd on espd.id_campo = cmp.id_campo
inner join dir_editorial as dir on dir.id_director = espd.id_director
inner join usuarios as usd on usd.id_user = dir.id_user
group by cmp.id_campo, usd.id_user
having count(md.id_md) between 2 and 10
order by count(md.id_md) desc
limit 1;

-- numero de busquedas hechas por un usuarios en el area de FP, 
-- en el mes de Octubre $
select
	us.id_user as "ID user",
	(us.nombre || ' ' || us.apellido) as "usuario",
	cmp.nombre as "especialidad",
	count(hb.id_user) as "busquedas"
from
	public.usuarios as us
inner join h_busqueda as hb on us.id_user = hb.id_user
inner join md_campo as mdc on mdc.id_md = hb.id_md
inner join campos as cmp on cmp.id_campo = mdc.id_campo
where
	cmp.nombre = 'Fisica Pura' and
	hb.fecha between '2016-10-01' and '2016-10-31'
group by us.id_user, cmp.id_campo
order by us.nombre;

-- numero de ventas por especialidad en el año 2016, y de estos solo especialidades con 2 a mas ventas
select 
	count(cmp.id_campo) as "md comprados",
	cmp.nombre as "especialidad"
from
	public.md
inner join md_adquirido as mda on mda.id_md = md.id_md
inner join md_campo as mdc on mdc.id_md =  mda.id_md
inner join campos as cmp on cmp.id_campo = mdc.id_campo
where mda.fecha between '2016-01-01' and '2016-12-31'
group by cmp.id_campo
having count(cmp.id_campo)>=2
order by "md comprados" desc
limit 4;*/

/*
-- autor con numero de todas sus publicaciones y sus md comprados
with tab1 as(
	select 
		autor.id_user,
		count(autor.id_user) as md
	from public.autor
	inner join libro_autor as la on la.id_autor = autor.id_autor
	inner join md on md.id_md = la.id_md
	group by autor.id_user
	), tab2 as(
	select 
		usu.id_user,
		count(usu.id_user) as cmp
	from public.usuarios as usu
	inner join md_adquirido as mda on mda.id_user = usu.id_user
	group by usu.id_user
	)
select 
	usu.id_user,
	(usu.nombre || ' ' || usu.apellido) as "usuario",
	pub.md as "md publicados",	
	comp.cmp as "md comprados"
from tab2 as comp
inner join tab1 as pub on pub.id_user = comp.id_user
inner join usuarios as usu on usu.id_user = comp.id_user;

-- usuarios con todos sus md comprados y hb  del un determinado campo
select
	tab1.id_user,
	tab1.usuario,
	cmp.nombre as "especialidad",
	tab1.bus as "buscados",
	tab2.con as "comprados"
from
	(select	
		us.id_user,
		(us.nombre || ' ' || us.apellido) as usuario,
		count(us.id_user) as bus,
		mdc.id_campo as cam1
	from h_busqueda as hb
	inner join usuarios as us on us.id_user = hb.id_user
	inner join md_campo as mdc on mdc.id_md = hb.id_md
	group by us.id_user, cam1
	) tab1 
inner join
	(select 
		us.id_user,
		count(us.id_user) as con,
		mdc.id_campo as cam2
	from public.usuarios as us
	inner join md_adquirido as mda on mda.id_user = us.id_user
	inner join md_campo as mdc on mdc.id_md = mda.id_md
	group by us.id_user, cam2
	) tab2
	on (tab1.id_user = tab2.id_user and tab1.cam1 = tab2.cam2)
inner join campos as cmp on cmp.id_campo = tab1.cam1
and cmp.nombre = 'Fisica Pura';

-- promedio de las notas por cada area
create temp table tab1 as(
select
	mdc.id_campo,
	count(mdc.id_campo) as nmd
from public.eval_cabecera as evc
inner join md_campo as mdc on mdc.id_md = evc.id_md
group by mdc.id_campo
);

create temp table tab2 as(
select 
	esr.id_campo,
	avg(evd.nota) as pr
from revisor as re
inner join eval_detalle as evd on evd.id_revisor = re.id_revisor
inner join esp_revisor as esr on re.id_revisor = esr.id_revisor
group by esr.id_campo
);

select 
	cmp.id_campo,
	cmp.nombre,
	tab1.nmd as md,
	tab2.pr as promedio
from tab1
inner join tab2 on tab1.id_campo = tab2.id_campo
inner join campos as cmp on cmp.id_campo = tab1.id_campo
order by promedio desc
limit 5;
drop table tab1;
drop table tab2;

-- numero de autores y revisores por especialidad
with tab1 as(
select 
	esa.id_campo,
	count(esa.id_campo) as autores
from autor as au
inner join esp_autor as esa on esa.id_autor = au.id_autor
group by esa.id_campo
), tab2 as(
select 
	esr.id_campo,
	count(esr.id_campo) as revisores
from revisor as re
inner join esp_revisor as esr on esr.id_revisor = re.id_revisor
group by esr.id_campo
)
select 
	cmp.id_campo,
	cmp.nombre as especialidad,
	tab1.autores,
	tab2.revisores
from tab1
inner join tab2 on tab1.id_campo = tab2.id_campo
inner join campos as cmp on cmp.id_campo = tab1.id_campo
order by cmp.nombre;

-- numero de envios en el 2016 por cada especialidad
create temp table tab1 as(
select 
	mdc.id_campo,
	env.id_envio,
	to_char(env.fecha,'Month') as mes,
	extract(year from env.fecha) as año
from enviar as env
inner join md_campo as mdc on mdc.id_md = env.id_md
);

select 
	tab1.año,
	tab1.mes,
	cmp.nombre,
	count(tab1.mes) as envios
from tab1
inner join campos as cmp on cmp.id_campo = tab1.id_campo
group by tab1.mes,tab1.año,cmp.nombre
having tab1.año = '2016'
order by tab1.mes, cmp.nombre;
drop table tab1;

select *from public.maut_md_mdc();
select *from public.mautor_md();
select *from public.maut_rev_esp();
select *from public.mbus_us('Computer Science','2016-01-01','2016-12-01');
select *from public.mmd_not(2,4);
select *from public.mnmd_dir_esp(2,8);
select *from public.mpr_autor('2016-10-01',4);
select *from public.mpri_comp('Fisica Pura','2016-01-01','2016-12-01',5);
select *from public.mpub_aut_are('Computer Science',4);
select *from public.mrev_act('2016-01-01','2016-12-01','Fisica Pura',4);
*/

/*create or replace function who_delete()
returns trigger as
$$
declare 
begin 
	insert into "delete"(id_user,who,fecha)
	values(old.id_user,session_user,now());
	return null;
end;
$$
language plpgsql
--create trigger delete_user before delete on usuarios for each row execute procedure who_delete();*/

/*create or replace function update_md()
returns trigger as
$$
declare 
begin
	if old.titulo <> new.titulo then
		insert into "update_md"(id_md,campo,old,new,fecha)
		values(old.id_md,'titulo',old.titulo,new.titulo,now());
	end if;
	if old.citas <> new.citas then
		insert into "update_md"(id_md,campo,old,new,fecha)
			values(old.id_md,'citas',old.citas,new.citas,now());
	end if;
	if old.precio <> new.precio then
		insert into "update_md"(id_md,campo,old,new,fecha)
			values(old.id_md,'precio',old.precio,new.precio,now());
	end if;
	return new;
end;
$$
language plpgsql
--create trigger update_md_trigger before update on md for each row execute procedure update_md();*/

/*create or replace function update_campo()
returns trigger as
$$
declare 
begin
	if old.nombre <> new.nombre then
		insert into"update_campo"(id_campo,campo,old,new,who,fecha)
		values(old.id_campo,'nombre',old.nombre,new.nombre,session_user,now());
	end if;
	if old.descripcion <> new.descripcion then
		insert into"update_campo"(id_campo,campo,old,new,who,fecha)
		values(old.id_campo,'descripcion',old.descripcion,new.descripcion,session_user,now());
	end if;
	return new;
end;
$$
language plpgsql
create trigger update_campo_trigger before update on campos for each row execute procedure update_campo();*/

/*create or replace function delete_hb()
returns trigger as
$$
declare 
begin
	insert into "delete_hb"(id_user,id_md,fecha)
	values(old.id_user,old.id_md,now());
	return null;
end;
$$
language plpgsql;
create trigger delete_hb_trigger before delete on h_busqueda for each row execute procedure delete_hb();*/

/*create or replace function update_user()
returns trigger as
$$
declare 
begin
	if old.nickname <> new.nickname then
		insert into"update_user"(id_user,campo,old,new,fecha)
		values(old.id_user,'nickname',old.nickname,new.nickname,now());
	end if;
	if old.nombre <> new.nombre then
		insert into"update_user"(id_user,campo,old,new,fecha)
		values(old.id_user,'nombre',old.nombre,new.nombre,now());
	end if;
	return new;
end;
$$
language plpgsql
--create trigger update_user_trigger before update on usuarios for each row execute procedure update_user();*/



-- numero de md enviados a cada area en mayo
select 
	to_char(env.fecha,'TMMonth') as mes,
	cmp.nombre,
	count(to_char(env.fecha,'Mon'))
from public.enviar as env
inner join esp_director as esd on esd.id_director = env.id_director
inner join campos as cmp on cmp.id_campo = esd.id_campo
--where (now()-env.fecha) < 10*interval'30 day'
where (now()-env.fecha) < '300 day'
group by mes, cmp.id_campo
order by mes;

-- 2 primeros usuarios que han comprado md en el area de fisica entre el año 2016 $
select 
	mda.id_user,
	usc.nombre as "comprador",
	md.titulo,
	to_char(mda.fecha,'YYYY TMMon Dy HH24:MI:SS am') as "fecha de compra",
	cm.nombre as "especilidad"
from
	public.libro_autor as la
inner join md on md.id_md = la.id_md
inner join md_campo as mdc on mdc.id_md = md.id_md
inner join campos as cm on cm.id_campo = mdc.id_campo
inner join md_adquirido as mda on mda.id_md = md.id_md
inner join usuarios as usc on usc.id_user = mda.id_user and
cm.nombre = 'Fisica Pura' and
to_char(mda.fecha,'Mon') = 'Nov'
order by mda.fecha desc
limit 2;

--md con nota mayor igual a 3 $
select 
	(usa.nombre || ' ' || usa.apellido) as "autor",
	md.titulo as "titulo",
	round(avg(ed.nota), 2) as "nota total"
from
	public.eval_cabecera as ec
inner join eval_detalle as ed on ec.id_evaluacion=ed.id_evaluacion
inner join md on md.id_md = ec.id_md
inner join libro_autor as la on la.id_md = ec.id_md
inner join autor as au on au.id_autor = la.id_autor
inner join usuarios as usa on usa.id_user = au.id_user
group by md.id_md, autor
having avg(ed.nota)>3
order by autor, titulo desc;

-- numero de busquedas hechas por un usuarios en el area de FP, 
-- en el mes de Octubre $
select
	us.id_user as "ID user",
	(us.nombre || ' ' || us.apellido) as "usuario",
	cmp.nombre as "especialidad",
	to_char(hb.fecha,'Mon') as mes,
	count(hb.id_user) as "busquedas"
from
	public.usuarios as us
inner join h_busqueda as hb on us.id_user = hb.id_user
inner join md_campo as mdc on mdc.id_md = hb.id_md
inner join campos as cmp on cmp.id_campo = mdc.id_campo
where
	cmp.nombre = 'Fisica Pura' and
	to_char(hb.fecha,'Mon') = 'Oct'
group by us.id_user, cmp.id_campo, mes
order by us.nombre;

-- ultimo envio de todos los autores
with tab as(
	select 
		env.id_autor,
		max(env.fecha) as last
	from enviar as env
	group by env.id_autor
)
select
	us.id_user,
	(us.nombre || ' ' || us.apellido) as "usuario",
	md.titulo as "ultimo md",
	to_char(tab.last,'YYYY TMMon Dy HH24:MI:SS') as fecha
from tab
inner join enviar as env on env.id_autor = tab.id_autor and env.fecha = tab.last
inner join autor as au on au.id_autor = env.id_autor
inner join usuarios as us on us.id_user = au.id_user
inner join md on md.id_md = env.id_md
order by us.nombre;







if pswo!='' and pswn!='empty':
  cur.execute("SELECT *FROM usuarios WHERE password='%s';"%(pswo))
  user = cur.fetchall()
  for x in xrange(0,len(user)):
    if (len(user)!=0 and int(user[x][0])==int(id_user)):
      cur.execute("UPDATE usuarios SET password='%s' WHERE id_user='%s';"%(pswn,id_user))
      break