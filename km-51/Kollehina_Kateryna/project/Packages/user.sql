INSERT INTO Userr (user_name, user_email) 
  VALUES ('Petro', 'kravchuk@gmail.com');

INSERT INTO Userr (user_name, user_email) 
  VALUES ('Lena', 'telesh@gmail.com');

INSERT INTO Userr (user_name, user_email) 
  VALUES ('Katya', 'katkollehina@gmail.com');


CREATE OR REPLACE PACKAGE USER_PACKAGE AS
  TYPE T_USER IS RECORD (
  user_name VARCHAR2(20 CHAR),
  user_email VARCHAR2(40 CHAR)
  );

  TYPE T_USER_TABLE IS TABLE OF T_USER;

  FUNCTION get_user( EMAIL IN Userr.user_email%TYPE)
    RETURN T_USER_TABLE PIPELINED;

  FUNCTION login( EMAIL IN Userr.user_email%TYPE)
    RETURN Number;
  function REGISTRATION(USERNAME IN Userr.user_name%TYPE,
                     EMAIL IN Userr.user_email%TYPE)
    return VARCHAR2;
  

END;
/

CREATE OR REPLACE PACKAGE BODY USER_PACKAGE AS
  FUNCTION get_user( EMAIL IN Userr.user_email%TYPE)
    RETURN T_USER_TABLE PIPELINED AS
    CURSOR MY_CUR IS
      SELECT *
      FROM Userr
        WHERE  Userr.user_email = EMAIL;
    BEGIN
      FOR rec IN MY_CUR
      LOOP
        pipe row (rec);
      end loop;
    END;
    
FUNCTION LOGIN(EMAIL IN Userr.user_email%TYPE)
    RETURN NUMBER AS
    rec NUMBER(1);
  BEGIN
    SELECT count(*)
           INTO rec
    FROM USERR
    WHERE Userr.user_email = EMAIL;

    RETURN (rec);
  END;
  
FUNCTION REGISTRATION(USERNAME IN Userr.user_name%TYPE, EMAIL IN Userr.user_email%TYPE)
                        return varchar2
  AS PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO Userr(user_name, user_email) VALUES (USERNAME, EMAIL);
    commit;
    return '200 OK';
    exception
    WHEN DUP_VAL_ON_INDEX
    THEN
      return '500 already existed';
    WHEN OTHERS
    THEN
      return SQLERRM;
  END; 

END ;
/
 select USER_PACKAGE.login('katkollehina@gmail.ty')
from dual;
select USER_PACKAGE.registration('katkoll','katkollehina@gmail.ru')
from dual;