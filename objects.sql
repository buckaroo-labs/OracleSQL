select object_name, object_type, decode(status,'VALID','',status) stat, created
, last_ddl_time from dba_objects
where upper(owner) = upper('&1')
and object_name not like 'BIN$%'
and object_type not in ('LOB','INDEX')
order by 2,1
/
