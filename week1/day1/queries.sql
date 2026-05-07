-- Q1: Retrieve all employees
SELECT * FROM Employee;

-- Q2: Retrieve employee names and salaries
SELECT name, salary FROM Employee;

-- Q3: Find employees older than 30
SELECT * 
FROM Employee 
WHERE age > 30;

-- Q4: Get all department names
SELECT name 
FROM Department;

-- Q5: Get employees working in IT department
SELECT e.*
FROM Employee e
JOIN Department d 
ON e.department_id = d.department_id
WHERE d.name = 'IT';



-- STRING MATCHING

-- Q6: Find employees whose name starts with 'J'
SELECT * 
FROM Employee 
WHERE name LIKE 'J%';

-- Q7: Find employees whose name ends with 'e'
SELECT * 
FROM Employee 
WHERE name LIKE '%e';

-- Q8: Find employees whose name contains 'a'
SELECT * 
FROM Employee 
WHERE name LIKE '%a%';

-- Q9: Find employees whose name length is 9
SELECT * 
FROM Employee 
WHERE LENGTH(name) = 9;

-- Q10: Find employees whose second letter is 'o'
SELECT * 
FROM Employee 
WHERE name LIKE '_o%';



-- DATE QUERIES

-- Q11: Find employees hired in 2020
SELECT * 
FROM Employee 
WHERE YEAR(hire_date) = 2020;

-- Q12: Find employees hired in January
SELECT * 
FROM Employee 
WHERE MONTH(hire_date) = 1;

-- Q13: Find employees hired before 2019
SELECT * 
FROM Employee 
WHERE hire_date < '2019-01-01';

-- Q14: Find employees hired after March 2021
SELECT * 
FROM Employee 
WHERE hire_date >= '2021-03-01';

-- Q15: Find employees hired in last 2 years
SELECT * 
FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);



-- AGGREGATE FUNCTIONS

-- Q16: Find total salary of all employees
SELECT SUM(salary) AS total_salary 
FROM Employee;

-- Q17: Find average salary
SELECT AVG(salary) AS avg_salary 
FROM Employee;

-- Q18: Find minimum salary
SELECT MIN(salary) AS min_salary 
FROM Employee;

-- Q19: Count employees in each department
SELECT department_id, COUNT(*) AS emp_count
FROM Employee
GROUP BY department_id;

-- Q20: Average salary per department
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;



-- GROUP BY

-- Q21: Total salary per department
SELECT department_id, SUM(salary)
FROM Employee
GROUP BY department_id;

-- Q22: Average age per department
SELECT department_id, AVG(age)
FROM Employee
GROUP BY department_id;

-- Q23: Employees hired per year
SELECT YEAR(hire_date) AS year, COUNT(*)
FROM Employee
GROUP BY YEAR(hire_date);

-- Q24: Maximum salary per department
SELECT department_id, MAX(salary)
FROM Employee
GROUP BY department_id;

-- Q25: Department with highest average salary
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;



-- HAVING

-- Q26: Departments with more than 2 employees
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Q27: Departments with avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Q28: Years with more than 1 hire
SELECT YEAR(hire_date)
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- Q29: Departments with total salary < 100000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- Q30: Departments with max salary > 75000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;


-- ORDER BY

-- Q31: Sort employees by salary ascending
SELECT * 
FROM Employee 
ORDER BY salary ASC;

-- Q32: Sort employees by age descending
SELECT * 
FROM Employee 
ORDER BY age DESC;

-- Q33: Sort employees by hire date
SELECT * 
FROM Employee 
ORDER BY hire_date;

-- Q34: Sort by department then salary
SELECT * 
FROM Employee 
ORDER BY department_id, salary;

-- Q35: Departments ordered by total salary
SELECT d.name, SUM(e.salary)
FROM Department d
JOIN Employee e 
ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY SUM(e.salary);



-- JOINS

-- Q36: Employee name with department name
SELECT e.name, d.name
FROM Employee e
JOIN Department d 
ON e.department_id = d.department_id;

-- Q37: Project name with department name
SELECT p.name, d.name
FROM Project p
JOIN Department d 
ON p.department_id = d.department_id;

-- Q38: Employee with project (via department)
SELECT e.name, p.name
FROM Employee e
JOIN Project p 
ON e.department_id = p.department_id;

-- Q39: All employees with department (LEFT JOIN)
SELECT e.name, d.name
FROM Employee e
LEFT JOIN Department d 
ON e.department_id = d.department_id;

-- Q40: All departments with employees
SELECT d.name, e.name
FROM Department d
LEFT JOIN Employee e 
ON d.department_id = e.department_id;
