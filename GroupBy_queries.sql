create database adi;
use adi;

create table employee(
id int auto_increment primary key,
name varchar(50),
department varchar(50),
salary decimal(10,2),
joining_date date
);

insert into employee ( name , department, salary, joining_date)
values 
('aditya','IT',63000,'2017-09-13'),
('mahesh','IT',78000,'2020-08-4'),
('sidhart','hotel',54000,'2016-07-1'),
('abhishek','IT',50000,'2012-09-6'),
('diga','farmer',52000,'2017-08-14'),
('rajhesh ','HR',7000,'2026-04-19'),
('rohan','farmer',60000,'2017-09-13'),
('rohit','hotel',74000,'2025-01-1'),
('amol','hotel',65000,'2020-04-8'),
('anand','civil',75000,'2012-06-11');

select * from employee;

# group By - group by  is used to group rows that have same values in one or more column. 
           -- it is commonly used with aggregate function such as count, sum , avg, min, and max.
           
           
 -- count employees in each department
 select department ,count(*) as total_employee
 from employee
 group by department
 having total_employee > 2 ;
 
  -- Q1 Find departments where the average salary is greater than 60,000.
  select department , avg(salary) as average_salary
  from employee
  group by department
  having  average_salary > 60000 ;
  
  -- Q2 Find departments having more than 2 employees.
  select department ,
  count(*) as total_employees 
	from employee
    group by department
    having total_employees > 2;
 
 -- Q3 Find the number of employees in each department and joining year.
SELECT 
    department,
    YEAR(joining_date) AS joining_year,
    COUNT(*) AS employee_count
FROM employee
GROUP BY department, YEAR(joining_date);


-- Q4 Find departments where the average salary is greater than the overall average salary.
select department , avg(salary) as  average_salary
from employee
group by department 
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employee );
     
     
-- Q5 Find departments where the salary difference between the highest and lowest employee is greater than 20,000.
select department , 
max(salary) as highest_salary , 
min(salary) as lowest_salary,
max(salary) - min(salary) as salary_difference
from employee 
group by department
having max(salary) - min(salary) > 20000 ;

-- Q6 Find the department-wise salary statistics:
-- Employee count
-- Total salary
-- Average salary
-- Maximum salary
-- Minimum salary

select department , count(*) as employee_count , sum(salary) as Total_salary , 
avg(salary) as Average_salary, max(salary) as Maximum_salary, min(salary) as Minimum_salary
from employee
group by department;

-- Q7  Find each department and joining year combination where the average salary is greater than 50,000.

select department , year(joining_date) as joining_year,
avg(salary) as  average_salary 
from employee
group by department ,year(joining_date) 
having average_salary > 50000;


-- Q8 Find departments where all employees earn more than 50,000.
select department , min(salary) as minimum_salary 
from employee
group by department
having minimum_salary  > 50000;

-- 🔴 Challenge

-- Q11 Find the department with the highest average salary without using ORDER BY ... LIMIT.
SELECT 
    department,
    AVG(salary) AS average_salary
FROM employee
GROUP BY department
HAVING AVG(salary) = (
    SELECT MAX(avg_salary)
    FROM (
        SELECT AVG(salary) AS avg_salary
        FROM employee
        GROUP BY department
    ) AS dept_avg
);

-- Q12  Find the department with the second-highest total salary using GROUP BY.
SELECT department, SUM(salary) AS total_salary
FROM employee
GROUP BY department
ORDER BY total_salary DESC
LIMIT 1 OFFSET 1;

-- without using order or limit 
SELECT department, SUM(salary) AS total_salary
FROM employee
GROUP BY department
HAVING SUM(salary) = (
    SELECT MAX(total_salary)
    FROM (
        SELECT SUM(salary) AS total_salary
        FROM employee
        GROUP BY department
    ) AS dept_total
    WHERE total_salary < (
        SELECT MAX(total_salary)
        FROM (
            SELECT SUM(salary) AS total_salary
            FROM employee
            GROUP BY department
        ) AS dept_total2
    )
);


