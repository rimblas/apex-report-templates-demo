create table app_contact_roles 
( id number not null enable, 
  display_seq number not null enable, 
  code varchar2(30) not null enable, 
  meaning varchar2(100) not null enable, 
  description varchar2(4000), 
  active_ind varchar2(1) not null enable, 
  created_by varchar2(60) not null enable, 
  created_on date not null enable, 
  updated_by varchar2(60), 
  updated_on date, 
   constraint app_contact_roles_act_ind_ck check (active_ind in ('Y', 'N')) enable, 
   PRIMARY KEY (ID) USING INDEX  ENABLE
)
/
create unique index app_contact_roles_u01 on  app_contact_roles (code, upper(meaning))
/

create sequence app_contact_roles_seq start with 10;

create or replace trigger  app_contact_roles_iu 
before insert or update
on app_contact_roles
referencing old as old new as new
for each row
begin
  if inserting then
    if :new.id is null then
      :new.id := app_contact_roles_seq.nextval;
    end if;
    :new.created_on := sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
  elsif updating then
    :new.updated_on := sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  end if;
end;
/

REM INSERTING into APP_CONTACT_ROLES
SET DEFINE OFF;
Insert into APP_CONTACT_ROLES (ID,DISPLAY_SEQ,CODE,MEANING,DESCRIPTION,ACTIVE_IND) values (1,1,'BOSS','Boss',null,'Y');
Insert into APP_CONTACT_ROLES (ID,DISPLAY_SEQ,CODE,MEANING,DESCRIPTION,ACTIVE_IND) values (2,10,'ACCOUNTS','Accounts',null,'Y');
Insert into APP_CONTACT_ROLES (ID,DISPLAY_SEQ,CODE,MEANING,DESCRIPTION,ACTIVE_IND) values (3,20,'CLAIMS','Claims',null,'Y');
Insert into APP_CONTACT_ROLES (ID,DISPLAY_SEQ,CODE,MEANING,DESCRIPTION,ACTIVE_IND) values (4,30,'MAIN','Main',null,'Y');

