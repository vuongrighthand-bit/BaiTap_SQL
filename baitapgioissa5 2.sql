create schema baitapgioiss5;
set search_path to baitapgioiss5;
CREATE TABLE customers (
                           customer_id   SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100) NOT NULL,
                           city          VARCHAR(50)  NOT NULL
);

-- Thêm dữ liệu vào bảng customers
INSERT INTO customers (customer_id, customer_name, city) VALUES
                                                             (1, 'Nguyễn Văn A', 'Hà Nội'),
                                                             (2, 'Trần Thị B', 'Đà Nẵng'),
                                                             (3, 'Lê Văn C', 'Hồ Chí Minh'),
                                                             (4, 'Phạm Thị D', 'Hà Nội');
CREATE TABLE orders (
                        order_id    SERIAL PRIMARY KEY,
                        customer_id INT NOT NULL,
                        order_date  DATE NOT NULL,
                        total_price DECIMAL(10,2) NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Thêm dữ liệu vào bảng orders
INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
                                                                        (101, 1, '2024-12-20', 3000.00),
                                                                        (102, 2, '2025-01-05', 1500.00),
                                                                        (103, 1, '2025-02-10', 2500.00),
                                                                        (104, 3, '2025-02-15', 4000.00),
                                                                        (105, 4, '2025-03-01', 800.00);
CREATE TABLE order_items (
                             item_id    SERIAL PRIMARY KEY,
                             order_id   INT NOT NULL,
                             product_id INT NOT NULL,
                             quantity   INT NOT NULL,
                             price      DECIMAL(10,2) NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Thêm dữ liệu vào bảng order_items
INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
                                                                             (1, 101, 1, 2, 1500.00),
                                                                             (2, 102, 2, 1, 1500.00),
                                                                             (3, 103, 3, 5, 500.00),
                                                                             (4, 104, 2, 4, 1000.00);
SELECT c.customer_id,
       c.customer_name,
       SUM(o.total_price) AS total_revenue,
       COUNT(o.order_id)  AS order_count
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;
SELECT c.customer_id,
       c.customer_name,
       SUM(o.total_price) AS total_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    SELECT AVG(total_revenue)
    FROM (
             SELECT SUM(total_price) AS total_revenue
             FROM orders
             GROUP BY customer_id
         ) AS sub
);
SELECT c.city,
       SUM(o.total_price) AS total_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_revenue)
    FROM (
             SELECT SUM(o.total_price) AS city_revenue
             FROM customers c
                      JOIN orders o ON c.customer_id = o.customer_id
             GROUP BY c.city
         ) AS sub
);
SELECT c.customer_name,
       c.city,
       SUM(oi.quantity)       AS total_products,
       SUM(oi.quantity * oi.price) AS total_spending
FROM customers c
         INNER JOIN orders o ON c.customer_id = o.customer_id
         INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name, c.city;
SELECT c.customer_name,
       o.order_date,
       o.total_price AS total_amount
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id;
SELECT SUM(o.total_price) AS total_revenue,
       AVG(o.total_price) AS avg_order_value,
       MAX(o.total_price) AS max_order_value,
       MIN(o.total_price) AS min_order_value,
       COUNT(o.order_id)  AS order_count
FROM orders o;
SELECT c.city,
       SUM(o.total_price) AS total_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) > 10000;
SELECT c.customer_name,
       c.city,
       o.order_date,
       oi.product_id,
       oi.quantity,
       oi.price
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
         JOIN order_items oi ON o.order_id = oi.order_id;
SELECT c.customer_name,
       SUM(o.total_price) AS total_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_price) = (
    SELECT MAX(total_revenue)
    FROM (
             SELECT SUM(total_price) AS total_revenue
             FROM orders
             GROUP BY customer_id
         ) AS sub
);
SELECT city
FROM customers
UNION
SELECT c.city
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id;
SELECT city
FROM customers
INTERSECT
SELECT c.city
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id;
