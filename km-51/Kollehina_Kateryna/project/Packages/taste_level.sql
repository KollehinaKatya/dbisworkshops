CREATE OR REPLACE PACKAGE taste_level_package IS
    TYPE T_taste_level IS RECORD (
     recipe_id INTEGER,
     taste_name VARCHAR2(20 CHAR),
     level_of_taste INTEGER
    );

    TYPE T_Level_TABLE IS TABLE OF T_taste_level;
    PROCEDURE add_taste_level (
        recipeid   IN         Level_of_taste.recipe_id%TYPE,
        tastename   IN        Level_of_taste.taste_name%TYPE,
        tastelevel   IN       Level_of_taste.level_of_taste%TYPE
    );

    PROCEDURE del_taste_level (
        recipeid   IN         Level_of_taste.recipe_id%TYPE,
        tastename   IN        Level_of_taste.taste_name%TYPE
    );

    PROCEDURE update_taste_level (
        recipeid   IN         Level_of_taste.recipe_id%TYPE,
        tastename   IN        Level_of_taste.taste_name%TYPE,
        tastelevel   IN       Level_of_taste.level_of_taste%TYPE
    );
   FUNCTION  get_level
     RETURN T_Level_TABLE PIPELINED;
END taste_level_package;
/

CREATE OR REPLACE PACKAGE BODY taste_level_package IS

    PROCEDURE add_taste_level (
        recipeid   IN         Level_of_taste.recipe_id%TYPE,
        tastename   IN        Level_of_taste.taste_name%TYPE,
        tastelevel   IN       Level_of_taste.level_of_taste%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO Level_of_taste (
            recipe_id,
            taste_name,
            level_of_taste

        ) VALUES (
            recipeid,
            tastename,
            tastelevel
        );

        COMMIT;
    END add_taste_level;

    PROCEDURE del_taste_level (
                 recipeid   IN         Level_of_taste.recipe_id%TYPE,
                tastename   IN        Level_of_taste.taste_name%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        DELETE FROM Level_of_taste
        WHERE
            Level_of_taste.taste_name = tastename AND Level_of_taste.recipe_id = recipeid;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE value_error;
    END del_taste_level;

    PROCEDURE update_taste_level (
        recipeid   IN         Level_of_taste.recipe_id%TYPE,
        tastename   IN        Level_of_taste.taste_name%TYPE,
        tastelevel   IN       Level_of_taste.level_of_taste%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        UPDATE Level_of_taste
        SET
            Level_of_taste.level_of_taste = tastelevel
        WHERE
            Level_of_taste.taste_name = tastename AND Level_of_taste.recipe_id = recipeid;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE value_error;
    END update_taste_level;
   FUNCTION get_level
      RETURN T_Level_TABLE PIPELINED AS
      CURSOR MY_CURSOR IS
        SELECT RECIPE_ID,TASTE_NAME,LEVEL_OF_TASTE
        FROM Level_of_taste;
      BEGIN
        FOR REC IN MY_CURSOR
        LOOP
          PIPE ROW (REC);
        END LOOP;
      END get_level;
END taste_level_package;

select * from table ( taste_level_package.get_level());
select * from Level_of_taste;
CALL taste_level_package.del_taste_level('3','sweet');
CALL taste_level_package.add_Taste_level('3','sweet', '8');
CALL taste_level_package.update_taste_level('3','sweet', '10');