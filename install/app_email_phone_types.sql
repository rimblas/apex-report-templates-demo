create table app_email_phone_types 
( id number not null enable, 
  display_seq number not null enable, 
  entry_type varchar2(10) not null enable, 
  code varchar2(20) not null enable, 
  name varchar2(60) not null enable, 
  active_ind varchar2(1) not null enable, 
  created_by varchar2(60) not null enable, 
  created_on date not null enable, 
  updated_by varchar2(60), 
  updated_on date, 
   constraint app_email_phone_typ_ck_active check (active_ind in ('Y', 'N')) enable, 
   primary key (id) using index  enable
)
/
create unique index app_email_phone_types_u01 on app_email_phone_types (entry_type, code)
/
create sequence app_email_phone_types_seq start with 10;

create or replace trigger app_email_phone_types_iu 
before insert or update
on app_email_phone_types
referencing old as old new as new
for each row
begin
  if inserting then
    if :new.id is null then
      :new.id := app_email_phone_types_seq.nextval;
    end if;
    :new.created_on := sysdate;
    :new.created_by := nvl(v('APP_USER'),user);
  elsif updating then
    :new.updated_on := sysdate;
    :new.updated_by := nvl(v('APP_USER'),user);
  end if;
end;
/

insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (1, 10, 'PHONE','MAIN','Main','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (2, 20, 'PHONE','DIRECT','Direct','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (3, 30, 'PHONE','PERSONAL','Personal','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (4, 40, 'PHONE','CELL','Cell','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (5, 50, 'PHONE','FAX','Fax','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (6, 60, 'EMAIL','MAIN','Main','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (7, 70, 'EMAIL','DIRECT','Direct','Y');
insert into app_email_phone_types(id,display_seq,entry_type,code,name,active_ind) values (8, 80, 'EMAIL','PERSONAL','Personal','Y');
