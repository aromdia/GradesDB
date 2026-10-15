-- 
-- Autor: Alejandro Romero Diaz
-- Fecha: Octubre 2026
-- Descripción: Consultas SQL de ejemplo para GradesDB
--              Cubre conceptos de consultas simples y avanzadas
-- 

USE grados;

SELECT *
FROM students;

SELECT *
FROM subjects s
WHERE s.acronym = 'IISSI-1';

SELECT s.subject_name, s.acronym
FROM subjects s;

SELECT s.subject_name, s.acronym, s.subject_type
FROM subjects s
WHERE s.subject_type = 'Formación Básica';