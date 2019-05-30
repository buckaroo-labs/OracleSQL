set pages 0
spool _privs.sql
select 'grant ' || privilege || ' on ' || owner || '.' ||
table_name || ' to ' || grantee || 
decode(grantable,'YES',' with grant option ','')
||';'
from dba_tab_privs where upper(&1) like upper('&2')
order by owner, table_name, privilege, grantee
/
spool off
set pages 50

prompt @_privs.sql