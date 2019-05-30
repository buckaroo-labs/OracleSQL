spool explain.txt
-- Remove previous execution plan.
delete from plan_table where statement_id = 'XXX';
commit;
-- Generate new execution plan.
Set Echo On
Explain Plan 
--Set Statement_ID = 'XXX' Into Plan_Table 
For
-----------------------------------------------------------------
select x.name, 
'https://tspace.web.att.com/badges/html/GetBadgeDetails.action?id=' || x.ID AS Badge_URL,
MAX(x.contact) as "Badge Owner",
LISTAGG (x.manager, ', ') WITHIN GROUP (ORDER BY x.manager) as "Badge Managers"
FROM
(
select b.name, b.id,
decode(r.name,'BadgeContact',r.attuid,null) as contact,
decode(r.name,'BadgeManager',r.attuid,null) as manager
FROM badge_user.badges b, badge_user.roles r
where b.id=r.badge_id (+)
) x GROUP BY name, id;
-----------------------------------------------------------------
/*
set lines 200 pages 150
col operation for A50 
col object for A30

select 
  substr (lpad(' ', level-1) || operation || ' (' || options || ')',1,50 ) "Operation", 
  object_name                                                              "Object"
from 
  plan_table 
start with id = 0 
connect by prior id=parent_id;
*/

SET LINESIZE 130
SET PAGESIZE 0
SELECT * FROM table(DBMS_XPLAN.DISPLAY);

spool off