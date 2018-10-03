-- create tables
create table sessions (
    id                             number generated by default on null as identity  
                                   constraint sessions_id_pk primary key,
    session_start                  date,
    session_end                    date,
    track                          varchar2(4000),
    track_color                    varchar2(4000),
    title                          varchar2(4000),
    location                       varchar2(4000),
    created_on                     date not null,
    created_by                     varchar2(255) not null,
    updated_on                     date not null,
    updated_by                     varchar2(255) not null
)
;


-- triggers
create or replace trigger sessions_biu
    before insert or update 
    on sessions
    for each row
begin
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated_on := sysdate;
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);
end sessions_biu;
/

-- load data
 
-- Generated by Quick SQL Tuesday June 12, 2018  13:31:43
 
/*
sessions
  session_start d
  session_end d
  title
  location
  track

# settings = { auditCols: true, language: "EN", APEX: true, createdCol: "created_on", updatedCol: "updated_on" }
*/
