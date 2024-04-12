# Cristofer Miguel Amachi Cervantes
# CIT 111

#
# STEP 1
#
USE v_art;

SELECT *
FROM artist;

# Query 1
INSERT INTO artist (fname, mname, lname, dob, dod, country, local)
VALUES ('Johannes', NULL, 'Vermeer', 1632, 1674, 'Netherlands', 'n');

# Query 2
SELECT *
FROM artist
ORDER BY lname;

# Query 3
UPDATE artist
SET dod = 1675
WHERE fname = 'Johannes' and lname = 'Vermeer';

# Query 4
DELETE FROM artist
WHERE fname = 'Johannes' and lname = 'Vermeer';


#
# STEP 2
#
USE bike;

# Query 5
SELECT first_name, last_name, phone
FROM customer
WHERE city = 'Houston';

# Query 6
SELECT product_name, list_price, list_price - 500 AS 'Discount Price'
FROM product
WHERE list_price >= 5000
ORDER BY list_price DESC;

# Query 7
SELECT first_name, last_name, email
FROM staff
WHERE store_id <> 1;

# Query 8
SELECT product_name, model_year, list_price
FROM product
WHERE product_name LIKE '%spider%';

# Query 9
SELECT product_name, list_price
FROM product
WHERE list_price BETWEEN 500 AND 550
ORDER BY list_price;

# Query 10
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM customer
WHERE phone IS NOT NULL AND city REGEXP 'ach|och' OR last_name = 'William'
LIMIT 5;

# Query 11
SELECT SUBSTRING(product_name, 1, LOCATE(' - ', product_name)) AS 'Product Name without Year'
FROM product
ORDER BY product_id
LIMIT 14;

# Query 12
SELECT product_name, CONCAT('$', FORMAT(list_price / 3, 2, 'en_US')) AS 'One of 3 payments'
FROM product
WHERE model_year = 2019;


#
# STEP 3
#
USE magazine;

# Query 13
SELECT magazineName, ROUND(magazinePrice - magazinePrice * 0.03, 2) AS '3% off'
FROM magazine;

# Query 14
SELECT subscriberKey, CEILING(DATEDIFF('2020-12-20', subscriptionStartDate) / 365) AS 'Years since subscription'
FROM subscription;

# Query 15
SELECT subscriptionStartDate, subscriptionLength, DATE_FORMAT(DATE_ADD(subscriptionStartDate, INTERVAL subscriptionLength MONTH), '%M %e, %Y') AS 'Subscription end'
FROM subscription;