set search_path to bai3ss9;
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          category_id INT,
                          price NUMERIC,
                          stock_quantity INT
);
create index idx_category_id on products(category_id);
cluster products using idx_category_id;
alter table products cluster on idx_category_id;
create index idx_price on products (price);
select * from products where price > 1000;
SELECT * FROM Products WHERE category_id = 2 ORDER BY price;
-- PostgreSQL sẽ dùng phần category_id của index để lọc nhanh các dòng thuộc đúng danh mục.

-- Thay vì quét toàn bộ bảng (Seq Scan), nó chỉ duyệt vùng dữ liệu có category_id tương ứng.
-- giảm số dòng, tăng tốc độ truy vấn 