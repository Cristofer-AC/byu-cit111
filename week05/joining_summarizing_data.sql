# Cristofer Miguel Amachi Cervantes
# CIT 111

###
# STEP 1
###

# Query 1
USE v_art;

SELECT artfile
FROM artwork
WHERE period = 'Impressionism';

# Query 2
SELECT artfile
FROM artwork a
	JOIN artwork_keyword ak
	ON a.artwork_id = ak.artwork_id
    JOIN keyword k
    ON k.keyword_id = ak.keyword_id
WHERE k.keyword LIKE '%flower%';

# Query 3
SELECT fname, lname, title
FROM artist ar
	JOIN artwork aw
    ON ar.artist_id = aw.artist_id;

# Query 4
USE magazine;

SELECT magazineName, subscriberLastName, subscriberFirstName
FROM magazine m
	JOIN subscription sn
    ON sn.magazineKey = m.magazineKey
    JOIN subscriber sr
    ON sr.subscriberKey = sn.subscriberKey
ORDER BY magazineName;

# Query 5
SELECT magazineName
FROM magazine m
	JOIN subscription sn
    ON sn.magazineKey = m.magazineKey
    JOIN subscriber sr
    ON sr.subscriberKey = sn.subscriberKey
WHERE sr.subscriberFirstName = 'Samantha';

# Query 6
USE employees;

SELECT first_name, last_name
FROM employees e
	JOIN dept_emp de
	ON de.emp_no = e.emp_no
	JOIN departments d
	ON d.dept_no = de.dept_no
WHERE dept_name = 'Customer Service'
ORDER BY last_name
LIMIT 5;

# Query 7
SELECT first_name, last_name, dept_name, salary, s.from_date
FROM employees e
	JOIN dept_emp de
	ON de.emp_no = e.emp_no
	JOIN departments d
	ON d.dept_no = de.dept_no
    JOIN salaries s
    ON s.emp_no = e.emp_no
WHERE first_name = 'Berni' AND last_name = 'Genin'
ORDER BY from_date DESC
LIMIT 1;

###
# STEP 2
###

# Query 8
USE bike;

SELECT ROUND(AVG(quantity), 0) AS 'Stock Average'
FROM stock;

# Query 9
SELECT DISTINCT product_name 
FROM product p
	JOIN stock s
	ON p.product_id = s.product_id
WHERE quantity = 0
ORDER BY product_name;

# Query 10
SELECT category_name, SUM(quantity)
FROM category c
	JOIN product p
    ON c.category_id = p.category_id
	JOIN stock s
    ON s.product_id = p.product_id
WHERE s.store_id = 2
GROUP BY category_name
ORDER BY SUM(quantity);

# Query 11
USE employees;

SELECT COUNT(*) AS 'Number of Employees'
FROM employees;

# Query 12
SELECT dept_name, FORMAT(ROUND(AVG(salary), 2), 2) AS average_salary
FROM salaries s
	JOIN employees e
	ON s.emp_no = e.emp_no
    JOIN dept_emp de
    ON de.emp_no = e.emp_no
    JOIN departments d
    ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING AVG(salary) < 60000;

# Query 13
SELECT dept_name, COUNT(e.first_name) AS 'Number of Females'
FROM employees e
    JOIN dept_emp de
    ON de.emp_no = e.emp_no
    JOIN departments d
    ON d.dept_no = de.dept_no
WHERE gender = 'F'
GROUP BY dept_name;
