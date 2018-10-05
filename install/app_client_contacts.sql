create table app_client_contacts 
( id number not null enable, 
  party_id number not null enable, 
  client_id number, 
  contact_role_code varchar2(30), 
  active_ind varchar2(1) not null enable, 
  created_by varchar2(60) not null enable, 
  created_on date not null enable, 
  updated_by varchar2(60), 
  updated_on date, 
   constraint app_clients_contacts_ck_active check (active_ind in ('Y', 'N')) enable, 
   primary key (id) using index  enable
)
/
create sequence app_client_contacts_seq start with 100;

create or replace trigger app_client_contacts_iu 
before insert or update
on app_client_contacts
referencing old as old new as new
for each row
begin
  if inserting then
    if :new.id is null then
      :new.id := app_client_contacts_seq.nextval;
    end if;
    :new.created_on := sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
  elsif updating then
    :new.updated_on := sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  end if;
end;
/

alter table app_client_contacts add constraint app_client_contacts_fk1 foreign key (party_id)
    references app_party (id) enable
/
alter table app_client_contacts add constraint app_client_contacts_fk2 foreign key (client_id)
    references app_clients (id) enable
/

REM INSERTING into APP_CLIENT_CONTACTS
SET DEFINE OFF;
Insert into APP_CLIENT_CONTACTS (ID,PARTY_ID,CLIENT_ID,CONTACT_ROLE_CODE,ACTIVE_IND) values (21,21,2,'ACCOUNTS','Y');
Insert into APP_CLIENT_CONTACTS (ID,PARTY_ID,CLIENT_ID,CONTACT_ROLE_CODE,ACTIVE_IND) values (1,1,2,'BOSS','Y');
Insert into APP_CLIENT_CONTACTS (ID,PARTY_ID,CLIENT_ID,CONTACT_ROLE_CODE,ACTIVE_IND) values (41,41,2,'ACCOUNTS','Y');

