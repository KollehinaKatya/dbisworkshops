import cx_Oracle


class User:
    def __enter__(self):
        ip = '127.0.0.1'
        port = 1521
        SID = 'SYS'
        dns_tns = cx_Oracle.makedsn(ip, port, SID)
        connection = cx_Oracle.connect('SYS', 'SYSTEM', dns_tns, mode=cx_Oracle.SYSDBA)
        self.__db = connection
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def sign_in(self, email):
        result = self.__cursor.callfunc("USER_PACKAGE.login", cx_Oracle.STRING, [email])
        return result

    def sign_up(self, username, email):
        status = self.__cursor.callfunc("USER_PACKAGE.Registration", cx_Oracle.STRING, [username, email])
        return status

class RecipePackage:
    def __enter__(self):
        ip = '127.0.0.1'
        port = 1521
        SID = 'SYS'
        dns_tns = cx_Oracle.makedsn(ip, port, SID)
        connection = cx_Oracle.connect('SYS', 'SYSTEM', dns_tns, mode=cx_Oracle.SYSDBA)
        self.__db = connection
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def add(self, email, recipename, productname, recipeid):
        self.__cursor.callproc("recipe_package.add_recipe", [email, recipename, productname, recipeid])

    def delete(self, recipeid):
        self.__cursor.callproc("recipe_package.delete_recipe", [recipeid])

    def update_recipe_name(self, recipeid, recipename):
        self.__cursor.callproc("recipe_package.update_recipe_name", [recipeid, recipename])

    def update_recipe_ingred(self, productname, recipeid):
        self.__cursor.callproc("recipe_package.update_recipe_ingred", [productname, recipeid])
