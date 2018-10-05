create table app_clients
( id number not null enable, 
  parent_id number, 
  client_no varchar2(30) not null enable, 
  name varchar2(100) not null enable, 
  status_code varchar2(10) not null enable, 
  active_ind varchar2(1) not null enable, 
  location_id number, 
  comments varchar2(4000), 
  created_by varchar2(60) not null enable, 
  created_on date not null enable, 
  updated_by varchar2(60), 
  updated_on date, 
   constraint app_clients_ck_active check (active_ind in ('Y', 'N')) enable, 
   primary key (id) using index  enable
)
/
create unique index app_clients_u01 on app_clients(client_no)
/

create sequence app_clients_seq start with 200
/
create sequence app_client_no_seq start with 200
/

create or replace trigger  app_clients_iu 
before insert or update
on app_clients
referencing old as old new as new
for each row
begin
  if inserting then
    if :new.id is null then
       :new.id := app_clients_seq.nextval;
    end if;
    if :new.client_no is null then
       :new.client_no := app_client_no_seq.nextval;
    end if;
    :new.created_on := sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
  elsif updating then
    :new.updated_on := sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  end if;
end;
/

REM INSERTING into APP_CLIENTS
SET DEFINE OFF;
Insert into APP_CLIENTS (ID,PARENT_ID,CLIENT_NO,NAME,STATUS_CODE,ACTIVE_IND) values (41,null,'123','ABC Plc','Potential','Y');
Insert into APP_CLIENTS (ID,PARENT_ID,CLIENT_NO,NAME,STATUS_CODE,ACTIVE_IND) values (81,null,'test','New','Potential','N');
Insert into APP_CLIENTS (ID,PARENT_ID,CLIENT_NO,NAME,STATUS_CODE,ACTIVE_IND) values (101,null,'2','Apple','Approved','Y');
Insert into APP_CLIENTS (ID,PARENT_ID,CLIENT_NO,NAME,STATUS_CODE,ACTIVE_IND) values (161,null,'9','j','Pending','N');
Insert into APP_CLIENTS (ID,PARENT_ID,CLIENT_NO,NAME,STATUS_CODE,ACTIVE_IND) values (2,null,'1000','Acme','New','Y');

