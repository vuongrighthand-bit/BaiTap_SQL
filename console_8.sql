CREATE DATABASE ElearningDB;
Create schema Elearning;
set search_path to Elearning;
Create table Students(
    Student_id serial primary key  not null ,
    First_name varchar(50) not null ,
    Last_name varchar(50) not null ,
    Email text unique not null

);
Create table Intructors(
    Intructor_id serial primary key not null ,
    First_name varchar(50) not null ,
    Last_name varchar(50) not null ,
    Email text unique not null
);

create table Courses(
    Course_id serial primary key ,
    Course_name varchar(50) ,
    Intructor_id int not null ,
    foreign key (Intructor_id) references Intructors(Intructor_id)
);

Create table Enrollments(
    Enrollment_id serial PRIMARY KEY not null ,
    Student_id int not null ,
    course_id int not null ,
    enroll_date date not null ,
    foreign key (Student_id) references Students(Student_id) ,
    foreign key (course_id) references Courses(Course_id)
);

Create table Assignments(
   Assignment_id serial primary key not null ,
    Course_id int not null ,
    title varchar(100) not null ,
    due_date date not null ,
    foreign key (Course_id) references Courses(Course_id)

);

Create table Submissions(
    Submission_id serial PRIMARY KEY not null ,
    Assignment_id int not null ,
    Student_id int not null ,
    Submission_date date not null ,
    grade NUMERIC(5,2) CHECK (grade BETWEEN 0 AND 100)
);