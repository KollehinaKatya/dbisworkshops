CREATE OR REPLACE PACKAGE wishlist_package IS
    TYPE T_Wishlist IS RECORD (
       recipe_id INTEGER,
       user_email VARCHAR2(40 CHAR)
    );

    TYPE T_Wishlist_TABLE IS TABLE OF T_Wishlist;
    PROCEDURE add_recipe_wl (
        recipeid   IN         Wishlist.recipe_id%TYPE,
        useremail  IN         Wishlist.user_email%TYPE
    );

    PROCEDURE del_recipe_wl (
        recipeid   IN         Wishlist.recipe_id%TYPE,
        useremail  IN         Wishlist.user_email%TYPE
    );
    FUNCTION get_wishlist
      RETURN T_Wishlist_TABLE PIPELINED;

END wishlist_package;
/

CREATE OR REPLACE PACKAGE BODY wishlist_package IS

    PROCEDURE add_recipe_wl (
        recipeid   IN         Wishlist.recipe_id%TYPE,
        useremail  IN         Wishlist.user_email%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO Wishlist (
            recipe_id,
            user_email
        ) VALUES (
            recipeid,
            useremail
        );

        COMMIT;
    END add_recipe_wl;

    PROCEDURE del_recipe_wl(
        recipeid   IN         Wishlist.recipe_id%TYPE,
        useremail  IN         Wishlist.user_email%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        DELETE FROM Wishlist
        WHERE
            Wishlist.recipe_id = recipeid AND  Wishlist.user_email = useremail;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE value_error;
    END del_recipe_wl;

    FUNCTION get_wishlist
      RETURN T_Wishlist_TABLE PIPELINED AS
      CURSOR MY_CURSOR IS
        SELECT *
        FROM Wishlist;
      BEGIN
        FOR REC IN MY_CURSOR
        LOOP
          PIPE ROW (REC);
        END LOOP;
      END;

END Wishlist_package;
/
select * from table ( Wishlist_package.get_wishlist());
select * from Wishlist;
CALL Wishlist_package.del_recipe_wl('2', 'katkollehina@gmail.com');
select * from Wishlist;
CALL Wishlist_package.add_recipe_wl('3', 'katkollehina@gmail.com');
select * from Wishlist;