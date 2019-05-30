set lines 200
col text for A200
select text from dba_source where owner || '.' || name =upper('&1')
and line =&2
/
