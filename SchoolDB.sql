CREATE DATABASE SchoolDB;
create schema school;
set search_path to school;
create table Students(
    student_id serial primary key not null ,
    name varchar(50) not null ,
    dirth_of_birth date

);
create table Courses(
    course_id serial primary key not null ,
    course_name varchar(50) ,
    credtis int
);
create table Enrollments(
    enrollment_id serial primary key not null ,
    studen_id int ,
    course_id int ,
    grace varchar(1) check ( grace in ( 'A', 'B', 'C', 'D'))

);