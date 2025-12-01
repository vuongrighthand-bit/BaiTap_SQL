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

Create schema Sales;
set search_path to sales;
create table Books(
                      book_id int primary key ,
                      title varchar(100) ,
                      author varchar(50) ,
                      published_year int ,
                      available boolean

);
create table members
(
    member_id serial primary key,
    name      varchar(50),
    email     text,
    join_date date
);
Create table Products(
    product_id serial primary key not null ,
    product_name varchar(50) not null ,
    price numeric ,
    stock_quantity int

);
create table orders(
    order_id serial primary key not null ,
    order_date date ,
    member_id int ,
    foreign key (member_id) references members(member_id)

);
create table orderdetails(
    orderdetail_id serial primary key not null ,
    order_id int ,
    product_id int ,
    quantity int ,
    foreign key (order_id) references orders(order_id) ,
    foreign key (product_id) references Products(product_id)

);
ALTER TABLE Books ADD COLUMN genre varchar(50);
ALTER TABLE members DROP COLUMN email;
DROP TABLE Sales.orderdetails;
