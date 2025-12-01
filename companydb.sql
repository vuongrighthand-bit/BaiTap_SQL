CREATE DATABASE CompanyDB;
create schema Company;
set search_path to Company;
create table Employees(
                          emp_id serial primary key not null ,
                          name varchar(50) not null ,
                          date_of_birth date not null ,
                          department_id int not null

);
create table Departments(
                            department_id serial primary key not null ,
                            department_name varchar(50) not null

);
create table projects(
                         project_id serial primary key not null ,
                         name varchar(50) not null ,
                         start_date date ,
                         end_date date

);
create table EmployeeProjects(
                                 emp_id int ,
                                 project_id int ,
                                 foreign key (emp_id) references Employees(emp_id) ,
                                 foreign key (project_id) references projects(project_id)

);
ALTER TABLE Employees ADD foreign key (department_id) references Departments(department_id);
