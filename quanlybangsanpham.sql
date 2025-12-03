CREATE SCHEMA BAITAPGIOI2;
SET SEARCH_PATH TO BAITAPGIOI2;
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          category VARCHAR(50),
                          price DECIMAL(12,2),
                          stock INT,
                          manufacturer VARCHAR(50)
);

-- Thêm dữ liệu mẫu
INSERT INTO products (id, name, category, price, stock, manufacturer) VALUES
(1, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
(2, 'Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
(3, 'Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
(4, 'Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
(5, 'iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
(6, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
(7, 'Tai nghe AirPods 3', 'Phụ kiện', 4500000, NULL, 'Apple');

insert into products( name, category, price, stock, manufacturer)
values ('Chuột không dây Logitech M170', 'Phụ kiện',  300000, 20, 'Logitech'
       );
UPDATE products set price = price *1/10 where manufacturer = 'Apple';
Delete from products where stock = 0;
select name from products
order by price BETWEEN 1000000 AND 30000000;
select * from products
where stock is null;
select distinct manufacturer
from products;
select * from products
order by price desc , name asc;

select * from products
where name ilike '%laptop%';
select * from products
order by name
    limit 2;
