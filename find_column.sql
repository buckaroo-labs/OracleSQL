select owner, table_name, column_name
from dba_tab_columns
where column_name like upper('%&1%')
and table_name not like 'BIN$%'
/
