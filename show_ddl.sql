--used with @find_object
spool ddl.txt
set heading off
set verify off
set echo off
Set pages 999
set linesize 400
set long 90000
col ddl for a400
set trimspool on
select DBMS_METADATA.GET_DDL (
decode(object_type,'MATERIALIZED VIEW','MATERIALIZED_VIEW',
'DATABASE LINK','DB_LINK','TRIGGER','TRIGGER','VIEW','VIEW','FUNCTION','FUNCTION',
'SYNONYM','SYNONYM','TABLE','TABLE','PROCEDURE','PROCEDURE','INDEX','INDEX',object_type)
,object_name, owner) || ';' as ddl
from dba_objects
where owner||'.'||replace(object_type,'DATABASE LINK','DB_LINK') 
||'.'||object_name = replace(replace(upper('&1'),'MATERIALIZED_VIEW','MATERIALIZED VIEW'),'PACKAGE_BODY','PACKAGE')
/
set heading on
set verify on
spool off
prompt Spooled output to ddl.txt
