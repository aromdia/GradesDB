#Prueba restricción edad
INSERT INTO people (dni, first_name, last_name, age, email)
VALUES ('99999999Z', 'Juan', 'Test', 15, 'juan@test.es');
#Prueba restriccion dni repetido
 #Primero se insterta una persona válida
INSERT INTO people (dni, first_name, last_name, age, email)
VALUES ('88888888A', 'Ana', 'Test', 25, 'ana@test.es');
 #Intento de instertar a una persona con dni repetido
INSERT INTO people (dni, first_name, last_name, age, email)
VALUES ('88888888A', 'Pedro', 'Test', 30, 'pedro@test.es');

-- Primero necesitamos una persona en la tabla people
INSERT INTO people (person_id, dni, first_name, last_name, age, email)
VALUES (1000, '11111111A', 'Carlos', 'Profesor', 45, 'carlos@us.es');

-- Ahora intentamos crear el profesor con categoría inválida
INSERT INTO professors (professor_id, category)
VALUES (1000, 'Adjunto');

-- Primero necesitamos una persona
INSERT INTO people (person_id, dni, first_name, last_name, age, email)
VALUES (2000, '22222222B', 'María', 'Estudiante', 20, 'maria@us.es');

-- Intentamos crear estudiante con método inválido
INSERT INTO students (student_id, access_method)
VALUES (2000, 'Erasmus');
-- Se intenta añadir un grado que dura 2 años
INSERT INTO degrees (degree_name, duration_years)
VALUES ('Grado en Pruebas', 2);
