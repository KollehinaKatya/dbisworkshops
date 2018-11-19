/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     11/19/2018 9:46:28 PM                        */
/*==============================================================*/


alter table Level_of_taste
   drop constraint FK_LEVEL_OF_FK_RECIPE_RECIPE;

alter table Level_of_taste
   drop constraint FK_LEVEL_OF_FK_TASTE__TASTE;

alter table Like
   drop constraint FK_LIKE_FK_FAVOUR_TASTE;

alter table Like
   drop constraint FK_LIKE_FK_FAVOUR_USER;

alter table Recipe
   drop constraint FK_RECIPE_FK_AUTHOR_USER;

alter table Recipe
   drop constraint FK_RECIPE_FK_RECIPE_PRODUCT;

alter table Wishlist
   drop constraint FK_WISHLIST_FK_WISHLI_RECIPE;

alter table Wishlist
   drop constraint FK_WISHLIST_FK_WISHLI_USER;

drop index taste_has_recipe_FK;

drop index recipe_ has_taste_FK;

drop table Level_of_taste cascade constraints;

drop index favourite_tastes_FK;

drop index favourite_tastes2_FK;

drop table Like cascade constraints;

drop table Product cascade constraints;

drop index author_FK;

drop index recipe_has_product_FK;

drop table Recipe cascade constraints;

drop table Taste cascade constraints;

drop table User cascade constraints;

drop index wishlist_FK;

drop index wishlist2_FK;

drop table Wishlist cascade constraints;

/*==============================================================*/
/* Table: Level_of_taste                                        */
/*==============================================================*/
create table Level_of_taste 
(
   taste_name           VARCHAR2(20)         not null,
   recipe_id            INTEGER              not null,
   level_of_taste       NUMBER               not null,
   constraint PK_LEVEL_OF_TASTE primary key (taste_name, recipe_id)
);

/*==============================================================*/
/* Index: recipe_ has_taste_FK                                */
/*==============================================================*/
create index recipe_ has_taste_FK on Level_of_taste (
   recipe_id ASC
);

/*==============================================================*/
/* Index: taste_has_recipe_FK                                   */
/*==============================================================*/
create index taste_has_recipe_FK on Level_of_taste (
   taste_name ASC
);

/*==============================================================*/
/* Table: Like                                                */
/*==============================================================*/
create table Like 
(
   taste_name           VARCHAR2(20)         not null,
   user_email           VARCHAR2(40)         not null,
   constraint PK_LIKE primary key (taste_name, user_email)
);

/*==============================================================*/
/* Index: favourite_tastes2_FK                                  */
/*==============================================================*/
create index favourite_tastes2_FK on Like (
   user_email ASC
);

/*==============================================================*/
/* Index: favourite_tastes_FK                                   */
/*==============================================================*/
create index favourite_tastes_FK on Like (
   taste_name ASC
);

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
create table Product 
(
   product_name         VARCHAR2(20)         not null,
   constraint PK_PRODUCT primary key (product_name)
);

/*==============================================================*/
/* Table: Recipe                                                */
/*==============================================================*/
create table Recipe 
(
   user_email           VARCHAR2(40)         not null,
   recipe_name          VARCHAR2(20)         not null,
   product_name         VARCHAR2(20)         not null,
   recipe_count_of_product NUMBER,
   recipe_id            INTEGER              not null,
   constraint PK_RECIPE primary key (recipe_id)
);

/*==============================================================*/
/* Index: recipe_has_product_FK                                 */
/*==============================================================*/
create index recipe_has_product_FK on Recipe (
   product_name ASC
);

/*==============================================================*/
/* Index: author_FK                                             */
/*==============================================================*/
create index author_FK on Recipe (
   user_email ASC
);

/*==============================================================*/
/* Table: Taste                                                 */
/*==============================================================*/
create table Taste 
(
   taste_name           VARCHAR2(20)         not null,
   constraint PK_TASTE primary key (taste_name)
);

/*==============================================================*/
/* Table: User                                                */
/*==============================================================*/
create table User 
(
   user_name            VARCHAR2(20)         not null,
   user_email           VARCHAR2(40)         not null,
   constraint PK_USER primary key (user_email)
);

/*==============================================================*/
/* Table: Wishlist                                              */
/*==============================================================*/
create table Wishlist 
(
   recipe_id            INTEGER              not null,
   user_email           VARCHAR2(40)         not null,
   constraint PK_WISHLIST primary key (recipe_id, user_email)
);

/*==============================================================*/
/* Index: wishlist2_FK                                          */
/*==============================================================*/
create index wishlist2_FK on Wishlist (
   user_email ASC
);

/*==============================================================*/
/* Index: wishlist_FK                                           */
/*==============================================================*/
create index wishlist_FK on Wishlist (
   recipe_id ASC
);

alter table Level_of_taste
   add constraint FK_LEVEL_OF_FK_RECIPE_RECIPE foreign key (recipe_id)
      references Recipe (recipe_id);

alter table Level_of_taste
   add constraint FK_LEVEL_OF_FK_TASTE__TASTE foreign key (taste_name)
      references Taste (taste_name);

alter table Like
   add constraint FK_LIKE_FK_FAVOUR_TASTE foreign key (taste_name)
      references Taste (taste_name);

alter table Like
   add constraint FK_LIKE_FK_FAVOUR_USER foreign key (user_email)
      references User (user_email);

alter table Recipe
   add constraint FK_RECIPE_FK_AUTHOR_USER foreign key (user_email)
      references User (user_email);

alter table Recipe
   add constraint FK_RECIPE_FK_RECIPE_PRODUCT foreign key (product_name)
      references Product (product_name);

alter table Wishlist
   add constraint FK_WISHLIST_FK_WISHLI_RECIPE foreign key (recipe_id)
      references Recipe (recipe_id);

alter table Wishlist
   add constraint FK_WISHLIST_FK_WISHLI_USER foreign key (user_email)
      references User (user_email);


ALTER TABLE User
  ADD CONSTRAINT email_unique UNIQUE (user_email);
ALTER TABLE Taste
  ADD CONSTRAINT taste_unique UNIQUE (taste_name);
ALTER TABLE Product
  ADD CONSTRAINT product_unique UNIQUE (product_name);

ALTER TABLE User
  ADD CONSTRAINT check_name 
  CHECK (REGEXP_LIKE(user_name,'[A-Z][a-z]{1,19}','c'));
ALTER TABLE User
  ADD CONSTRAINT check_email
  CHECK ( REGEXP_LIKE (user_email, '[a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$'));
ALTER TABLE Recipe
  ADD CONSTRAINT check_name 
  CHECK (REGEXP_LIKE(recipe_name,'[A-Z][a-z]{1,19}','c'));
ALTER TABLE Product
  ADD CONSTRAINT check_name 
  CHECK (REGEXP_LIKE(product_name,'[A-Z][a-z]{1,19}','c'));
ALTER TABLE Taste
  ADD CONSTRAINT check_name 
  CHECK (REGEXP_LIKE(taste_name,'[A-Z][a-z]{1,19}','c'));
ALTER TABLE Level_of_taste
  ADD CONSTRAINT check_level_of_taste 
  CHECK (REGEXP_LIKE(level_of_taste,'^0+(\.[0-9]{1,2})?$'));