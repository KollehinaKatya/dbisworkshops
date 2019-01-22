/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     11/19/2018 9:46:28 PM                        */
/*==============================================================*/


alter table Level_of_taste
   drop constraint FK_LEVEL_OF_FK_RECIPE_RECIPE;

alter table Level_of_taste
   drop constraint FK_LEVEL_OF_FK_TASTE__TASTE;

alter table Likes
   drop constraint FK_LIKE_FK_FAVOUR_TASTE;


alter table Likes
   drop constraint FK_LIKE_FK_FAVOUR_USER;

alter table Recipe
   drop constraint FK_RECIPE_FK_AUTHOR_USER;


alter table Wishlist
   drop constraint FK_WISHLIST_FK_WISHLI_RECIPE;

alter table Wishlist
   drop constraint FK_WISHLIST_FK_WISHLI_USER;

drop index taste_has_recipe_FK;

drop index recipe_has_taste_FK;

drop table Level_of_taste cascade constraints;

drop index favourite_tastes_FK;

drop index favourite_tastes2_FK;

drop table Likes cascade constraints;

drop index author_FK;


drop table Recipe cascade constraints;

drop table Taste cascade constraints;

drop table Userr cascade constraints;

drop index wishlist_FK;

drop index wishlist2_FK;

drop table Wishlist cascade constraints;


/*==============================================================*/
/* Table: Level_of_taste                                        */
/*==============================================================*/

create table Level_of_taste 
(
   taste_name           VARCHAR2(20)         not null,
   recipe_id            INTEGER              not null        ,
   level_of_taste       INTEGER               not null,
   constraint PK_LEVEL_OF_TASTE primary key (taste_name, recipe_id)
);

/*==============================================================*/
/* Index: recipe_ has_taste_FK                                */
/*==============================================================*/
create index recipe_has_taste_FK on Level_of_taste (
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
create table Likes 
(
   taste_name           VARCHAR2(20)         not null,
   user_email           VARCHAR2(40)         not null,
   constraint PK_LIKE primary key (taste_name, user_email)
);

/*==============================================================*/
/* Index: favourite_tastes2_FK                                  */
/*==============================================================*/
create index favourite_tastes2_FK on Likes (
   user_email ASC
);

/*==============================================================*/
/* Index: favourite_tastes_FK                                   */
/*==============================================================*/
create index favourite_tastes_FK on Likes (
   taste_name ASC
);

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/

create table Recipe 
(
   user_email           VARCHAR2(40)         not null,
   recipe_name          VARCHAR2(20)         not null,
   product_name         VARCHAR2(200)         not null,
   recipe_id            INTEGER              not null,
   constraint PK_RECIPE primary key (recipe_id)
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
create table Userr 
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
      references Recipe (recipe_id)on delete cascade;

alter table Level_of_taste
   add constraint FK_LEVEL_OF_FK_TASTE__TASTE foreign key (taste_name)
      references Taste (taste_name)on delete cascade;

alter table Likes
   add constraint FK_LIKE_FK_FAVOUR_TASTE foreign key (taste_name)
      references Taste (taste_name) on delete cascade;

alter table Likes
   add constraint FK_LIKE_FK_FAVOUR_USER foreign key (user_email)
      references Userr (user_email) ;

alter table Recipe
   add constraint FK_RECIPE_FK_AUTHOR_USER foreign key (user_email)
      references Userr (user_email);


alter table Wishlist
   add constraint FK_WISHLIST_FK_WISHLI_RECIPE foreign key (recipe_id)
      references Recipe (recipe_id)on delete cascade ;

alter table Wishlist
   add constraint FK_WISHLIST_FK_WISHLI_USER foreign key (user_email)
      references Userr (user_email);


ALTER TABLE Userr
  ADD CONSTRAINT email_unique UNIQUE (user_email);
ALTER TABLE Taste
  ADD CONSTRAINT taste_unique UNIQUE (taste_name);

ALTER TABLE Recipe
  ADD CONSTRAINT recipe_id_unique UNIQUE (recipe_id);

ALTER TABLE Userr
  ADD CONSTRAINT check_name 
  CHECK (REGEXP_LIKE(user_name,'[A-Z]{0,1}[a-z]{1,19}','c'));
ALTER TABLE Userr
  ADD CONSTRAINT check_email
  CHECK ( REGEXP_LIKE (user_email, '[A-Za-z0-9._]+@[A-Za-z0-9._]+\.[a-z]{2,4}'));
ALTER TABLE Recipe
  ADD CONSTRAINT check_recipe_name 
  CHECK (REGEXP_LIKE(recipe_name,'[A-Z]{0,1}[a-z]{1,19}','c'));

ALTER TABLE Taste
  ADD CONSTRAINT check_taste_name 
  CHECK (REGEXP_LIKE(taste_name,'[A-Z]{0,1}[a-z]{1,19}','c'));
ALTER TABLE Level_of_taste
  ADD CONSTRAINT check_level_of_taste 
  CHECK (REGEXP_LIKE(level_of_taste,'[0-9]{1,2}'));
ALTER TABLE Level_of_taste
   Add CONSTRAINT check_level_of_taste1 check(level_of_taste > 0 AND level_of_taste <= 10 );

   
   
--Create Users

INSERT INTO Userr (user_name, user_email) 
  VALUES ('Petro', 'kravchuk@gmail.com');

INSERT INTO Userr (user_name, user_email) 
  VALUES ('Lena', 'telesh@gmail.com');

INSERT INTO Userr (user_name, user_email) 
  VALUES ('Katya', 'katkollehina@gmail.com');


--Add Recipe
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name ) VALUES ('katkollehina@gmail.com', '1', 'Borsh', 'Potato, Carrot, Onion, Beet, Meat, Tomato paste, Salt, Sugar' );
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name ) VALUES ('telesh@gmail.com', '2', 'OnionSoup', 'Onion, Yeast Extract, Caramelised Sugar, Butter (Milk), Tomato Paste, Sherry, Salt');
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name ) VALUES ('kravchuk@gmail.com', '3', 'CheeseCake', 'Biscuits, Butter, Soft cheese, Double cream, Strawberries' );
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name ) VALUES ('kravchuk@gmail.com', '4', 'Taco', 'Tomato paste, Worcestershire sauce, Chili, Paprika, Beef, Beans, Onion, Tortilla, Salt ' );



--Create Taste
INSERT INTO Taste (taste_name) VALUES ('sweet');
INSERT INTO Taste (taste_name) VALUES ('salt');
INSERT INTO Taste (taste_name) VALUES ('spicy');

--Create Level_of_taste
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('1', 'sweet', '2');
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('2', 'salt', '2');
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('2', 'sweet', '2');
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('3', 'sweet', '9');
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('4', 'spicy', '10');


--Create Like
INSERT INTO Likes (taste_name, user_email) VALUES ('sweet', 'katkollehina@gmail.com');
INSERT INTO Likes (taste_name, user_email) VALUES ('salt', 'katkollehina@gmail.com');
INSERT INTO Likes (taste_name, user_email) VALUES ('spicy', 'kravchuk@gmail.com');
INSERT INTO Likes (taste_name, user_email) VALUES ('sweet', 'telesh@gmail.com');





--Create Wishlist

INSERT INTO Wishlist (recipe_id, user_email) VALUES ('2', 'telesh@gmail.com');
INSERT INTO Wishlist (recipe_id, user_email) VALUES ('1', 'katkollehina@gmail.com');
INSERT INTO Wishlist (recipe_id, user_email) VALUES ('2', 'katkollehina@gmail.com');
INSERT INTO Wishlist (recipe_id, user_email) VALUES ('3', 'kravchuk@gmail.com');




   
