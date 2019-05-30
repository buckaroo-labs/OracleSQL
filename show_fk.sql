select owner, table_name 
from dba_constraints
where constraint_name=(select  R_CONSTRAINT_NAME
from dba_constraints
where owner || '.' || constraint_name=upper('&1'))
/
