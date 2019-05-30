select  to_char(startup_time,'DD-MON-YY HH24:MI:SS') start_time, to_char(sysdate,'DD-MON-YY HH24:MI:SS') current_time 
from v$instance;

