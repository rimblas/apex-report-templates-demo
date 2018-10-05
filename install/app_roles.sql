create table app_roles 
( id number not null enable, 
  role_key varchar2(50) not null enable, 
  name varchar2(100) not null enable, 
  description varchar2(100), 
  active_ind varchar2(1) not null enable, 
  created_by varchar2(60) not null enable, 
  created_on date not null enable, 
  updated_by varchar2(60), 
  updated_on date, 
   constraint app_roles_ck_active check (active_ind in ('Y', 'N')) enable, 
   primary key (id)
  using index  enable
)
/

create sequence app_roles_seq start with 10;

create or replace trigger app_roles_iu
before insert or update
on app_roles
referencing old as old new as new
for each row
begin
  if inserting then
    if :new.id is null then
      :new.id := app_roles_seq.nextval;
    end if;
    :new.created_on := sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
  elsif updating then
    :new.updated_on := sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  end if;
end;
/

insert into app_roles(id, role_key, name, active_ind) values (1, 'ADMIN', 'Admin', 'Y');
insert into app_roles(id, role_key, name, active_ind) values (2, 'EDIT', 'Edit', 'Y');
insert into app_roles(id, role_key, name, active_ind) values (3, 'USER', 'User', 'Y');
