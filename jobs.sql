set lines 120
col job for 9999 
col what for A80
col priv_user for A10
col broken A1
select job, priv_user, what, broken from dba_jobs
order by 1
/
