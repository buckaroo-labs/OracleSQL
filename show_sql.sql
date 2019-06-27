set pagesize 50000
set linesize 200 wrap on
set long 500000
set head off
set verify off
spool _sql.txt
select
max(sa.sql_text) as sqltext
from v$process p,
v$session s,
v$sqlarea sa
where p.addr=s.paddr
and s.username is not null
and s.sql_address=sa.address(+)
and s.sql_hash_value=sa.hash_value(+)
and sa.sql_id='&1';
spool off
prompt ed _sql.txt