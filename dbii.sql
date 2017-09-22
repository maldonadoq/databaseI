select
	au.id_user,
	usa.nombre,
	md.id_md
	--md.titulo
from 
	public.md
inner join libro_autor as la on la.id_md = md.id_md
inner join autor as au on au.id_autor = la.id_autor
inner join usuarios as usa on usa.id_user = au.id_user
order by md.estado desc;