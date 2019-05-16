set long 100000
select sql_fulltext from v$sql where sql_id='&1';