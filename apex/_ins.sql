-- *** APEX ***
PROMPT *** APEX Installation ***

set serveroutput on size unlimited;
declare
  l_workspace_id apex_workspaces.workspace_id%type;
begin
  select workspace_id
  into l_workspace_id
  from apex_workspaces
  where workspace = upper('JRIMBLAS');

  apex_application_install.set_application_id(125);
  apex_application_install.set_schema('JORGE');
  apex_application_install.set_workspace_id(l_workspace_id);
  apex_application_install.generate_offset;
end;
/

@f89361.sql