create schema baitapkha;
set search_path to baitapkha;
CREATE TABLE students (

  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  major VARCHAR(50),
  gpa DECIMAL(3,2)
);

-- Thêm dữ liệu mẫu
INSERT INTO students (name, age, major, gpa) VALUES
  ('An', 20, 'CNTT', 3.5),
  ('Binh', 21, 'Toán', 3.2),
  ('Cường', 22, 'CNTT', 3.8),
  ('Dương', 20, 'Vật lý', 3.0),
  ('Em', 21, 'CNTT', 2.9);
insert into students(name, age, major,gpa)
values ('Hung', 23, 'Hoá học', 3.4);
update students set gpa = 3.6 where name = 'Binh';
delete from students
where gpa < 3.0;
select name, major from students
order by gpa desc ;
select name from students
where major = 'CNTT';
select name from students
where gpa between 3.0 and 3.6;
select * from students
where name ilike '%C%';
select * from students
order by name asc
limit 3;

