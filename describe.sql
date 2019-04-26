set feedback off
PROMPT
PROMPT Table Comments:
select atc.comments
from all_tab_comments atc 
where atc.table_name = upper('&&1')
and atc.comments is not null
/
PROMPT
PROMPT Column Comments:
select acc.column_name, acc.comments
from all_col_comments acc, all_tables at
where at.table_name = acc.table_name
and at.table_name = upper('&1')
and acc.comments is not null
and at.owner not like 'SYS%'
and acc.column_name not like 'INS_%'
and acc.column_name not like 'UPD_%'
/
PROMPT
PROMPT Column Constraints:
select c.constraint_name, ac.constraint_type, substr(c.column_name,1,30) col_name
from all_cons_columns c, all_constraints  ac
where c.table_name = upper('&1')
and c.constraint_name  = ac.constraint_name 
and ac.owner = c.owner
/
PROMPT
PROMPT Column Indexes:
select index_name, column_name, column_position 
from all_ind_columns 
where table_name = upper('&1')
/
select f.table_name as "Dependent Tables"
from all_constraints c, all_constraints f
where f.r_constraint_name = c.constraint_name
and c.table_name = upper('&1')
/
PROMPT
undefine 1
set feedback on