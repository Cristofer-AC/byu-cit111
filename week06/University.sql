# Cristofer Miguel Amachi Cervantes
# CIT 111

###
# FORWARD ENGINEERING CODE
###

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL,
  `year` YEAR(4) NULL,
  `term` VARCHAR(25) NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`teacher` ;

CREATE TABLE IF NOT EXISTS `university`.`teacher` (
  `teacher_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `dept_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dept_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(45) NULL,
  `credits` INT NULL,
  `dept_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`dept_id`)
    REFERENCES `university`.`department` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL,
  `section_number` INT NULL,
  `capacity` INT NULL,
  `term_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_teacher1_idx` (`teacher_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `university`.`teacher` (`teacher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` ENUM('M', 'F') NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

###
# INSERTS
###
USE university;

INSERT INTO term VALUES
	(1, 2019, 'Fall'),
    (2, 2018, 'Winter');

INSERT INTO college VALUES
	# id, name
    (1, 'College of Physical Science and Engineering'),
    (2, 'College of Business and Communication'),
    (3, 'College of Language and Letters');

INSERT INTO department VALUES
	# id, name, code, college_id
	(1, 'Computer Information Technology', 'CIT', 1),
    (2, 'Economics', 'ECON', 2),
    (3, 'Humanities and Philosophy', 'HUM', 3);

INSERT INTO course VALUES
	# id, number, title, credits, dept_id
	(1, 111, 'Intro to Databases', 3, 1),
    (2, 388, 'Econometrics', 4, 2),
    (3, 150, 'Micro Economics', 3, 2),
    (4, 376, 'Classical Heritage', 2, 3);

INSERT INTO teacher VALUES
	# id, first_name, last_name
	(1, 'Marty', 'Morring'),
    (2, 'Nate', 'Norris'),
    (3, 'John', 'Jensen'),
    (4, 'Bill', 'Barney'),
    (5, 'Ben', 'Barrus');
    

INSERT INTO section VALUES
	# id, section_number, capacity, term, teacher, course_id
	(1, 1, 30, 1, 1, 1), -- CIT 111 1 Fall
    (2, 3, 50, 1, 2, 3), -- ECON 150 1 Fall
    (3, 3, 50, 1, 2, 3), -- ECON 150 2 Fall
    (4, 2, 35, 1, 5, 2), -- ECON 388 1 Fall
    (5, 4, 30, 1, 3, 4), -- HUM 376 1 Fall
    (6, 1, 30, 2, 1, 1), -- CIT 111 2 Winter
    (7, 1, 35, 2, 4, 1), -- CIT 111 3 Winter
    (8, 2, 50, 2, 2, 3), -- ECON 150 1 Winter
    (9, 2, 50, 2, 2, 3), -- ECON 150 2 Winter
    (10, 4, 30, 2, 3, 4); -- HUM 376 1 Winter

INSERT INTO student VALUES
	# id, first_name, last_name, gender, city, state, birthdate
	(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
	(2, 'Katie', 'Smith',	'F', 'Provo', 'UT', '1995-07-22'),
	(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
	(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
	(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
	(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
	(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
	(8,'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
	(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
	(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

INSERT INTO enrollment VALUES
	# student_id, section_id
    (6, 7),
    (7, 6),
    (7, 8),
    (7, 10),
    (4, 5),
    (9, 9),
    (2, 4),
    (3, 4),
    (5, 4),
    (5, 5),
    (1, 1),
    (1, 3),
    (8, 9),
    (10, 6);

###
# QUERIES
###

# Query 1

SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %d, %Y') AS 'Sept Birthdays'
FROM student
WHERE birthdate LIKE '%-09-%'
ORDER BY last_name;
    
# Query 2
SELECT last_name, first_name, ROUND(DATEDIFF('2017-01-05', birthdate) / 365, 0) AS 'Years', DATEDIFF('2017-01-05', birthdate) % 365 AS 'Days', CONCAT(ROUND(DATEDIFF('2017-01-05', birthdate) / 365, 0), ' - Yrs, ', DATEDIFF('2017-01-05', birthdate) % 365,' - Days') AS 'Years and Days'
FROM student
ORDER BY birthdate;

# Query 3
SELECT st.first_name, st.last_name
FROM student st
	JOIN enrollment e
	ON e.student_id = st.student_id
    JOIN section sn
    ON e.section_id = sn.section_id
    JOIN teacher t
    ON sn.teacher_id = t.teacher_id
WHERE t.first_name = 'John'
ORDER BY st.last_name;
    
# Query 4
SELECT t.first_name, t.last_name
FROM teacher t
	JOIN section sn
    ON sn.teacher_id = t.teacher_id
    JOIN enrollment e
    ON e.section_id = sn.section_id
	JOIN student st
    ON e.student_id = st.student_id
WHERE st.first_name = 'Bryce'
ORDER BY t.last_name;

# Query 5
SELECT st.first_name, st.last_name
FROM student st
	JOIN enrollment e
	ON e.student_id = st.student_id
    JOIN section sn
    ON e.section_id = sn.section_id
    JOIN term tm
    ON sn.term_id = tm.term_id
    JOIN course c
    ON sn.course_id = c.course_id
WHERE tm.term = 'Fall' AND c.title = 'Econometrics'
ORDER BY st.last_name;

# Query 6
SELECT d.code AS 'department_code', c.number AS 'course_num', c.title AS 'name'
FROM student st
	JOIN enrollment e
	ON e.student_id = st.student_id
    JOIN section sn
    ON e.section_id = sn.section_id
    JOIN course c
    ON sn.course_id = c.course_id
    JOIN department d
    ON d.dept_id = c.dept_id
WHERE st.first_name = 'Bryce'
ORDER BY c.title;

# Query 7
SELECT tm.term, tm.year, COUNT(st.first_name) AS 'Enrollment'
FROM student st
	JOIN enrollment e
	ON e.student_id = st.student_id
    JOIN section sn
    ON e.section_id = sn.section_id
    JOIN term tm
    ON sn.term_id = tm.term_id
WHERE tm.term = 'Fall'
GROUP BY tm.year;

# Query 8
SELECT cg.name, COUNT(c.title) AS 'Courses'
FROM course c
    JOIN department d
    ON d.dept_id = c.dept_id
    JOIN college cg
    ON cg.college_id = d.college_id
GROUP BY cg.name
ORDER BY cg.name;

# Query 9
SELECT first_name, last_name, SUM(capacity) AS 'TeachingCapacity'
FROM section s
	JOIN teacher t
	ON t.teacher_id = s.teacher_id
    JOIN term tm
    ON tm.term_id = s.term_id
WHERE tm.term = 'Winter'
GROUP BY first_name, last_name
ORDER BY TeachingCapacity;

# Query 10
SELECT last_name, first_name, SUM(c.credits) AS Credits
FROM student st
	JOIN enrollment e
	ON e.student_id = st.student_id
    JOIN section sn
    ON e.section_id = sn.section_id
    JOIN course c
    ON sn.course_id = c.course_id
    JOIN term tm
    ON tm.term_id = sn.term_id
WHERE tm.term = 'Fall'
GROUP BY last_name, first_name
HAVING Credits > 3
ORDER BY Credits DESC;