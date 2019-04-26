-- who.sql
-- Purpose: Show all user session detail (sort by OS User).
-- Created: 1996 DwR
-- Updated: 04/06/00 DwR
--          11/29/00 DwR - standardized.
--          07/17/01 DwR - increased size of Machine column
--	    09/30/03 KGH 


set linesize 1000
COL "Program" FOR A10
COL "Status" FOR A10
COL "Oracle ID" FOR A10
COL "Machine" FOR A12
COL "Idle Time" FOR A10
COL "OS User" FOR A15
COL "PID" FOR A6
COL "Session ID" FOR A8
COL "Logon Time" FOR A12
SELECT INITCAP(SUBSTR(s.status,1,8)) "Status",
       SUBSTR(s.username,1,11) "Oracle ID",
       INITCAP(SUBSTR(s.osuser,1,12)) "OS User",
       SUBSTR(p.spid,1,6) "PID",
       SUBSTR(RTRIM(TO_CHAR(s.sid)) || ',' || RTRIM(TO_CHAR(s.serial#)),1,11) "Session ID",
       SUBSTR(TO_CHAR(s.logon_time, 'MM/DD HH24:MI'),1,11) "Logon Time",
       SUBSTR(REPLACE(UPPER(DECODE(INSTR(s.program,'@'),0,DECODE(INSTR(s.program,'\'),0,s.program,substr(s.program,INSTR(s.program,'\',-1) +1,LENGTH(s.program)-INSTR(s.program,'\',-1))),substr(s.program,1,INSTR(s.program,'@') -1))),'.EXE',''),1,10) "Program",
       RTRIM(DECODE(INSTR(s.machine,'\'),0,s.machine,SUBSTR(s.machine,INSTR(s.machine,'\')+1,LENGTH(s.machine)-INSTR(s.machine,'\')))) "Machine",
       DECODE(w.seconds_in_wait,null,null,SUBSTR(TRUNC(w.seconds_in_wait/3600)||':'||LPAD(TRUNC((w.seconds_in_wait-(TRUNC(w.seconds_in_wait/3600)*3600))/60),2,'0')||':'||LPAD(MOD(w.seconds_in_wait,60),2,'0'),1,10)) "Idle Time"
  FROM v$session s, v$process p, v$session_wait w
 WHERE s.type='USER'
   AND s.username != 'ODSCOMMON'
   AND s.paddr = p.addr
   AND s.sid = w.sid(+)
   AND 'SQL*Net message from client' = w.event(+)
 ORDER BY decode(s.username,'PRODUSER',0,'LEADUSER',0,1), s.status desc, INITCAP(SUBSTR(s.osuser,1,12)), SUBSTR(s.username,1,11);

SELECT ts.stat "Status",
       tsess "Total Sessions",
       dosu "Distinct OS Users"
  FROM (SELECT COUNT(*) tsess, INITCAP(SUBSTR(status,1,8)) stat
        FROM v$session WHERE type='USER' GROUP BY status) ts,
       (SELECT COUNT(distinct(osuser)) dosu, INITCAP(SUBSTR(status,1,8)) stat
        FROM v$session WHERE type='USER' GROUP BY status) do
 WHERE ts.stat = do.stat (+)
 ORDER BY ts.stat desc;

COL "Program" FOR A25
SELECT COUNT(*) "Sessions", INITCAP(SUBSTR(status,1,8)) "Status",
       REPLACE(UPPER(DECODE(INSTR(s.program,'@'),0,DECODE(INSTR(s.program,'\'),0,s.program,substr(s.program,INSTR(s.program,'\',-1) +1,LENGTH(s.program)-INSTR(s.program,'\',-1))),substr(s.program,1,INSTR(s.program,'@') -1))),'.EXE','') "Program"
  FROM v$session s 
 WHERE type='USER'
 GROUP BY INITCAP(SUBSTR(status,1,8)), REPLACE(UPPER(DECODE(INSTR(s.program,'@'),0,DECODE(INSTR(s.program,'\'),0,s.program,substr(s.program,INSTR(s.program,'\',-1) +1,LENGTH(s.program)-INSTR(s.program,'\',-1))),substr(s.program,1,INSTR(s.program,'@') -1))),'.EXE','') 
 ORDER BY 1 desc;

spool off

