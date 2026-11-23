USE grados;
#trigger RN08
DELIMITER //
CREATE OR REPLACE TRIGGER t_biu_student_rn08
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
BEGIN
		DECLARE v_age TINYINT;
		IF NEW.access_method ='Selectividad' THEN
			SELECT age INTO v_age
			FROM people p
			WHERE p.person_id=NEW.student_id;
			IF v_age<16 THEN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'RN08: No se puede acceder por Selectividad con menos de 16 años';
        END IF;
    END IF;
END //
DELIMITER ;

#trigger RN02
CREATE OR REPLACE TRIGGER t_biu_grades_rn02
BEFORE INSERT OR UPDATE ON grades
FOR EACH ROW
BEGIN
		DECLARE v_count INT;