col privilege for A30
set verify off

select granted_role, admin_option
from dba_role_privs
where grantee=upper('&1')
order by 1;

select privilege, admin_option
from dba_sys_privs
where grantee=upper('&1')
order by 1;

select owner, privilege, count(*)
from dba_tab_privs
where grantee=upper('&1')
and table_name not like 'BIN$%'
group by owner, privilege
order by owner, privilege;

select owner, table_name, column_name, privilege
from dba_col_privs
where grantee=upper('&1')
and table_name not like 'BIN$%'
order by 1,2,3;


select object_type, count(*)
from dba_objects
where owner=upper('&1')
and object_name not like 'BIN$%'
group by object_type
order by 1;

select name, ptime 
from sys.user$
where name =upper('&1');


set verify on