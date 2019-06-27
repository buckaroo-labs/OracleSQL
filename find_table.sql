select table_name, owner from dba_tables 
where table_name like '%'||upper('&1'||'%')
/
