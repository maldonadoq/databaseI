create or replace function update_md()
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
--create trigger update_md_trigger before update on md for each row execute procedure update_md();