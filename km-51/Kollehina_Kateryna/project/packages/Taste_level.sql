CREATE OR REPLACE PACKAGE taste_level_package IS
    TYPE T_taste_level IS RECORD (
     recipe_id INTEGER,
     taste_name VARCHAR2(20 CHAR),
     level_of_taste DECIMAL
    );

    TYPE T_Level_TABLE IS TABLE OF T_Level;
    PROCEDURE add_taste_level (
        recipe_id   IN         Level_of_taste.recipe_id%TYPE,
        taste_name   IN        Level_of_taste.taste_name%TYPE,
	taste_level   IN       Level_of_taste.level_of_taste%TYPE
    );

    PROCEDURE del_taste_level (
        recipe_id   IN         Level_of_taste.recipe_id%TYPE,
        taste_name   IN        Level_of_taste.taste_name%TYPE
    );

    PROCEDURE update_taste_level (
        recipe_id   IN         Level_of_taste.recipe_id%TYPE,
        taste_name   IN        Level_of_taste.taste_name%TYPE,
	taste_level   IN       Level_of_taste.level_of_taste%TYPE
    );
    FUNCTION  get_level
     RETURN T_Level_TABLE PIPELINED;

END taste_level_package;
/

CREATE OR REPLACE PACKAGE BODY taste_level_package IS

    PROCEDURE add_taste_level (
        recipe_id   IN         Level_of_taste.recipe_id%TYPE,
        taste_name   IN        Level_of_taste.taste_name%TYPE,
	taste_level   IN       Level_of_taste.level_of_taste%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO Level_of_taste (
            recipe_id,
            taste_name,
            level_of_taste

        ) VALUES (
            recipe_id,
            taste_name,
            taste_level
        );

        COMMIT;
    END add_taste_level;

    PROCEDURE del_taste_level (
                 recipe_id   IN         Level_of_taste.recipe_id%TYPE,
       		 taste_name   IN        Level_of_taste.taste_name%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        DELETE FROM Level_of_taste
        WHERE
            Level_of_taste.taste_name = taste_name AND Level_of_taste.recipe_id = recipe_id;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE value_error;
    END del_taste_level;

    PROCEDURE update_taste_level (
        recipe_id   IN         Level_of_taste.recipe_id%TYPE,
        taste_name   IN        Level_of_taste.taste_name%TYPE,
	taste_level   IN       Level_of_taste.level_of_taste%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        UPDATE Level_of_taste
        SET
            Level_of_taste.level_of_taste = taste_level
        WHERE
            Level_of_taste.taste_name = taste_name AND Level_of_taste.recipe_id = recipe_id;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE value_error;
    END update_taste_level;
    
    FUNCTION get_level
      RETURN T_Level_TABLE PIPELINED AS
      CURSOR MY_CURSOR IS
        SELECT *
        FROM Level_of_taste;
      BEGIN
        FOR REC IN MY_CURSOR
        LOOP
          PIPE ROW (REC);
        END LOOP;
      END;

END taste_level_package;