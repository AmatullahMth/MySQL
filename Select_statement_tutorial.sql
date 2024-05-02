##Basics of SQL Beginner Level

## The select statement is a command that helps you to view the columns of your data. 
## To follow along with this tutorial please execute each statement using the "execute statement under the keyboard cursor", which is the lightning like symbol above, with the little I on top of it
## You should always have the column names you want to select, * means all the columns, and you must always have the FROM keyword followed by the name of the table you're getting data from, in this case its employee_demographics
## PEMDAS is a guide to understanding the order of execution for your queries, it follows the order Parenthesis, Exponent, Multiplication, Addition, Subtraction short for PEDMAS.

SELECT * 
FROM employee_demographics;

## To select a specific column you specify the name of that column after the SELECT keyword, you can specify however many columns you want to see by separating them with a comma(,)

SELECT first_name, 
	   last_name
FROM employee_demographics;

## You can also perform calculations to affect the whole column within the SELECT statement as well
### Write a query to tell us what the age of the employee will be in 5 years

SELECT first_name, 
	   last_name,
       age,
       age+5
FROM employee_demographics;

## A semicolon (;) marks the end of your query or SQL statement, if you have multiple queries, the semicolon helps to seperate them so that if you run all of them, they will have their results on separate tabs on the result grid

SELECT * 
FROM employee_demographics;
SELECT * 
FROM employee_salary;

## DISTINCT keyword trims your output such that you only have unique values showing, so if there were repeating values on your column, it only show one instance of each 
SELECT gender
FROM employee_demographics;

SELECT DISTINCT gender
FROM employee_demographics;

## The WHERE clause is a command that helps you to view the rows of your data. 
## You use comparison operators when dealing with the WHERE clause, comparison operators are (=, >, <, <=, >=, !=)
SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT * 
FROM employee_salary
WHERE salary > 50000;

SELECT * 
FROM employee_demographics
WHERE gender = 'Female';

SELECT * 
FROM employee_demographics
WHERE gender != 'Female';

## The standard default date for MySQL is 'yyyy-mm-dd'
SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01';

## Logical operators in SQL (AND, OR, NOT)
SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND	gender = 'Male';

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR	gender = 'Male';

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT	gender = 'Male';

##PEDMAS coming into play when we have a lot of operations
SELECT * 
FROM employee_demographics
WHERE first_name = 'Leslie' AND age = 44;

SELECT 
    *
FROM
    employee_demographics
WHERE
    (first_name = 'Leslie' AND age = 44)
        OR age > 55; 

## LIKE statement helps to view data which matches what you're looking for even if it's  not exactly the same, as long as it match the first few letters, e.g if you want to return Barbara and you use LIKE Bar 
### in your select statement it will work
## The LIKE statement is accompanied by the two special characters % and _, the % looks at everything, and the _ looks at specific characters
## The position of the special characters matter, if you put them before the word, it looks at characters before that word, if you put it after, it looks at characters after that word

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE '%er%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a__';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a___';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a___%';

SELECT * 
FROM employee_demographics
WHERE birth_date LIKE '1989%';

## GROUP BY and ORDER BY Clauses
## The GROUP BY Clause groups together rows that have the same values in the specified columns, then you can be able to run aggregate functions(average, mean, min, max) on those rows

SELECT gender
FROM employee_demographics
group by gender
;

## Performing an aggregate function to calculate the average age of the gender
SELECT gender, avg(age)
FROM employee_demographics
group by gender
;

SELECT gender, avg(age), max(age), min(age), count(age)
FROM employee_demographics
group by gender
;

SELECT 
    occupation, salary
FROM
    employee_salary
group by occupation, salary;

## ORDER BY clause sorts the results in ascending or descending order, by default its in ascending order, you can change it to descending by usong the keyword DESC

SELECT *
FROM employee_demographics
order by first_name
;

SELECT *
FROM employee_demographics
order by first_name DESC
;

## If we order by  multiple columns it forst orders by the first one and then takes that result and orders by the second one, so sometimes using the order by clause on a particular order can mean that the second column is redundant
### see second example
SELECT 
    *
FROM
    employee_demographics
ORDER BY gender , age
;

SELECT 
    *
FROM
    employee_demographics
ORDER BY age, gender
;

## You can add DESC and it will apply to the specific column its next to, in this case the gender will still be ASC but the age will be DESC
SELECT *
FROM employee_demographics
order by gender, age DESC
;

## HAVING Clause helps with 

SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, avg(salary)
FROM employee_salary
GROUP BY occupation
;

SELECT occupation, avg(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING avg(salary) > 75000
;

## LIMIT and ALIASING
## LIMIT specifies how many rows you want in your output

SELECT *
FROM employee_demographics
LIMIT 3
;

## To find the top 3 oldest employees
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3
;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3, 1
;

## ALIASING is changing the name of a column using the AS keyword but its not compulsory to have it
SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT gender, avg(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40
;

