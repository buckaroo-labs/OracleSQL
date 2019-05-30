set pages 200 lines 250
col username for A25
col account_status for A20
col profile for A20
col INITIAL_RSRC_CONSUMER_GROUP for A30
col default_tablespace for A20
select username, created, profile, account_status, default_tablespace, INITIAL_RSRC_CONSUMER_GROUP
from dba_users 
where regexp_like (username,'^([[:alpha:]]{2}[[:digit:]]{4})$')
or regexp_like (username,'^([[:alpha:]]{2}[[:digit:]]{3}[[:alpha:]])$')
order by 1
/

set pages 200 lines 250
col username for A25
select username, created, profile, account_status, default_tablespace, INITIAL_RSRC_CONSUMER_GROUP
from dba_users 
where username  between 'M00000' and 'M99999'
order by 1
/

set pages 200 lines 250
col username for A25
select username, created, profile, account_status, default_tablespace, INITIAL_RSRC_CONSUMER_GROUP
from dba_users 
where not (regexp_like (username,'^([[:alpha:]]{2}[[:digit:]]{4})$')
or regexp_like (username,'^([[:alpha:]]{2}[[:digit:]]{3}[[:alpha:]])$'))
and nvl(password,'x') != 'EXTERNAL'
and username not between 'M00000' and 'M99999'
and username not in (
'ANONYMOUS'
,'APPQOSSYS'
,'ATT_SHAREDO'
,'DBA_DBG'
,'DBA_MON'
,'DBSNMP'
,'DIP'
,'EXFSYS'
,'GGSUSER'
,'ORACLE_OCM'
,'OUTLN'
,'SYS'
,'SYSTEM'
,'WMSYS'
,'XDB'
,'XS$NULL'
)
order by 1
/
