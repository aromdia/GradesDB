-- 
-- Autor: Alejandro Romero Diaz
-- Fecha: Octubre 2026
-- Descripción: Consultas SQL de ejemplo para GradesDB
--              Cubre conceptos de consultas simples y avanzadas
-- 

USE grados;

#CONSULTAS SELECT 

#1
SELECT *
FROM students;
#2
SELECT *
FROM subjects s
WHERE s.acronym = 'IISSI-1';
#3
SELECT s.subject_name, s.acronym
FROM subjects s;
#4
SELECT s.subject_name, s.acronym, s.subject_type
FROM subjects s
WHERE s.subject_type = 'Formación Básica';

#CONSULTAS JOIN

#5
SELECT p.first_name, p.last_name, st.access_method
FROM students st
JOIN people p ON st.student_id = p.person_id
WHERE st.access_method = 'Selectividad';
#6
SELECT p.first_name, p.last_name, pr.category
FROM professors pr
JOIN people p ON pr.professor_id = p.person_id
WHERE pr.category = 'Catedrático';

#VISTAS

CREATE OR REPLACE VIEW v_professors AS
SELECT *
FROM professors pr
JOIN people p ON pr.professor_id = p.person_id;

CREATE OR REPLACE VIEW v_students AS 
SELECT *
FROM students st
JOIN people p ON st.student_id = p.person_id;

#FUNCIONES AGREGADAS 

#7, Media de notas

SELECT AVG(g.grade_value) AS average_grade
FROM grades g
WHERE g.group_id = 1;

#8, Suma créditos

SELECT SUM(s.credits) AS total_credits
FROM subjects s
WHERE s.degree_id = 3;

#9, Contar registros

SELECT COUNT(*) AS total_students
FROM students;

#10, Contar con agrupación básica

SELECT activity, COUNT(*) AS total_groups
FROM groups
GROUP BY activity;

#11 VALOR MÁXIMO

SELECT MAX(g.grade_value) AS max_grade
FROM grades g;

#12 VALOR MINIMO 

SELECT MIN(g.grade_value) AS min_grade
FROM grades g;

#CONDICIONES MULTIPLES

#13 OR LOGICO

SELECT g.grade_id, g.grade_value, g.exam_call
FROM grades g
WHERE g.grade_value<5 OR g.grade_value>9;

#14 BETWEEN

SELECT g.grade_id, g.grade_value, g.exam_call
FROM grades g
WHERE g.grade_value BETWEEN 5 AND 7;

#15 IN

SELECT s.subject_id, s.subject_name, s.credits 
FROM subjects s
WHERE s.credits IN (6,12);

#16 RANGO DE EDAD

SELECT p.first_name, p.last_name, p.age
FROM people p
WHERE p.age BETWEEN 20 AND 30;

#DISTINCT

#17 NOMBRES UNICOS DE GRUPOS

SELECT DISTINCT g.group_name
FROM groups g;

#18 TIPOS DE ASIGNATURA

SELECT DISTINCT s.subject_type
FROM subjects s;

#19 AÑOS ACADÉMICOS 

SELECT DISTINCT g.academic_year
FROM groups g
ORDER BY g.academic_year DESC;

#SUBCONSULTAS

#20 AGREGADO FILTRADO 

SELECT MAX(g.grade_value) AS max_grade
FROM grades g
WHERE g.student_id= 6;

#21 IN con subconsulta

SELECT ge.student_id
FROM group_enrollments ge
WHERE ge.group_id IN (
	SELECT g.group_id
	FROM groups g
	WHERE g.academic_year = 2024
);

#22 COMPARACION CON AGREGADO 
SELECT s.subject_name, s.credits
FROM subjects s
WHERE s.credits > (SELECT AVG(credits) FROM subjects);

#PATRONES CON LIKE 

#23 TERMINACION DE CADENA
SELECT p.first_name, p.last_name, p.dni
FROM people p
WHERE p.dni LIKE '%A';

#24 INICIO DE CADENA
SELECT s.subject_name
FROM subjects s
WHERE s.subject_name LIKE 'Fundamentos%';

#25 LONGITUD EXACTA 
SELECT p.first_name, p.last_name
FROM people p
WHERE p.first_name LIKE '_____';

#FILTRADO POR FECHAS Y AÑOS 

#26 FILTRO POR AÑO
SELECT g.group_name,g.activity, g.academic_year
FROM groups g
WHERE g.academic_year = 2024;

#27 RANGO DE AÑOS
SELECT g.group_name,g.activity, g.academic_year
FROM groups g
WHERE g.academic_year BETWEEN 2020 AND 2023
ORDER BY g.academic_year;

#VISTAS COMPLEJAS 

CREATE OR REPLACE VIEW v_grades_with_honors AS
SELECT g.grade_id, g.student_id, g.group_id, g.grade_value, g.exam_call
FROM grades g
WHERE g.with_honors = 1;

SELECT *
FROM v_grades_with_honors;

CREATE OR REPLACE VIEW v_student_grades AS
SELECT p.person_id, p.first_name, p.last_name, p.dni, g.grade_value, g.exam_call, g.with_honors, 
gr.group_name, gr.activity, gr.academic_year, s.subject_name, s.acronym,s.credits
FROM people p
JOIN students st ON p.person_id = st.student_id
JOIN grades g ON st.student_id = g.student_id
JOIN groups gr ON g.group_id = gr.group_id
JOIN subjects s ON gr.subject_id = s.subject_id;

SELECT *
FROM v_student_grades;

CREATE OR REPLACE VIEW v_professor_loads AS
SELECT p.person_id, p.first_name, p.last_name, pr.category, tl.credits AS teaching_credits,
    gr.group_name, gr.activity, gr.academic_year, s.subject_name, s.acronym
FROM people p
JOIN professors pr ON p.person_id = pr.professor_id
JOIN teaching_loads tl ON pr.professor_id = tl.professor_id
JOIN groups gr ON tl.group_id = gr.group_id
JOIN subjects s ON gr.subject_id = s.subject_id;

SELECT *
FROM v_professor_loads;

CREATE OR REPLACE VIEW v_degree_students AS
SELECT DISTINCT d.degree_id, d.degree_name, p.person_id, p.first_name, p.last_name, st.access_method, gr.academic_year
FROM degrees d
JOIN subjects s ON d.degree_id = s.degree_id
JOIN groups gr ON s.subject_id = gr.subject_id
JOIN group_enrollments ge ON gr.group_id = ge.group_id
JOIN students st ON ge.student_id = st.student_id
JOIN people p ON st.student_id = p.person_id;

SELECT *
FROM v_degree_students;

#28 USO DE VISTAS

SELECT COUNT(*) AS total_honors
FROM v_grades_with_honors;

#29 AGREGACION SOBRE VISTA
 
SELECT v.first_name, v.last_name, AVG(v.grade_value) AS average_grade
FROM v_student_grades v
GROUP BY v.person_id, v.first_name, v.last_name;

#ORDER BY, LIMIT y OFFSET: Control de resultados

#30 ORDENACION ASCENDENTE

SELECT g.grade_id,g.student_id,g.grade_value, g.exam_call
FROM grades g
ORDER BY g.grade_value ASC;

#31 ORDENACION DESCENDENTE
SELECT g.grade_id, g.student_id, g.grade_value, g.exam_call
FROM grades g
ORDER BY g.grade_value DESC;

#32 Limitacion de resultados
SELECT g.grade_id, g.student_id, g.grade_value, g.exam_call
FROM grades g
ORDER BY g.grade_value DESC
LIMIT 5;

#33 Ordenacion múltiple
SELECT st.first_name, st.last_name, g.grade_value, g.exam_call
FROM grades g
JOIN v_students st ON g.student_id = st.student_id
WHERE g.grade_value >=5
ORDER BY st.last_name ASC, st.first_name ASC;

#34 Paginacion basica
SELECT g.grade_id, g.student_id, g.grade_value
FROM grades g
ORDER BY g.grade_value DESC
LIMIT 5 OFFSET 5;

#35 TERCERA PAGINA 
SELECT g.grade_id, g.student_id, g.grade_value
FROM grades g
ORDER BY g.grade_value DESC
LIMIT 5 OFFSET 10;

#36 ORDENACION CON CRITERIOS MIXTOS
SELECT g.group_name, g.activity, g.academic_year
FROM groups g
ORDER BY g.academic_year DESC, g.group_name ASC;

