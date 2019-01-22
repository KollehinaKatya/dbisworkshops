CREATE OR REPLACE PACKAGE LIKE_PACKAGE AS
  TYPE T_LIKES IS RECORD (
  taste_name VARCHAR2(20 CHAR),
  user_email VARCHAR2(40 CHAR)
  );

  TYPE T_LIKES_TABLE IS TABLE OF T_LIKES;

  PROCEDURE add_like( 
        tastename   IN       Likes.taste_name%TYPE,
        useremail   IN       Likes.user_email%TYPE );

  PROCEDURE del_like (
        tastename   IN       Likes.taste_name%TYPE,
        useremail   IN       Likes.user_email%TYPE  );
    FUNCTION get_like
      RETURN T_Likes_TABLE PIPELINED;

END like_package;
/

CREATE OR REPLACE PACKAGE BODY like_package IS

  PROCEDURE add_like( tastename   IN       Likes.taste_name%TYPE,
                      useremail   IN       Likes.user_email%TYPE ) AS
    BEGIN
      INSERT INTO Likes (taste_name, user_email) 
                  VALUES (tastename, useremail);
    END add_like;

  PROCEDURE del_like (
        tastename   IN       Likes.taste_name%TYPE,
        useremail   IN       Likes.user_email%TYPE 
    ) IS
        PRAGMA autonomous_transaction;
     BEGIN
        DELETE FROM Likes
        WHERE
            Likes.taste_name = tastename AND Likes.user_email = useremail;
        COMMIT;
     END del_like;
    
    FUNCTION get_like
      RETURN T_Likes_TABLE PIPELINED AS
      CURSOR MY_CURSOR IS
        SELECT *
        FROM Likes;
      BEGIN
        FOR REC IN MY_CURSOR
        LOOP
          PIPE ROW (REC);
        END LOOP;
      END;


END like_package;
/
select * from table ( like_package.get_like( ));
select * from likes;
CALL like_package.add_like('sweet', 'telesh@gmail.com');
CALL like_package.del_like('spicy', 'kravchuk@gmail.com');
select * from likes;
