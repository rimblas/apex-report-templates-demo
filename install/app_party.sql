create table app_party 
( id number not null enable, 
  first_name varchar2(100), 
  middle_name varchar2(100), 
  last_name varchar2(100), 
  company_name varchar2(100), 
  email1_type varchar2(10), 
  email1 varchar2(100), 
  email2_type varchar2(10), 
  email2 varchar2(100), 
  email3_type varchar2(10), 
  email3 varchar2(100), 
  phone1_type varchar2(10), 
  phone1 varchar2(25), 
  phone2_type varchar2(10), 
  phone2 varchar2(25), 
  phone3_type varchar2(10), 
  phone3 varchar2(25), 
  created_by varchar2(60) not null enable, 
  created_on date not null enable, 
  updated_by varchar2(60), 
  updated_on date, 
   primary key (id) using index  enable
)
/

create sequence app_party_seq start with 100;

create or replace trigger app_party_iu
before insert or update
on app_party
referencing old as old new as new
for each row
begin
  if inserting then
    if :new.id is null then
      :new.id := app_party_seq.nextval;
    end if;
    :new.created_on := sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
  elsif updating then
    :new.updated_on := sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  end if;
end;
/


REM INSERTING into APP_PARTY
SET DEFINE OFF;
Insert into APP_PARTY (ID,FIRST_NAME,MIDDLE_NAME,LAST_NAME,COMPANY_NAME,EMAIL1_TYPE,EMAIL1,EMAIL2_TYPE,EMAIL2,EMAIL3_TYPE,EMAIL3,PHONE1_TYPE,PHONE1,PHONE2_TYPE,PHONE2,PHONE3_TYPE,PHONE3) values (41,'James','D.','Halpert','Dunder','PERSONAL','TheMan@company.com',null,null,null,null,'MAIN','555 1212','DIRECT',null,null,null);
Insert into APP_PARTY (ID,FIRST_NAME,MIDDLE_NAME,LAST_NAME,COMPANY_NAME,EMAIL1_TYPE,EMAIL1,EMAIL2_TYPE,EMAIL2,EMAIL3_TYPE,EMAIL3,PHONE1_TYPE,PHONE1,PHONE2_TYPE,PHONE2,PHONE3_TYPE,PHONE3) values (21,'Dwight',null,'Schrute','Dunder','PERSONAL','TheSilentNinja@SchruteFarms.com','MAIN','dschrute@dm.us',null,null,'MAIN','800 555-1212',null,null,null,null);
Insert into APP_PARTY (ID,FIRST_NAME,MIDDLE_NAME,LAST_NAME,COMPANY_NAME,EMAIL1_TYPE,EMAIL1,EMAIL2_TYPE,EMAIL2,EMAIL3_TYPE,EMAIL3,PHONE1_TYPE,PHONE1,PHONE2_TYPE,PHONE2,PHONE3_TYPE,PHONE3) values (1,'Michael',null,'Scott','Dunder','DIRECT','michael.scott@dm.us','PERSONAL','mike@gmail.com',null,null,'DIRECT','800 555-1212','PERSONAL','952 555-1212','FAX','1234567');

