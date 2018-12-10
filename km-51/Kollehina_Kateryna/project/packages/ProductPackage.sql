CREATE OR REPLACE PACKAGE product_package IS
    PROCEDURE add_product (
        PRODUCTNAME   IN         Product.product_name%TYPE
    );

    PROCEDURE del_product (
        PRODUCTNAME   IN        Product.product_name%TYPE
    );

END product_package;
/

CREATE OR REPLACE PACKAGE BODY product_package IS

    PROCEDURE add_product (
        PRODUCTNAME   IN         Product.product_name%TYPE
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO Product (
            product_name
        ) VALUES (
            PRODUCTNAME
        );

        COMMIT;
    END add_product;

  PROCEDURE del_product(PRODUCTNAME   IN         Product.product_name%TYPE) AS
    BEGIN
      DELETE FROM Product
             WHERE Product.product_name = PRODUCTNAME;
    COMMIT;
    END del_product;

END product_package;
/
select * from Product;
CALL product_package.add_product('salmon');
CALL product_package.del_product('onion');
select * from Product;