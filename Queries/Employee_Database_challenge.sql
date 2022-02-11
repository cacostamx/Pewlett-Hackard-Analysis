-- CHALLENGE DELIVERABLE 1
--------------------------

-- 1-7 Retreive info from Employees, from Title, Join, Create Table, Filter birth_date
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- table saved to data/retirement_titles.csv

-- 8-15 Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- table saved to data/unique_titles.csv

-- 16-22 Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(ut.title) AS title_count, ut.title
INTO retiring_titles_count
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- table saved to data/retiring_titles.csv

--------------------------
-- CHALLENGE DELIVERABLE 2
--------------------------

-- 1-11 Create mentorship eligibility table
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO ment_eligibility
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- table saved to data/mentorship_eligibilty.csv