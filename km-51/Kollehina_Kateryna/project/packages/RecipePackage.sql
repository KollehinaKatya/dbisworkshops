--Add Recipe
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name, recipe_count_of_product) VALUES ('katkollehina@gmail.com', 1, 'Borsh', 'potato', '4');
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name, recipe_count_of_product) VALUES ('telesh@gmail.com', 2, 'OnionSoup', 'onion', '4');
INSERT INTO Recipe (user_email, recipe_id, recipe_name, product_name, recipe_count_of_product) VALUES ('kravchuk@gmail.com', 3, 'Borsh', 'carrot', '2');
CREATE OR REPLACE PACKAGE RECIPE_PACKAGE AS
  TYPE T_RECIPE IS RECORD (
  user_email VARCHAR2(40 CHAR),
  recipe_name VARCHAR2(20 CHAR),
  product_name VARCHAR2(20 CHAR),
  recipe_count_of_product NUMBER,
  recipe_id INTEGER
  );

  TYPE T_RECIPE_TABLE IS TABLE OF T_RECIPE;

  PROCEDURE ADD_RECIPE(EMAIL IN Recipe.user_email%TYPE, RECIPENAME IN Recipe.recipe_name%TYPE, PRODUCTNAME IN Recipe.product_name%TYPE,
                       PrCOUNT IN Recipe.recipe_count_of_product%TYPE, RECIPEID IN Recipe.recipe_id%TYPE);
  PROCEDURE DELETE_RECIPE(RECIPEID IN Recipe.recipe_id%TYPE);
  PROCEDURE UPDATE_PRODUCT(PRODUCTNAME IN Recipe.product_name%TYPE, RECIPEID IN Recipe.recipe_id%TYPE);
  PROCEDURE UPDATE_RECIPE_NAME(RECIPENAME IN Recipe.recipe_name%TYPE, RECIPEID IN Recipe.recipe_id%TYPE);
  FUNCTION GET_RECIPE
    RETURN T_RECIPE_TABLE PIPELINED;
END;
/

CREATE OR REPLACE PACKAGE BODY RECIPE_PACKAGE AS
  PROCEDURE ADD_RECIPE(EMAIL IN Recipe.user_email%TYPE, RECIPENAME IN Recipe.recipe_name%TYPE, PRODUCTNAME IN Recipe.product_name%TYPE,
                       PrCOUNT IN Recipe.recipe_count_of_product%TYPE, RECIPEID IN Recipe.recipe_id%TYPE) AS
    BEGIN
      INSERT INTO RECIPE (user_email, recipe_name, product_name, recipe_count_of_product, recipe_id) 
                  VALUES (EMAIL, RECIPENAME, PRODUCTNAME, PrCOUNT, RECIPEID);
    END;

  PROCEDURE DELETE_RECIPE(RECIPEID IN Recipe.recipe_id%TYPE) AS
    BEGIN
      DELETE FROM RECIPE
             WHERE RECIPE.recipe_id = RECIPEID;
    COMMIT;
    END;

  PROCEDURE UPDATE_PRODUCT(PRODUCTNAME IN Recipe.product_name%TYPE, RECIPEID IN Recipe.recipe_id%TYPE) AS
    BEGIN
      UPDATE RECIPE
          SET Recipe.Product_name = PRODUCTNAME
          WHERE Recipe.recipe_id = RECIPEID;        
    COMMIT;
    END UPDATE_PRODUCT;

  PROCEDURE UPDATE_RECIPE_NAME(RECIPENAME IN Recipe.recipe_name%TYPE, RECIPEID IN Recipe.recipe_id%TYPE) AS
  
    BEGIN
      UPDATE RECIPE
          SET Recipe.Recipe_name = RECIPENAME
          WHERE Recipe.recipe_id = RECIPEID;        
    COMMIT;
    END UPDATE_RECIPE_NAME;

  FUNCTION GET_RECIPE
    RETURN T_RECIPE_TABLE PIPELINED AS
    CURSOR MY_CURSOR IS
      SELECT *
      FROM RECIPE;
    BEGIN
      FOR REC IN MY_CURSOR
      LOOP
        PIPE ROW (REC);
      END LOOP;
    END;
END RECIPE_PACKAGE;
/
select * from table ( RECIPE_PACKAGE.GET_RECIPE());
select * from Recipe;
CALL RECIPE_PACKAGE.DELETE_RECIPE(2);
select * from Recipe;