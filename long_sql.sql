select a.sid,
a.serial#,
a.username,
to_char(sysdate-a.last_call_et/24/60/60,'hh24:mi:ss') started,
trunc(a.last_call_et/60) || ' mins, ' ||
mod(a.last_call_et,60) || ' secs' dur,
a.machine,
a.schemaname,
b.sql_text
from v$sql b, v$session a
where a.username is not null
and a.last_call_et > 1*60
and a.status = 'ACTIVE'
and a.sql_address = b.address
--and b.sql_text like '%&sql_text%'