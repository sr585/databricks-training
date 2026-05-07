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

-- Q41: Find employees who are not assigned to any project
SELECT *
FROM Employee
WHERE department_id NOT IN (
    SELECT DISTINCT department_id 
    FROM Project 
    WHERE department_id IS NOT NULL
);

-- Q42: Count number of projects handled by each employee (based on department)
SELECT e.name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p 
ON e.department_id = p.department_id
GROUP BY e.name;

-- Q43: Find departments with no employees
SELECT d.name
FROM Department d
LEFT JOIN Employee e 
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- Q44: Find employees working in the same department as 'John Doe'
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id 
    FROM Employee 
    WHERE name = 'John Doe'
);

-- Q45: Find department with highest average salary
SELECT d.name
FROM Department d
JOIN Employee e 
ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY AVG(e.salary) DESC
LIMIT 1;

-- Q46: Find employee with highest salary
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 1;

-- Q47: Find employees earning more than average salary
SELECT *
FROM Employee
WHERE salary > (
    SELECT AVG(salary) FROM Employee
);

-- Q48: Find second highest salary
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Q49: Find department with maximum employees
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Q50: Find employees earning more than their department average
SELECT *
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

--- Q51: Find the Nth highest salary (example: N = 3)

SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET (N-1);

-- Q52: Find employees older than all employees in HR department
SELECT *
FROM Employee
WHERE age > ALL (
    SELECT age
    FROM Employee e
    JOIN Department d 
    ON e.department_id = d.department_id
    WHERE d.name = 'HR'
);

-- Q53: Find departments with average salary greater than 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Q54: Find employees working in departments with at least 2 projects
SELECT *
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) >= 2
);

-- Q55: Find employees hired on the same date as 'Jane Smith'
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    WHERE name = 'Jane Smith'
);

--------------------------------------------------

-- Combined Moderate Difficulty Queries (10)

-- Q56: Find total salary of employees hired in 2020
SELECT SUM(salary)
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- Q57: Find departments sorted by average salary
SELECT department_id, AVG(salary)
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC;

-- Q58: Find departments with more than 1 employee and avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

-- Q59: Find employees hired in last 2 years
SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date;

-- Q60: Find departments with more than 2 employees and avg salary
SELECT department_id, COUNT(*) AS emp_count, AVG(salary)
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Q61: Find employees earning more than department average (with name)
SELECT name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Q62: Find employee hired on same date as oldest employee
SELECT name
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    ORDER BY age DESC
    LIMIT 1
);

-- Q63: Count number of projects per department
SELECT d.name, COUNT(p.project_id) AS project_count
FROM Department d
LEFT JOIN Project p 
ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY project_count;

-- Q64: Find employees who earn the highest salary in each department
SELECT name, salary, department_id
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- Q65: Find employees whose age is greater than the average age of their department
SELECT name, age, department_id
FROM Employee e
WHERE age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);