--Create Users

INSERT INTO User (user_name, user_email) 
  VALUES ('Petro', 'kravchuk@gmail.com');

INSERT INTO User (user_name, user_email) 
  VALUES ('Lena', 'telesh@gmail.com');

INSERT INTO User (user_name, user_email) 
  VALUES ('Katya', 'katkollehina@gmail.com');

--Create Product
INSERT INTO Product (product_name) VALUES ('carrot');
INSERT INTO Product (product_name) VALUES ('onion');
INSERT INTO Product (product_name) VALUES ('beet');
INSERT INTO Product (product_name) VALUES ('meat');
INSERT INTO Product (product_name) VALUES ('potato');

--Add Recipe
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name, recipe_count_of_product) VALUES ('katkollehina@gmail.com', '1', 'Borsh', 'potato', '4');
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name, recipe_count_of_product) VALUES ('telesh@gmail.com', '2', 'OnionSoup', 'onion', '4');
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name, recipe_count_of_product) VALUES ('katkollehina@gmail.com', '1', 'Borsh', 'carrot', '2');

--Create Taste
INSERT INTO Taste (taste_name) VALUES ('sweet');
INSERT INTO Taste (taste_name) VALUES ('salt');
INSERT INTO Taste (taste_name) VALUES ('spicy');

--Create Level_of_taste
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('1', 'sweet', '0.3');
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('2', 'salt', '0.2');
INSERT INTO Level_of_taste (recipe_id, taste_name, level_of_taste) VALUES ('1', 'spicy', '0.1');

--Create Like
INSERT INTO Like (taste_name, user_email) VALUES ('sweet', 'katkollehina@gmail.com');
INSERT INTO Like (taste_name, user_email) VALUES ('spicy', 'kravchuk@gmail.com');
INSERT INTO Like (taste_name, user_email) VALUES ('sweet', 'telesh@gmail.com');

--Create Wishlist
INSERT INTO Wishlist (recipe_id, user_email) VALUES ('1', 'telesh@gmail.com');
INSERT INTO Wishlist (recipe_id, user_email) VALUES ('2', 'katkollehina@gmail.com');
INSERT INTO Wishlist (recipe_id, user_email) VALUES ('1', 'kravchuk@gmail.com');


  

