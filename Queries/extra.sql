SELECT COUNT(ut.title) AS title_count, ut.title
FROM ment_eligibility as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT COUNT(ut.title)
FROM ment_eligibility as ut


SELECT
	to_char(date_trunc('year', e.birth_date), 'YYYY') AS year, 
	count(e.emp_no)
FROM employees AS e
INNER JOIN unique_titles as rt
ON e.emp_no = rt.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01')
GROUP BY year
ORDER BY year;


SELECT
	rt.title,
	count(e.emp_no)
FROM employees AS e
INNER JOIN unique_titles as rt
ON e.emp_no = rt.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01')
	AND (date_part('year', e.birth_date) = '1955')
GROUP BY rt.title
ORDER BY count(e.emp_no) DESC;


SELECT
	d.dept_name, count(me.emp_no)
FROM ment_eligibility AS me
join dept_emp as de
on me.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
WHERE (de.to_date = '9999-01-01')
GROUP BY d.dept_name
ORDER BY count(me.emp_no)

SELECT
	d.dept_name, count(me.emp_no)
FROM unique_titles AS me
join dept_emp as de
on me.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
WHERE (de.to_date = '9999-01-01')
GROUP BY d.dept_name
ORDER BY count(me.emp_no)

SELECT
	count(me.emp_no)
FROM unique_titles AS me

select count(me.emp_no) 
FROM ment_eligibility AS me