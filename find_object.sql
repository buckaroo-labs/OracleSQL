set verify off
select distinct  '@show_ddl ' || 
owner || '.' || replace(replace(replace(object_type,'DATABASE LINK','DB_LINK'),'MATERIALIZED VIEW','MATERIALIZED_VIEW'),'PACKAGE BODY','PACKAGE_BODY') || '.' || object_name  
owner_type_name
from dba_objects
where object_name like upper('&1')
UNION
select distinct  '@show_ddl ' || 
owner || '.INDEX.' || index_name  
from dba_indexes
where index_name like upper('&1')
order by 1
/
