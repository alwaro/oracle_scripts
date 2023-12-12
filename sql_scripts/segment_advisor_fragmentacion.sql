-- ===============================================================
-- NAME: segment_advisor_fragmentacion.sql
-- DESCRIPTION: Displays an analysis from the segments of the table HEL2.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
variable id number;
begin
  declare
  name varchar2(100);
  descr varchar2(500);
  obj_id number;
  begin
  name:='ANALISIS INTTRAFICO HEL2';
  descr:='analisis segmentosTABLA HEL2';

  dbms_advisor.create_task (
    advisor_name     => 'Segment Advisor',
    task_id          => :id,
    task_name        => name,
    task_desc        => descr);

  dbms_advisor.create_object (
    task_name        => name,
    object_type      => 'TABLE',
    attr1            => 'INTTRAFICO',
    attr2            => 'HEL2',
    attr3            => NULL,
    attr4            => NULL,
    attr5            => NULL,
    object_id        => obj_id);

  dbms_advisor.set_task_parameter(
    task_name        => name,
    parameter        => 'recommend_all',
    value            => 'TRUE');

  dbms_advisor.execute_task(name);
  end;
end;
/
