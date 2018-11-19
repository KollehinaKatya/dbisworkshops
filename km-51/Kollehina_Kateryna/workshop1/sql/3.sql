CREATE OR REPLACE TRIGGER RECIPE_DELETION 
before delete on Recipe for each row
BEGIN 
if  user <> 'ADMIN' then 
  raise_application_error(-20003,'YOU ARE NOT GRANTED TO DELETE RECIPE');
end if;
end RECIPE_DELETION;

DELETE FROM Recipe
 where recipe_name = 'Borsh';