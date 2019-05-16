/*

set serverout on size 999999
declare
begin
dbms_output.put_line(' ');
dbms_output.put_line('************* Start report for WAITING sessions with current SQL ***************');
for x in (select vs.inst_id, vs.sid || ',' || vs.serial# sidser, vs.sql_address, vs.sql_hash_value,
vs.last_call_et, vsw.seconds_in_wait, vsw.event, vsw.state
from gv$session_wait vsw, gv$session vs
where vsw.sid = vs.sid
and vsw.inst_id = vs.inst_id
and vs.type <> 'BACKGROUND'
)
loop
begin
for y in (select sql_text
from gv$sqltext
where address = x.sql_address
and hash_value = x.sql_hash_value
and inst_id = x.inst_id
and length(sql_text) > 10
order by piece)
loop
dbms_output.put_line(y.sql_text);
end loop;
dbms_output.put_line(' ');
end;
end loop;
dbms_output.put_line('************** End report for sessions waiting with current SQL ****************');
dbms_output.put_line(' ');
end;
/


SELECT
     S.USERNAME, S.SID, S.SERIAL#, SQL_TEXT
FROM 
  V$SESSION S,
  V$SQLTEXT_WITH_NEWLINES T
WHERE S.SQL_ID IS NOT NULL
AND S.SQL_ID = T.SQL_ID
ORDER BY S.SID,T.PIECE;
*/


set lines 200
col parsing_schema_name FOR A20
col sql_fulltext for A50
-- https://stackoverflow.com/questions/316812/top-5-time-consuming-sql-queries-in-oracle

SELECT * FROM
(SELECT
    sql_fulltext,
    sql_id, parsing_schema_name,
    elapsed_time,
    child_number,
    disk_reads,
    executions
FROM    v$sql
ORDER BY elapsed_time DESC)
WHERE ROWNUM < 10
/

--Then, you can take the sql_id and child_number of a statement and feed them into this:-
--SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('&sql_id', &child));

--See also https://docs.oracle.com/cd/B28359_01/server.111/b28275/tdppt_sqlid.htm#TDPPT144
---	"Identifying High-Load SQL Statements"