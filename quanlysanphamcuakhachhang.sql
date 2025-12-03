create schema baitapkha2;
set search_path to baitapkha2;
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(50),
                          category VARCHAR(50),
                          price DECIMAL(10,2),
                          stock INT
);

-- Thêm dữ liệu mẫu
INSERT INTO products (name, category, price, stock) VALUES
  ('Laptop Dell', 'Electronics', 1500.00, 5),
  ('Chuột Logitech', 'Electronics', 25.50, 50),
  ('Bàn phím Razer', 'Electronics', 120.00, 20),
  ('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
  ('Máy giặt Samsung', 'Home Appliances', 600.00, 2);

insert into products(name,category,price,stock)
values ( 'Điều hòa Panasonic',  'Home Appliances',  400.00, 10);
UPDATE products set stock = 7 where name = 'Laptop Dell';
delete from products
where stock = 0;
select * from products
order by price ASC;
select distinct category
from products;
select * from products
order by price between 100 and 1000;
select * from products
where name ilike 'LG%' or name ilike 'Samsung%';
select * from products
order by price desc
limit 2;

