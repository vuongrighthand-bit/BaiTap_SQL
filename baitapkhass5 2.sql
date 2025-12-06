create schema baitapss5;
set search_path to baitapss5;
CREATE TABLE products (
                          product_id   SERIAL PRIMARY KEY,
                          product_name VARCHAR(100) NOT NULL,
                          category     VARCHAR(50)  NOT NULL
);

-- Thêm dữ liệu vào bảng products
INSERT INTO products (product_id, product_name, category) VALUES
                                                              (1, 'Laptop Dell', 'Electronics'),
                                                              (2, 'IPhone 15', 'Electronics'),
                                                              (3, 'Bàn học gỗ', 'Furniture'),
                                                              (4, 'Ghế xoay', 'Furniture');
CREATE TABLE orders (
                        order_id    SERIAL PRIMARY KEY,
                        product_id  INT NOT NULL,
                        quantity    INT NOT NULL,
                        total_price DECIMAL(10,2) NOT NULL,
                        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Thêm dữ liệu vào bảng orders
INSERT INTO orders (order_id, product_id, quantity, total_price) VALUES
                                                                     (101, 1, 2, 2200.00),
                                                                     (102, 2, 3, 3300.00),
                                                                     (103, 3, 5, 2500.00),
                                                                     (104, 4, 4, 1600.00);

select p.category,
sum (o.total_price) as total_sales,
sum (o.quantity) as total_quantity
from orders o
join products p on p.product_id = o.product_id
group by p.category
having sum(o.total_price) >2000
order by total_sales desc
SELECT p.product_name,
       SUM(o.total_price) AS total_revenue
FROM orders o
         JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(o.total_price) = (
    SELECT MAX(total_revenue)
    FROM (
             SELECT SUM(total_price) AS total_revenue
             FROM orders
             GROUP BY product_id
         ) AS sub
);
SELECT p.category,
       SUM(o.total_price) AS total_sales
FROM orders o
         JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;
SELECT p.category
FROM orders o
         JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;