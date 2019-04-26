select substr(v$lock.sid,1,4) "SID", 
substr(username, 1, 12) "Username", 
substr(object_name, 1, 25) "ObjectName", 
v$lock.type "LockType", 
decode(rtrim(substr(lmode,1,4)), '2', 'Row-s (SS)', '3', 'Row-X (SX)', '4', 
'Share', '5', 'S/Row-X (SSX)', '6', 'Exclusive', 'Other' ) "Lockmode", 
substr(v$session.program, 1, 25) "Programname" 
from v$lock, sys.dba_objects, 
v$session 
where (object_id = v$lock.id1 and v$lock.sid = v$session.sid 
and username is not null 
and username not in ('SYS', 'SYSTEM') 
and serial# != 1); 

