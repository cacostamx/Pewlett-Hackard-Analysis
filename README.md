# Pewlett Hackard Analysis

## Overview

Pewlett Hackard (PH) is a big company with over 300,000 employees and is facing an upcoming retirement many employees in the near future. We have analyzed the number of employees retiring by department, who is elegible for a retirment package, and managerial positions that will be available.

The purpose of this new analysis is to determine the number of retiring employees per title (or position), and identify employees who are eligible to participate in a mentorship program. 

PH needed to create a database with the tables to hold the data from the csv files. First, we created an Entity Relationship Diagrams (ERD) to have a visual representation of the tables' information and the relationship among them.

   ![ERD_schema](/Resources/schema.png)

## Resources

- Data source: The analysis was performed on six csv files that PH RH department provided, and stored in the "Data" folder.
    -"titles.csv"
    -"employees.csv"
    -"dept_emp.csv"
    -"salaries.csv"
    -"dept_manager.csv"
    -"departments.csv"

- Software use to perform the analysis: PostgrSQL v13.5 and Pgadmin4 v6.1 for Windows

## Results

The main findings are the following:

### Retiring employees by title

- There are 72,458 employees who were born between January 1, 1952 and December 31, 1955, and are currently employed.

    |**Unique titles retiring**                        |
    |:------------------------------------------------:|
    |![unique_titles](/Resources/ret_titles_unique.png)|

- Around 70% of the employees retiring hold senior positions (Senior Engineer and Senior Staff).

    |**Number of retiring employees by title**    |
    |:-------------------------------------------:|
    |![unique_titles](/Resources/titles_count.png)|

### Mentoring eligibility

- There are 1,549 employees eligible for mentorship.

- The count of Senior Staff for mentorship eligibility is the most with 569 employees, but Senior Engineering is too low for the retiring positions.

    |**Mentorship eligibility by title**               |
    |:------------------------------------------------:|
    |![mentor_titles](/Resources/ment_count_titles.png)|


## Summary

### Preparing for the future

- As seen from the results, there are 72,458 employees that could be retiring in the next years. Filtering by year birth and asuming they retire in this order, the rolls that need to be fulfilled are:

    |**Title**         |**1st Year**|**2nd Year**|**3rd Year**|**4th Year**|
    |:-----------------|-----------:|-----------:|-----------:|-----------:|
    |Senior Engineer   |       6,138|       6,422|       6,613|       6,743|
    |Senior Staff      |       5,835|       6,409|       6,350|       6,332|
    |Engineer          |       2,137|       2,331|       2,440|       2,377|
    |Staff             |       1,784|       1,933|       2,018|       1,901|
    |Technique Leader  |         817|         945|         946|         895|
    |Assistant Engineer|         269|         288|         245|         288|
    |Manager           |           1|           0|           0|           1|
    |**Total**         |  **16,981**|  **18,328**|	**18,612**|	 **18,537**|

    As shown, Senior positions are have the most number of employees retiring each year.

- Looking at the number mentorship eligibility by department and comparing to hose retiring by department, the difference is huge; around 46x retiring vs mentoring. Above 60% is concentrated in Development, Production and Sales.

    |**Mentorship eligibility by department**          |**Retirement by department**                      |
    |:------------------------------------------------:|:------------------------------------------------:|
    |![mentorship by dept](/Resources/ment_by_dept.png)|![retirees by dept](/Resources/retir_by_dept.png) |

### Further analysis

- As further analysis to help management and RH department to be prepared and offer attractive positions, I would suggest the following:

    - Determine the retiring positions by gender in order to keep the same relation or decide to change it.  This could be done by joining the  "retirement_titles" and the "employees" tables on the employee number, and grouping by "title" and counting for "Male" and "Female".

    - Determine the average current salaries for each position retiring so they can be adjusted to reflect new conditions. For this table joining the  "retirement_titles" and the "salaries" tables on the employee number (distinct on employee number and ordered descendent by the "to_date" column), and grouping by "title" and calculating the average for "salary".
