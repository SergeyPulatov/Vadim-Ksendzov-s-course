--============================================================================HW2=================================================================================================
-- 1. Создать таблицу employees
-- id. serial,  primary key,
-- employee_name. Varchar(50), not null
-- Наполнить таблицу employee 70 строками

create table employees (
	id serial primary key,
	employee_name varchar (50) not null
);

insert into employees (id, employee_name)
values (default, 'Майа');

select * from employees;

--================================================================================

-- 2. Создать таблицу salary
-- id. Serial  primary key,
-- monthly_salary. Int, not null
--Наполнить таблицу salary 15 строками:
-- 1000
-- 1100
-- 1200
-- 1300
-- 1400
-- 1500
-- 1600
-- 1700
-- 1800
-- 1900
-- 2000
-- 2100
-- 2200
-- 2300
-- 2400
-- 2500

create table salary (
	id serial primary key,
	monthly_salary int not null
);

insert into salary (id, monthly_salary)
values (default, 2500);

select * from salary;

--==================================================================================

-- 3. Создать таблицу employee_salary
-- id. Serial  primary key,
-- employee_id. Int, not null, unique
-- salary_id. Int, not null
-- Наполнить таблицу employee_salary 40 строками:
-- в 10 строк из 40 вставить несуществующие employee_id

create table employee_salary (
	id serial primary key,
	employee_id int not null unique,
	salary_id int not null

);

insert into employee_salary (id, employee_id, salary_id)
values (default, 69, 15)

select * from employee_salary;

--==================================================================================

-- 4. Создать таблицу roles
-- id. Serial  primary key,
-- role_name. int, not null, unique
--Поменять тип столба role_name с int на varchar(30)
--Наполнить таблицу roles 20 строками:

create table roles (
	id serial primary key,
	role_name int not null unique
);

alter table roles
alter column role_name type varchar(30)
using role_name::varchar;

insert into roles (id, role_name)
values (default, 'Senior Automation QA engineer')

select * from roles;

--==================================================================================

-- 5. Создать таблицу roles_employee
-- id. Serial  primary key,
-- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
-- role_id. Int, not null (внешний ключ для таблицы roles, поле id)
-- Наполнить таблицу roles_employee 40 строками

create table roles_employee (
	id serial primary key,
	employee_id int not null unique,
	role_id int not null,
	foreign key (employee_id)
		references employees (id),
	foreign key (role_id)
		references roles (id)
)

insert into roles_employee (id, employee_id, role_id)
values (default, 54, 14);

select * from roles_employee;

--============================================================================HW3=================================================================================================

--1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.

select employee_name, monthly_salary 
from employees
join employee_salary
on employees.id = employee_salary.employee_id
join salary on salary.id=employee_salary.salary_id;

--2. Вывести всех работников у которых ЗП меньше 2000.

select employee_name, monthly_salary 
from employees
join employee_salary
on employees.id = employee_salary.employee_id
join salary on salary.id=employee_salary.salary_id
where monthly_salary < 2000;

--3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)

select employee_name, monthly_salary 
from employees
right join employee_salary
on employees.id = employee_salary.employee_id
join salary on salary.id=employee_salary.salary_id
where employee_name is null;

--4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)

select employee_name, monthly_salary 
from employees
right join employee_salary
on employees.id = employee_salary.employee_id
join salary on salary.id=employee_salary.salary_id
where employee_name is null and monthly_salary < 2000;

--5. Найти всех работников кому не начислена ЗП.

select employee_name, monthly_salary
from employees
left join employee_salary
on employees.id = employee_salary.employee_id
left join salary on salary.id=employee_salary.salary_id
where monthly_salary is null;


--6. Вывести всех работников с названиями их должности.

select employee_name, role_name
from employees
join roles_employee
on employees.id = roles_employee.employee_id
join roles on roles.id = roles_employee.role_id;

--7. Вывести имена и должность только Java разработчиков.

select employee_name, role_name
from employees
join roles_employee
on employees.id = roles_employee.employee_id
join roles on roles.id = roles_employee.role_id
where role_name like '%Java%';

--8. Вывести имена и должность только Python разработчиков.

select employee_name, role_name
from employees
join roles_employee
on employees.id = roles_employee.employee_id
join roles on roles.id = roles_employee.role_id
where role_name like '%Python%';


--9. Вывести имена и должность всех QA инженеров.

select employee_name, role_name
from employees
join roles_employee
on employees.id = roles_employee.employee_id
join roles on roles.id = roles_employee.role_id
where role_name like '%QA%';

--10. Вывести имена и должность ручных QA инженеров.

select employee_name, role_name
from employees
join roles_employee
on employees.id = roles_employee.employee_id
join roles on roles.id = roles_employee.role_id
where role_name like '%Manual QA%';

--11. Вывести имена и должность автоматизаторов QA

select employee_name, role_name
from employees
join roles_employee
on employees.id = roles_employee.employee_id
join roles on roles.id = roles_employee.role_id
where role_name like '%Automation QA%'

--12. Вывести имена и зарплаты Junior специалистов

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Junior%';

--13. Вывести имена и зарплаты Middle специалистов

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Middle%';

--14. Вывести имена и зарплаты Senior специалистов

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Senior%';

--15. Вывести зарплаты Java разработчиков

select monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Java%';

--16. Вывести зарплаты Python разработчиков

select monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Python%';

--17. Вывести имена и зарплаты Junior Python разработчиков

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Junior Python%';

--18. Вывести имена и зарплаты Middle JS разработчиков

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Middle JavaScript%';

--19. Вывести имена и зарплаты Senior Java разработчиков

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Senior Java%';

--20. Вывести зарплаты Junior QA инженеров

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Junior%QA%%';

--21. Вывести среднюю зарплату всех Junior специалистов

select avg(monthly_salary)
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Junior%';

--22. Вывести сумму зарплат JS разработчиков

select sum(monthly_salary)
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%JavaScript%';


--23. Вывести минимальную ЗП QA инженеров

select min(monthly_salary)
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%QA%';


--24. Вывести максимальную ЗП QA инженеров

select max(monthly_salary)
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%QA%';

--25. Вывести количество QA инженеров

select count(employee_name) 
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%QA%';

--26. Вывести количество Middle специалистов.

select count(employee_name) 
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%Middle%';

--27. Вывести количество разработчиков

select count(employee_name) 
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%developer%';

--28. Вывести фонд (сумму) зарплаты разработчиков.

select sum(monthly_salary) 
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where role_name like '%developer%';

--29. Вывести имена, должности и ЗП всех специалистов по возрастанию

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
order by monthly_salary;

--30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where monthly_salary between 1700 and 2300; 

--31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where monthly_salary < 2300
order by monthly_salary;

--32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000

select employee_name, monthly_salary, role_name
from employees
join employee_salary 
on employees.id = employee_salary.employee_id
join salary 
on salary.id = employee_salary.salary_id
join roles_employee
on employees.id = roles_employee.employee_id
join roles 
on roles.id = roles_employee.role_id
where monthly_salary in (1100, 1500, 2000)
order by monthly_salary;




