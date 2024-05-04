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