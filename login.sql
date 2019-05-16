-- login.sql
-- Purpose: User Profile, invoked at startup, alters and saves SQL*Plus environment
-- Set up non-default SQL*Plus settings
define_editor='C:\Program Files (x86)\TextPad 6\TextPad.exe'
--define_editor='C:\Windows\notepad.exe'
set linesize 120
set pagesize 120
set time on
set arraysize 100
set serveroutput off
set SQLPLUSCOMPATIBILITY 9.2.0
col column_name for A30
col created_by for A15
col database for A20
col db_link for A18
col display_name for a20 tru
col grantor for A18
col grantee for A18
col host for A15
col name for A30
col privilege for A40
col object_type for A20
col object_name for A30
col owner for A15
col schema for A15
col status for a20
col username for A15
col rsrc_group for A30
col password for A20
col value for A30
col displayname for a20 tru
