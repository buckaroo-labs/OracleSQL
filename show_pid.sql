prompt "Please Enter The UNIX Process ID"
set pagesize 50000
set linesize 30000
set long 500000
set head off
select
s.username su,
substr(sa.sql_text,1,540) txt
from v$process p,
v$session s,
v$sqlarea sa
where p.addr=s.paddr
and s.username is not null
and s.sql_address=sa.address(+)
and s.sql_hash_value=sa.hash_value(+)
and spid=&SPID;