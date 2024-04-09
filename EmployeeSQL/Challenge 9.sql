Create table departments(
dept_no varchar(30) primary key,
dept_name varchar(30)
);

create table titles (
title_id varchar(5) primary key,
title varchar(30)
);

create table employees (
emp_no varchar(30) primary key,
emp_title_id varchar(30),
birth_date varchar(10),
first_name varchar(30),
last_name varchar(30),
sex varchar(1),
hire_date varchar(10)
);

create table dept_emp (
emp_no varchar(30),
dept_no varchar(30),
primary key (emp_no, dept_no),
foreign key (dept_no) references departments(dept_no),
foreign key (emp_no) references employees(emp_no)
);

create table dept_manager (
dept_no varchar(30),
emp_no varchar(30),
primary key (emp_no, dept_no),
foreign key (dept_no) references departments(dept_no),
foreign key (emp_no) references employees(emp_no)
);

create table salaries (
emp_no varchar(30) primary key,
salary float,
foreign key (emp_no) references employees(emp_no)
);

--Data Analysis
--List the employee number, last name, first name, sex, and salary of each employee.
create view emp_info as 
select e.emp_no, e.first_name, e.last_name, e.sex, s.salary 
from employees as e
join salaries as s
	on (s.emp_no = e.emp_no);

select * from emp_info;

drop view emp_info;

--List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date from employees
where right(hire_date, 4) = '1986';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
create view manager_info as
select dm.dept_no, d.dept_name, dm.emp_no,e.last_name, e.first_name
from dept_manager as dm
join departments as d
on (dm.dept_no = d.dept_no)
join employees as e
on (dm.emp_no = e.emp_no);

select * from manager_info;

drop view manager_info;
--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
create view employee_dept_info as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as dm
on (e.emp_no = dm.emp_no)
join departments as d
on (dm.dept_no = d.dept_no);

select * from employee_dept_info;

drop view employee_dept_info;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
create view Hercules_b as
select e.first_name, e.last_name, e.sex
from employees as e
where (e.first_name = 'Hercules' and e.last_name like 'B%');

select * from Hercules_b;

drop view Hercules_b;

--List each employee in the Sales department, including their employee number, last name, and first name.
create view departments_emp as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de
on (e.emp_no = de.emp_no)
join departments as d
on (de.dept_no = d.dept_no);

select * from departments_emp
where (departments_emp.dept_name = 'Sales');

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from departments_emp
where (departments_emp.dept_name = 'Sales' or departments_emp.dept_name = 'Development');

drop view departments_emp;

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(emp_no) as frequency_last_name
from employees
group by last_name;

