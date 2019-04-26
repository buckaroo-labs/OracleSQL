select table_name, owner from all_tables 
where table_name like '%'||upper('&Table_name'||'%')
/
