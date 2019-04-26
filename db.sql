-- db.sql
-- Purpose: Show general DB info.
-- Created: 1997 DwR
-- Updated: 11/27/00 DwR - Standardized.

SELECT
 name "Database",  SUBSTR(s.machine,1,10) "Server",
 SUBSTR(user,1,13) "Current User",
 SUBSTR(TO_CHAR(sysdate, 'dd-MON-yyyy hh24:mi:ss'),1,21) "Current Date"
 FROM v$database, v$session s
 WHERE s.type='BACKGROUND'
 GROUP BY name, s.machine;
