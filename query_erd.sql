/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     18/10/2017 19.04.50                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_BOOK_MEMILIKI__CATEGORY') then
    alter table BOOK
       delete foreign key FK_BOOK_MEMILIKI__CATEGORY
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BOOK_IMA_MENYIMPAN_BOOK') then
    alter table BOOK_IMAGE
       delete foreign key FK_BOOK_IMA_MENYIMPAN_BOOK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DETIL_TR_MEMILIKI_TRANSACT') then
    alter table DETIL_TRANSACTION
       delete foreign key FK_DETIL_TR_MEMILIKI_TRANSACT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DETIL_TR_MEMPUNYAI_BOOK') then
    alter table DETIL_TRANSACTION
       delete foreign key FK_DETIL_TR_MEMPUNYAI_BOOK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EMPLOYEE_MEMPUNYAI_STORE') then
    alter table EMPLOYEE
       delete foreign key FK_EMPLOYEE_MEMPUNYAI_STORE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSACT_MELAKUKAN_EMPLOYEE') then
    alter table TRANSACTION
       delete foreign key FK_TRANSACT_MELAKUKAN_EMPLOYEE
end if;

drop index if exists BOOK.MEMILIKI_1_FK;

drop index if exists BOOK.BOOK_PK;

drop table if exists BOOK;

drop index if exists BOOK_IMAGE.MENYIMPAN_FK;

drop table if exists BOOK_IMAGE;

drop index if exists CATEGORY.CATEGORY_PK;

drop table if exists CATEGORY;

drop index if exists DETIL_TRANSACTION.MEMPUNYAI_FK;

drop index if exists DETIL_TRANSACTION.MEMILIKI_FK;

drop index if exists DETIL_TRANSACTION.DETIL_TRANSACTION_PK;

drop table if exists DETIL_TRANSACTION;

drop index if exists EMPLOYEE.MEMPUNYAI_1_FK;

drop index if exists EMPLOYEE.EMPLOYEE_PK;

drop table if exists EMPLOYEE;

drop index if exists STORE.STORE_PK;

drop table if exists STORE;

drop index if exists TRANSACTION.MELAKUKAN_FK;

drop index if exists TRANSACTION.TRANSACTION_PK;

drop table if exists TRANSACTION;

/*==============================================================*/
/* Table: BOOK                                                  */
/*==============================================================*/
create table BOOK 
(
   BOOK_ID              integer                        not null,
   CATEGORY_ID          integer                        null,
   ISBN                 varchar(20)                    null,
   BOOK_TITLE           varchar(35)                    null,
   AUTHOR               varchar(25)                    null,
   PUBLISHER            varchar(25)                    null,
   PRICE_BEFORE         float                          null,
   PRICE_AFTER          float                          null,
   DISCOUNT             float                          null,
   LOCATION             varchar(20)                    null,
   PROFIT               float                          null,
   constraint PK_BOOK primary key (BOOK_ID)
);

/*==============================================================*/
/* Index: BOOK_PK                                               */
/*==============================================================*/
create unique index BOOK_PK on BOOK (
BOOK_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_1_FK                                         */
/*==============================================================*/
create index MEMILIKI_1_FK on BOOK (
CATEGORY_ID ASC
);

/*==============================================================*/
/* Table: BOOK_IMAGE                                            */
/*==============================================================*/
create table BOOK_IMAGE 
(
   BOOK_ID              integer                        null,
   BOOKIMAGE_ID         integer                        null,
   IMAGE_DESC           varchar(50)                    null,
   IMAGE_ADD            varchar(50)                    null
);

/*==============================================================*/
/* Index: MENYIMPAN_FK                                          */
/*==============================================================*/
create index MENYIMPAN_FK on BOOK_IMAGE (
BOOK_ID ASC
);

/*==============================================================*/
/* Table: CATEGORY                                              */
/*==============================================================*/
create table CATEGORY 
(
   CATEGORY_ID          integer                        not null,
   CATEGORY_NAME        varchar(20)                    null,
   CATEGORY_DESC        varchar(50)                    null,
   constraint PK_CATEGORY primary key (CATEGORY_ID)
);

/*==============================================================*/
/* Index: CATEGORY_PK                                           */
/*==============================================================*/
create unique index CATEGORY_PK on CATEGORY (
CATEGORY_ID ASC
);

/*==============================================================*/
/* Table: DETIL_TRANSACTION                                     */
/*==============================================================*/
create table DETIL_TRANSACTION 
(
   DETIL_ID             integer                        not null,
   TRANSACTION_ID       integer                        null,
   BOOK_ID              integer                        null,
   QUANTITY             float                          null,
   UNIT_PRICE           float                          null,
   DISCOUNT             float                          null,
   constraint PK_DETIL_TRANSACTION primary key (DETIL_ID)
);

/*==============================================================*/
/* Index: DETIL_TRANSACTION_PK                                  */
/*==============================================================*/
create unique index DETIL_TRANSACTION_PK on DETIL_TRANSACTION (
DETIL_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_FK                                           */
/*==============================================================*/
create index MEMILIKI_FK on DETIL_TRANSACTION (
TRANSACTION_ID ASC
);

/*==============================================================*/
/* Index: MEMPUNYAI_FK                                          */
/*==============================================================*/
create index MEMPUNYAI_FK on DETIL_TRANSACTION (
BOOK_ID ASC
);

/*==============================================================*/
/* Table: EMPLOYEE                                              */
/*==============================================================*/
create table EMPLOYEE 
(
   EMPLOYEE_ID          integer                        not null,
   STORE_ID             integer                        null,
   EMPLOYEE_NAME        varchar(25)                    null,
   EMPLOYEE_UNAME       varchar(10)                    null,
   PASSWORD             varchar(8)                     null,
   ROLE                 varchar(10)                    null,
   STATUS               integer                        null,
   constraint PK_EMPLOYEE primary key (EMPLOYEE_ID)
);

/*==============================================================*/
/* Index: EMPLOYEE_PK                                           */
/*==============================================================*/
create unique index EMPLOYEE_PK on EMPLOYEE (
EMPLOYEE_ID ASC
);

/*==============================================================*/
/* Index: MEMPUNYAI_1_FK                                        */
/*==============================================================*/
create index MEMPUNYAI_1_FK on EMPLOYEE (
STORE_ID ASC
);

/*==============================================================*/
/* Table: STORE                                                 */
/*==============================================================*/
create table STORE 
(
   STORE_ID             integer                        not null,
   STORE_NAME           varchar(20)                    null,
   ADDRESS              varchar(35)                    null,
   NPWP                 varchar(25)                    null,
   POST_CODE            varchar(10)                    null,
   EMAIL                varchar(20)                    null,
   IMAGE                varchar(50)                    null,
   constraint PK_STORE primary key (STORE_ID)
);

/*==============================================================*/
/* Index: STORE_PK                                              */
/*==============================================================*/
create unique index STORE_PK on STORE (
STORE_ID ASC
);

/*==============================================================*/
/* Table: TRANSACTION                                           */
/*==============================================================*/
create table TRANSACTION 
(
   TRANSACTION_ID       integer                        not null,
   EMPLOYEE_ID          integer                        null,
   "DATE"               date                           null,
   constraint PK_TRANSACTION primary key (TRANSACTION_ID)
);

/*==============================================================*/
/* Index: TRANSACTION_PK                                        */
/*==============================================================*/
create unique index TRANSACTION_PK on TRANSACTION (
TRANSACTION_ID ASC
);

/*==============================================================*/
/* Index: MELAKUKAN_FK                                          */
/*==============================================================*/
create index MELAKUKAN_FK on TRANSACTION (
EMPLOYEE_ID ASC
);

alter table BOOK
   add constraint FK_BOOK_MEMILIKI__CATEGORY foreign key (CATEGORY_ID)
      references CATEGORY (CATEGORY_ID)
      on update restrict
      on delete restrict;

alter table BOOK_IMAGE
   add constraint FK_BOOK_IMA_MENYIMPAN_BOOK foreign key (BOOK_ID)
      references BOOK (BOOK_ID)
      on update restrict
      on delete restrict;

alter table DETIL_TRANSACTION
   add constraint FK_DETIL_TR_MEMILIKI_TRANSACT foreign key (TRANSACTION_ID)
      references TRANSACTION (TRANSACTION_ID)
      on update restrict
      on delete restrict;

alter table DETIL_TRANSACTION
   add constraint FK_DETIL_TR_MEMPUNYAI_BOOK foreign key (BOOK_ID)
      references BOOK (BOOK_ID)
      on update restrict
      on delete restrict;

alter table EMPLOYEE
   add constraint FK_EMPLOYEE_MEMPUNYAI_STORE foreign key (STORE_ID)
      references STORE (STORE_ID)
      on update restrict
      on delete restrict;

alter table TRANSACTION
   add constraint FK_TRANSACT_MELAKUKAN_EMPLOYEE foreign key (EMPLOYEE_ID)
      references EMPLOYEE (EMPLOYEE_ID)
      on update restrict
      on delete restrict;

