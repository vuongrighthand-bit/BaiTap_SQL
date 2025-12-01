CREATE DATABASE LibraryDB;
Create schema Library;
set search_path to Library;
create table Books(
                      book_id int primary key ,
                      title varchar(100) ,
                      author varchar(50) ,
                      published_year int ,
                      available boolean

);
create table members(
                        member_id serial primary key ,
                        name varchar (50) ,
                        email text ,
                        join_date date

);