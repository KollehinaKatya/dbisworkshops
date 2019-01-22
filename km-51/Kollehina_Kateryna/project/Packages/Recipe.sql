CREATE OR REPLACE PACKAGE recipe_package AS
--    TYPE t_recipe IS RECORD (
--        user_email VARCHAR2(40 CHAR),
--        recipe_name VARCHAR2(20 CHAR),
--        product_name VARCHAR2(200 CHAR),
--        recipe_id INTEGER
--    );
--    TYPE t_recipe_table IS
--        TABLE OF t_recipe;
    TYPE recipe_prod_name_row IS RECORD (
        recipe_name VARCHAR2(20 CHAR),
        product_name VARCHAR2(200 CHAR)
    );
    TYPE recipe_prod_name_table IS
        TABLE OF recipe_prod_name_row;
    PROCEDURE add_recipe (
        email         IN            recipe.user_email%TYPE,
        recipename    IN            recipe.recipe_name%TYPE,
        productname   IN            recipe.product_name%TYPE,
        recipeid      IN            recipe.recipe_id%TYPE
    );

    PROCEDURE delete_recipe (
        recipeid   IN         recipe.recipe_id%TYPE
    );

    PROCEDURE update_recipe_name (
        recipename   IN           recipe.recipe_name%TYPE,
        recipeid     IN           recipe.recipe_id%TYPE
    );

    PROCEDURE update_recipe_ingred (
        productname   IN            recipe.product_name%TYPE,
        recipeid      IN            recipe.recipe_id%TYPE
    );

    FUNCTION get_recipe_prod_name (
        tastename   IN          level_of_taste.taste_name%TYPE
    ) RETURN recipe_prod_name_table
        PIPELINED;

END;
/

CREATE OR REPLACE PACKAGE BODY recipe_package AS

    PROCEDURE add_recipe (
        email         IN            recipe.user_email%TYPE,
        recipename    IN            recipe.recipe_name%TYPE,
        productname   IN            recipe.product_name%TYPE,
        recipeid      IN            recipe.recipe_id%TYPE
    ) AS
    BEGIN
        INSERT INTO recipe (
            user_email,
            recipe_name,
            product_name,
            recipe_id
        ) VALUES (
            email,
            recipename,
            productname,
            recipeid
        );

    END;

    PROCEDURE delete_recipe (
        recipeid   IN         recipe.recipe_id%TYPE
    ) AS
    BEGIN
        DELETE FROM recipe
        WHERE
            recipe.recipe_id = recipeid;

        COMMIT;
    END;

    PROCEDURE update_recipe_name (
        recipename   IN           recipe.recipe_name%TYPE,
        recipeid     IN           recipe.recipe_id%TYPE
    ) AS
    BEGIN
        UPDATE recipe
        SET
            recipe.recipe_name = recipename
        WHERE
            recipe.recipe_id = recipeid;

        COMMIT;
    END update_recipe_name;

--    FUNCTION get_recipe_by_taste (
--        tastename   IN          taste.taste_name%TYPE
--    ) RETURN t_recipe_table
--        PIPELINED
--    AS
--
--        CURSOR my_cur IS
--        SELECT
--            *
--        FROM
--            recipe
--            JOIN level_of_taste ON recipe.recipe_id = level_of_taste.recipe_id
--            JOIN taste ON level_of_taste.taste_name = taste.taste_name
--        WHERE
--            taste.taste_name = tastename;
--
--    BEGIN
--        FOR curr IN my_cur LOOP
--            PIPE ROW ( curr );
--        END LOOP;
--    END;

    PROCEDURE update_recipe_ingred (
        productname   IN            recipe.product_name%TYPE,
        recipeid      IN            recipe.recipe_id%TYPE
    ) AS
    BEGIN
        UPDATE recipe
        SET
            recipe.product_name = productname
        WHERE
            recipe.recipe_id = recipeid;

        COMMIT;
    END update_recipe_ingred;

    FUNCTION get_recipe_prod_name (
        tastename   IN          level_of_taste.taste_name%TYPE
    ) RETURN recipe_prod_name_table
        PIPELINED
    IS
    BEGIN
        FOR curr IN (
            SELECT
                recipe.recipe_name,
                recipe.product_name
            FROM
                recipe
                JOIN level_of_taste ON recipe.recipe_id = level_of_taste.recipe_id
            WHERE
                level_of_taste.taste_name = tastename
        ) LOOP
            PIPE ROW ( curr );
        END LOOP;
    END get_recipe_prod_name;

END recipe_package;
--
--SELECT
--    *
--FROM
--    TABLE ( recipe_package.get_recipe() );
--
--SELECT
--    *
--FROM
--    recipe;
--
--CALL recipe_package.add_recipe('telesh@gmail.com', 'OnionSoup', 'Onion, carrot', '2');
--
--CALL recipe_package.update_recipe_name('New1OnionSoup', '2');
--
--CALL recipe_package.update_recipe_ingred('Onion', '2');
--
--CALL recipe_package.delete_recipe('2');
--
--SELECT
--    *
--FROM
--    recipe;