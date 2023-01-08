Create DATABASE employee;
use employee;

SELECT  EMP_ID, FIRST_NAME, LAST_NAME, GENDER,  DEPT from employee.emp_record_table;

#Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT 
#from the employee record table, 
#and make a list of employees and details of their department.

SELECT  EMP_ID, FIRST_NAME, LAST_NAME,ROLE, DEPT, COUNTRY, CONTINENT from employee.emp_record_table;

#Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING 
#if the EMP_RATING is: 
#less than two
#greater than four 
#between two and four

SELECT  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from employee.emp_record_table
WHERE EMP_RATING<2 ;

SELECT  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from employee.emp_record_table
WHERE EMP_RATING>4 ;

SELECT  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from employee.emp_record_table
WHERE EMP_RATING>=2 AND EMP_RATING<=4 ;

#Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department
#from the employee table and then give the resultant column alias as NAME

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM employee.emp_record_table
WHERE DEPT='FINANCE';

#Write a query to list only those employees who have someone reporting to them. 
#Also, show the number of reporters (including the President).

SELECT m.EMP_ID,m.FIRST_NAME,m.LAST_NAME,m.ROLE,
m.EXP,COUNT(e.EMP_ID) as "EMP_COUNT"
FROM emp_record_table m
INNER JOIN emp_record_table e
ON m.EMP_ID = e.MANAGER_ID
GROUP BY m.EMP_ID
ORDER BY m.EMP_ID;



#Write a query to list down all the employees from the healthcare and finance departments using union.
#Take data from the employee record table.

SELECT EMP_ID, FIRST_NAME, LAST_NAME,DEPT FROM employee.emp_record_table WHERE DEPT='HEALTHCARE'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME,DEPT FROM employee.emp_record_table WHERE DEPT='FINANCE'

#Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, 
#and EMP_RATING grouped by dept. Also include the respective employee rating 
#along with the max emp rating for the department.

SELECT  EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,max(EMP_RATING) 
OVER(PARTITION BY DEPT)
AS "MAX_DEPT_RATING"
FROM emp_record_table 
ORDER BY DEPT;


#Write a query to calculate the minimum and the maximum salary of the employees in each role. 
#Take data from the employee record table.

SElect EMP_ID, FIRST_NAME, LAST_NAME, ROLE, max(SALARY), MIN(SALARY) from employee.emp_record_table
group by role

# Write a query to assign ranks to each employee based on their experience. 
#Take data from the employee record table.

SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP,
RANK() OVER(ORDER BY EXP) EXP_RANK
FROM employee.emp_record_table;

#Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.

CREATE  VIEW DISPLAYES_EMPLOYEES_IN_VARIOUS_COUNTRIES AS
SELECT EMP_ID,FIRST_NAME,LAST_NAME, COUNTRY, SALARY
FROM  employee.emp_record_table;
where SALARY>6000

SELECT  * FROM DISPLAYES_EMPLOYEES_IN_VARIOUS_COUNTRIES

# Write a nested query to find employees with experience of more than ten years 
#WHERE EMP_ID IS EQUAL TO MANAGER_ID 
#Take data from the employee record table.

SELECT  EMP_ID,FIRST_NAME,LAST_NAME, EXP
FROM employee.emp_record_table
WHERE EMP_Id IN (SELECT MANAGER_ID FROM emp_record_table);

#Write a query to create a stored procedure to retrieve the details of the employees
# whose experience is more than three years. Take data from the employee record table.

delimiter $$
create procedure emp_exp_details()
begin
select EMP_ID,FIRST_NAME,LAST_NAME, EXP
FROM employee.emp_record_table
where EXP>3;

end $$

call emp_exp_details()


#Write a query using stored functions in the project table to check whether the job profile assigned to 
#each employee in the data science team matches the organization’s set standard.
#The standard being:
#For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
#For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
#For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
#For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
#For an employee with the experience of 12 to 16 years assign 'MANAGER'.

delimiter $$
create function job_profile(EXP int)
returns varchar(40)
begin
declare job_profile varchar(40);
if EXP<=2 THEN
set job_profile='JUNIOR DATA SCIENTIST';
ELSEIF EXP>=2 AND EXP <=5 THEN
SET job_profile ='ASSOCIATE DATA SCIENTIST';
ELSEIF EXP>=5 AND EXP <=10 THEN
SET job_profile ='SENIOR DATA SCIENTIST';
ELSEIF EXP>=10 AND EXP <=12 THEN
SET job_profile ='LEAD DATA SCIENTIST';
ELSEIF EXP>=12 AND EXP <=16 THEN
SET job_profile ='MANAGER';
END IF;
RETURN(job_profile);

END $$

SELECT EXP,job_profile(EXP) from employee.data_science_team;

#Create an index to improve the cost and performance of the query to find the employee 
#whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.

CREATE INDEX idx_first_name
ON emp_record_table(FIRST_NAME(20));
SELECT * FROM emp_record_table
WHERE FIRST_NAME='Eric';

#Write a query to calculate the bonus for all the employees, 
#based on their ratings and salaries (Use the formula: 5% of salary * employee rating).

select  EMP_ID, FIRST_NAME, LAST_NAME, SALARY, 0.05 * SALARY*EMP_RATING as Bonus
FROM  employee.emp_record_table;


#Write a query to calculate the average salary distribution based on the continent and country. 
#Take data from the employee record table.

SELECT EMP_ID, FIRST_NAME, LAST_NAME,CONTINENT,AVG(SALARY) AS 
AVERAGE_SALARY FROM employee.emp_record_table GROUP BY CONTINENT;

SELECT EMP_ID, FIRST_NAME, LAST_NAME,COUNTRY,AVG(SALARY) AS 
AVERAGE_SALARY FROM employee.emp_record_table GROUP BY COUNTRY;



