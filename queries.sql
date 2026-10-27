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

