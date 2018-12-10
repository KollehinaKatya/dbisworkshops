CREATE OR REPLACE PACKAGE USER_PACKAGE AS
  TYPE T_USER IS RECORD (
  user_name VARCHAR2(20 CHAR),
  user_email VARCHAR2(40 CHAR)
  );

  TYPE T_USER_TABLE IS TABLE OF T_USER;

  FUNCTION login(USERNAME IN Userr.user_name%TYPE, EMAIL IN Userr.user_email%TYPE)
    RETURN T_USER_TABLE PIPELINED;

  PROCEDURE RegisterUser(USERNAME IN Userr.user_name%TYPE,
                     EMAIL IN Userr.user_email%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY USER_PACKAGE AS
  FUNCTION login(USERNAME IN Userr.user_name%TYPE, EMAIL IN Userr.user_email%TYPE)
    RETURN T_USER_TABLE PIPELINED AS
    CURSOR MY_CUR IS
      SELECT *
      FROM Userr
        WHERE Userr.user_name = USERNAME
              AND Userr.user_email = EMAIL;
    BEGIN
      FOR rec IN MY_CUR
      LOOP
        pipe row (rec);
      end loop;
    END;

  PROCEDURE RegisterUser(USERNAME IN Userr.user_name%TYPE, EMAIL IN Userr.user_email%TYPE) AS
    BEGIN
      INSERT INTO Userr(user_name, user_email) VALUES (USERNAME, EMAIL);
    END;
END ;
/

SELECT * FROM Table (USER_PACKAGE.login('Katya', 'katkollehina@gmail.com'));