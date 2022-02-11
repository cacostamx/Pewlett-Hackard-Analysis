SELECT * FROM departments;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no;

-- Create table of current employed
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
-- a. Left join because we want to know if any dept has zero values
-- b. create table
select de.dept_no,
	count(ce.emp_no)
into emp_per_dept
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by count(ce.emp_no) desc;

--command " "\\copy public.emp_per_dept (dept_no, count) TO 'C:/Users/CAC/Class/PEWLET~1/Data/EMP_PE~1.CSV' DELIMITER ',' CSV HEADER QUOTE '\"' ESCAPE '''';""

-- 1. Employee Information: A list of employees containing their unique 
-- employee number, their last name, first name, gender, and salary

SELECT * FROM salaries
ORDER BY to_date DESC;
-- these dates don't show the most recent date of employment

-- Employee info for retiring
SELECT emp_no, first_name, last_name, gender
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- add salary from salaries table
-- inner join to have the matching in both tables
-- set to_date to filter for those currently employed
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no
inner join dept_emp as de
on e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- 2. List for active managers.
-- include employee number, first name, last name, department name 
-- and their starting and ending employment dates
-- we use the current_emp filtered table
SELECT dm.dept_no, d.dept_name, dm. emp_no, ce.first_name, 
	ce.last_name, dm.from_date, dm.to_date
-- INTO manager_info
from dept_manager as dm
	inner join current_emp as ce
	on dm.emp_no = ce.emp_no
	inner join departments as d
	on dm.dept_no = d.dept_no;

-- 3. Department Retirees
-- departments added to the current_emp table
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp as de
	ON ce.emp_no = de.emp_no
	INNER JOIN departments as d
	ON d.dept_no = de.dept_no


-- Skill drill. Make list of retiring from sales. Use retirement_info
SELECT *
FROM dept_info as di
WHERE (di.dept_name = 'Sales')


-- Skill drill. Make list of retiring from sales and Deveopment. Use retirement_info
SELECT *
FROM dept_info as di
-- Option 1:
-- WHERE (di.dept_name = 'Sales')
--	OR (di.dept_name = 'Development');
-- Option 2:
WHERE di.dept_name IN ('Sales', 'Development')

