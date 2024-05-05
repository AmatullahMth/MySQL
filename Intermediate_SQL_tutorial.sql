## JOINS allow you to combine tables with the same columns, they don't have to have the same name, just the same data

select * 
from employee_demographics;

SELECT * 
FROM employee_salary;

## Employee_id is the column that is common among these two tables
## Using the keyyword JOIN, same as INNER JOIN will allow you to form a bigger table with columns from both table where
### the records are identical on each table, employee_id = 2 is not on both tables so it wont be on the INNER JOIN
SELECT *
FROM employee_demographics ed
JOIN employee_salary es
ON ed.employee_id = es.employee_id;

## OUTER JOINS, which are the LEFT JOIN and the RIGHT JOIN
## LEFT join takes everything from the left/first table and then the right table records will match those ones
## This means records on the right table can be skipped if they dont exist on the left table or if there are records 
### missing on the right table that the left table has, then the row will be populated with NULL

SELECT *
FROM employee_demographics ed
LEFT JOIN employee_salary es
ON ed.employee_id = es.employee_id;

## Similarly the RIGHT join prioritizes data from the right table
SELECT *
FROM employee_demographics ed
RIGHT JOIN employee_salary es
ON ed.employee_id = es.employee_id;

## SELF JOIN is a join that ties a table to itself, meaning you join one table to itself using particular condiitions
SELECT *
FROM employee_demographics ed1
RIGHT JOIN employee_demographics ed2
ON ed1.employee_id + 1 = ed2.employee_id;


SELECT * 
FROM parks_departments pd
INNER JOIN employee_salary es
ON pd.department_id = es.dept_id;

## UNIONS
## A UNION allows you to combine rows of data from different tables
## UNION is the same as UNION DISTINCT, so you will see unique rows

SELECT first_name, last_name
FROM employee_demographics ed
UNION
SELECT first_name, last_name	
FROM employee_salary es
;

## To show all data use UNION ALL, it will show the duplicate values as well if there are any

SELECT *
FROM employee_demographics
UNION ALL 
SELECT *
FROM employee_salary
;



SELECT first_name, last_name,'old' as label
FROM employee_demographics
where age > 50
AND gender = 'Male'
UNION  
SELECT first_name, last_name, 'highly paid' as label
FROM employee_salary
WHERE salary > 70000
;

## STRING FUNCTIONS
## To return the number of charachters in a string you use LENGTH('string')
SELECT LENGTH('string');

## To convert the characters of a string to uppercase UPPER('string')
SELECT UPPER('string');

## To convert the characters of a string to lowercase LOWER('string')
SELECT LOWER('STRing');

## To remove leading and trailing white spaces around a string use TRIM('      string     ')
SELECT TRIM('      string     ') ;

## To remove spaces from the left side of the string LTRIM()
SELECT LTRIM('	string');

## To remove spaces from the right side of the string RTRIM()
SELECT RTRIM('string	');

## Applying these string functions to our dataset
SELECT first_name, LENGTH(first_name) as NAME_LENGTH
FROM employee_demographics
;

SELECT first_name, UPPER(first_name) as NAME_LENGTH
FROM employee_demographics
;

SELECT first_name, LOWER(first_name) as NAME_LENGTH
FROM employee_demographics
;

SELECT '      sky      ', TRIM('        sky         ')
;

SELECT '      sky      ', LTRIM('        sky         ')
;

SELECT '      sky      ', RTRIM('        sky         ')
;

## SUBSTRINGS: LEFT('string', number of characters you'd like to select from the left of a string)
SELECT LEFT('string', 3);

## RIGHT('string', number of characters you'd like to select from the right of a string)
SELECT RIGHT('string', 3);

## SUBSTRING('string', starting position, number of characters to take)
SELECT SUBSTRING('string', 2, 3);

## REPLACE('string', letters you want to replace, letters you want to replace them with)
SELECT REPLACE('string', 'i', 'o');

## LOCATE(string you're looking for, your string), it returns the position of what youre looking for
SELECT LOCATE('n', 'string');

## CONCAT(string1, string2) combines strings into one, it can combine more than 2 strings
SELECT CONCAT('string1', ' string2');
SELECT CONCAT('string1', ' string2', ' string3');

## CASE STATEMENT is a statement that applies logic to your query that specifies conditions similar to how if statements work
## CASE 
##	WHEN condition1 THEN result
##  WHEN condition2 THEN result
## END

SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age >= 50 THEN 'Very Old'
END AS AGE_BRACKET
FROM employee_demographics;

## Determine the new salaries of our employees after they got increases
## If an employee earns less than 50000 they get a 5% raise
## If an employee earns more than 50000 they get a 7% raise
## If they are in the finance department they get a 10% bonus
SELECT *,
CASE 
	WHEN e.salary < 50000 THEN e.salary + (e.salary*0.05)
    WHEN e.salary >= 50000 THEN e.salary + (e.salary*0.07)
END AS NEW_SALARY,
CASE 
	WHEN p.department_name = 'Finance' THEN e.salary + (e.salary*0.1)
END AS Bonus
FROM employee_salary e, parks_departments p;

## SUBQUERIES is a query in another query using IN(subquery), it can only contain 1 column
## If we want to return the employee demographic information in the parks and recreations department
SELECT * 
FROM employee_demographics
WHERE employee_id IN (
					SELECT employee_id
                    FROM employee_salary
                    WHERE dept_id = 1
);

## Compare the above peoples salary to everyone else's salary to determine whether their salary is above or below average

SELECT first_name, last_name, salary,
	(SELECT AVG(salary)
         FROM employee_salary
         ) AS average_salary,
CASE
	WHEN salary > (SELECT AVG(salary)
					FROM employee_salary
				  ) THEN 'Above average'
    WHEN salary <= (SELECT AVG(salary)
					FROM employee_salary
				   ) THEN 'Below average'
END AS Average
FROM employee_salary
;

## WINDOW FUNCTIONS are almost like a GROUP BY, but you don't have the same answer for the entire rows 
## With WINDOW functions we look at a group of the same name, that keeps the same row for the group

## Reminder of a group by
SELECT gender, AVG(salary)
FROM employee_salary s
JOIN employee_demographics d
	ON s.employee_id = d.employee_id
GROUP BY gender
;

## USING A WINDOW FUNCTION

SELECT gender, AVG(salary) OVER()
FROM employee_salary s
JOIN employee_demographics d
	ON s.employee_id = d.employee_id
;

## Compare to the reminder of the group by
SELECT s.first_name, s.last_name, d.gender, s.salary,
	   AVG(s.salary) OVER(PARTITION BY d.gender) AS avg_salary, SUM(s.salary) OVER(PARTITION BY d.gender ORDER BY d.employee_id) AS rolling_total
FROM employee_salary s
JOIN employee_demographics d
	ON s.employee_id = d.employee_id
ORDER BY gender    
;

## You don't need a window function to do this
SELECT s.first_name, s.last_name, d.gender, s.salary, d.employee_id,
	   SUM(s.salary) OVER(PARTITION BY d.gender ORDER BY d.employee_id) AS rolling_total
FROM employee_salary s
JOIN employee_demographics d
	ON s.employee_id = d.employee_id
ORDER BY gender    

;

SELECT *
FROM employee_demographics d
JOIN employee_salary s
	ON s.employee_id = d.employee_id
;

## Instances where you have to use the WINDOW function and nothing else include
## ROW_NUMBER()  returns a row labeling each row by number, unlike JOIN it wont skip anything
## RANK(), ROW_NUMBER(), 

SELECT ROW_NUMBER() OVER() AS rownum, d.*, s.*
FROM employee_demographics d
JOIN employee_salary s
	ON d.employee_id =  s.employee_id
;

## If we add partition by to the over condition it will show the ROW_NUMBER according to the column that you 
## Partitioned by

SELECT ROW_NUMBER() OVER(partition by gender) AS rownum, d.*, s.*
FROM employee_demographics d
JOIN employee_salary s
;

## If we want to calculate the row_number() partitioned by gender but we want from the lowest salary for each partition
SELECT ROW_NUMBER() OVER(partition by gender order by s.salary) AS rownum, d.*, s.*
FROM employee_demographics d
JOIN employee_salary s
	ON d.employee_id =  s.employee_id
;


SELECT ROW_NUMBER() OVER(partition by gender) AS rownum, MAX(salary) OVER(partition by gender), d.*, s.*
FROM employee_demographics d
JOIN employee_salary s
	ON d.employee_id =  s.employee_id
;

## Using the RANK() function to indicate the level at which each partition is based on the values of the column you're ranking by
SELECT RANK() OVER(partition by gender order by salary) AS rank_num, d.gender, s.*
FROM employee_demographics d
JOIN employee_salary s
	ON d.employee_id = s.employee_id
;

## DENSE_RANK() is a function that will not skip the next number  unlike RANK() that skips a number if a rank repeats

SELECT DENSE_RANK() OVER(partition by gender order by salary) AS rank_num, d.gender, s.*
FROM employee_demographics d
JOIN employee_salary s
	ON d.employee_id = s.employee_id
;