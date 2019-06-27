set lines 200
col "Index Operation" for a60 trunc
col "ETA Mins" format 999.99
col "Runtime Mins" format 999.99
select sess.sid as "Session ID", sql.sql_text as "Index Operation",
longops.totalwork, longops.sofar, 
longops.elapsed_seconds/60 as "Runtime Mins",
longops.time_remaining/60 as "ETA Mins"
from v$session sess, v$sql sql, v$session_longops longops
where
sess.sid=longops.sid
and sess.sql_address = sql.address
and sess.sql_address = longops.sql_address
and sess.status  = 'ACTIVE'
and longops.totalwork > longops.sofar
and sess.sid not in ( SELECT sys_context('USERENV', 'SID') SID  FROM DUAL)
and upper(sql.sql_text) like '%INDEX%'
order by 3, 4