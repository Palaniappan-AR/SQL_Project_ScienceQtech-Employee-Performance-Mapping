create database project_2;
use project_2;

-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
select emp_id,first_name,last_name,gender,dept from emp_record_table;

-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
-- less than two
-- greater than four 
-- between two and four

select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating<2;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating>4;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating between 2 and 4;

-- Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
select concat(first_name,' ',last_name) as Name from emp_record_table where dept='FINANCE';

-- Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
select concat(first_name,' ',last_name) as Name,role from emp_record_table where role not in('JUNIOR DATA SCIENTIST','ASSOCIATE DATA SCIENTIST');

select count(*) as Count_Of_Reporters from emp_record_table where role in ('JUNIOR DATA SCIENTIST','ASSOCIATE DATA SCIENTIST','PRESIDENT');

-- Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.
select * from emp_record_table where dept='HEALTHCARE'
union
select * from emp_record_table where dept='FINANCE';

-- Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.
select emp_id,first_name,last_name,role,dept,emp_rating,max(emp_rating) over(partition by dept) as Max_Rating from emp_record_table;

-- Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
select role,max(salary) as Max,min(salary) as Min from emp_record_table group by role;

-- Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
select concat(first_name,' ',last_name) as Name,exp,(Rank() over (order by exp desc)) as 'Rank' from emp_record_table;

-- Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
create view emp_view as select concat(first_name,' ',last_name) as Name,country,salary from emp_record_table where salary>6000;
select * from emp_view;

-- Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
select concat(first_name,' ',last_name) as Name,exp from emp_record_table where exp>10;

-- Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.
DELIMITER //
create procedure Exp_more_3()
begin
	select * from emp_record_table where exp>3;
end //

DELIMITER ;
call Exp_more_3();

-- Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
-- The standard being:

-- For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',

-- For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',

-- For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',

-- For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',

-- For an employee with the experience of 12 to 16 years assign 'MANAGER'.
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
create function job_profile_check(exp int, role text(50))
returns text(10)
begin
	if(exp<=2 and role='JUNIOR DATA SCIENTIST') then
    return 'Yes';
    elseif((exp between 2 and 5) and role='ASSOCIATE DATA SCIENTIST') then
    return 'Yes';
    elseif((exp between 5 and 10) and role='SENIOR DATA SCIENTIST') then
    return 'Yes';
    elseif((exp between 10 and 12) and role='LEAD DATA SCIENTIST') then
    return 'Yes';
    elseif((exp between 12 and 16) and role='MANAGER') then
    return 'Yes';
    else return 'No';
    end if;
end //
DELIMITER ;

select concat(first_name,' ',last_name) as Name,job_profile_check(exp,role) as criteria from emp_record_table;

-- Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
select concat(first_name,' ',last_name) as Name, (0.005*salary*emp_rating) as Bonus from emp_record_table;

-- Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
select continent,country,avg(salary) as Salary_Distribution from project_2.emp_record_table group by country,continent order by CONTINENT;






