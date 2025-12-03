create schema baitapgioi;
set search_path to baitapgioi;
CREATE TABLE students (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          gender VARCHAR(10),
                          birth_year INT,
                          major VARCHAR(50),
                          gpa DECIMAL(3,2)
);

-- Thêm dữ liệu mẫu
INSERT INTO students (id, full_name, gender, birth_year, major, gpa) VALUES
                     (1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
                     (2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
                     (3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
                     (4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
                     (5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
                     (6, 'Lưu Đức Tài', NULL, 2004, 'Cơ khí', NULL),
                     (7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);
insert into students(full_name, gender, birth_year, major, gpa)
values ('Phan Hoang Nam',  'nam',  2003,  'CNTT',  3.8);
update students set gpa = 3.4 where full_name  ='Lê Quốc Cường';
delete from students
where gpa is null;
select major from students
order by gpa >= 3.0
limit 3;
select distinct major
from students;
select *
from students
where major = 'CNTT'
order by gpa desc, full_name asc;
select * from students
order by full_name ilike '%Nguyen';
select * from students
order by birth_year between 2001 and 2003;