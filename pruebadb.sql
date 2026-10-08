#Prueba restricción edad
INSERT INTO people (dni, first_name, last_name, age, email)
VALUES ('99999999Z', 'Juan', 'Test', 15, 'juan@test.es');
#Prueba restriccion dni repetido
 #Primero se insterta una persona válida
INSERT INTO people (dni, first_name, last_name, age, email)
VALUES ('88888888A', 'Ana', 'Test', 25, 'ana@test.es');
 --Intento de instertar a una persona con dni repetido
INSERT INTO people (dni, first_name, last_name, age, email)
VALUES ('88888888A', 'Pedro', 'Test', 30, 'pedro@test.es');

