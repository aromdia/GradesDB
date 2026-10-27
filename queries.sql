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

CREATE OR REPLACE VIEW v_people AS 
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