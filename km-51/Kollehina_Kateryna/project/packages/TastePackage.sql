CREATE OR REPLACE PACKAGE taste_package IS
    TYPE T_Taste IS RECORD (
       taste_name VARCHAR2(20 CHAR)
    );

    TYPE T_Taste_TABLE IS TABLE OF T_Taste;

    PROCEDURE add_taste (
        tastename   IN         Taste.taste_name%TYPE
    );

    PROCEDURE del_taste (
        tastename   IN         Taste.taste_name%TYPE
    );
    FUNCTION get_taste
      RETURN T_Taste_TABLE PIPELINED;
END taste_package;
/

CREATE OR REPLACE PACKAGE BODY taste_package IS

    PROCEDURE add_taste (
        tastename   IN         Taste.taste_name%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO Taste (
            taste_name
        ) VALUES (
            tastename
        );

        COMMIT;
    END add_taste;

   PROCEDURE del_taste(tastename   IN         Taste.taste_name%TYPE) AS
    BEGIN
      DELETE FROM Taste
             WHERE Taste.taste_name = tastename;

    COMMIT;
    END;

    FUNCTION get_taste
      RETURN T_Taste_TABLE PIPELINED AS
      CURSOR MY_CURSOR IS
        SELECT *
        FROM Taste;
      BEGIN
        FOR REC IN MY_CURSOR
        LOOP
          PIPE ROW (REC);
        END LOOP;
      END;

END taste_package;
/
select * from table ( taste_package.get_taste());
select * from Taste;
CALL taste_package.del_taste('sweet');
select * from Taste;
