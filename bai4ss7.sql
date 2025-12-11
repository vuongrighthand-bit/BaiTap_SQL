set search_path to bai4;
CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          region VARCHAR(50)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE,
                        status VARCHAR(20)
);

CREATE TABLE product (
                         product_id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         price DECIMAL(10,2),
                         category VARCHAR(50)
);

CREATE TABLE order_detail (
                              order_id INT REFERENCES orders(order_id),
                              product_id INT REFERENCES product(product_id),
                              quantity INT
);
INSERT INTO customer (full_name, region) VALUES
                                             ('Nguyen Van A', 'Hanoi'),
                                             ('Tran Thi B', 'HCM'),
                                             ('Le Van C', 'Da Nang'),
                                             ('Pham Thi D', 'Hue'),
                                             ('Hoang Van E', 'Can Tho'),
                                             ('Do Thi F', 'Hai Phong'),
                                             ('Nguyen Van G', 'Quang Ninh'),
                                             ('Tran Thi H', 'Nha Trang'),
                                             ('Le Van I', 'Vinh'),
                                             ('Pham Thi J', 'Bien Hoa');
INSERT INTO product (name, price, category) VALUES
                                                ('Laptop Dell', 1500.00, 'Electronics'),
                                                ('iPhone 14', 1200.00, 'Electronics'),
                                                ('Bàn học gỗ', 300.00, 'Furniture'),
                                                ('Ghế xoay', 150.00, 'Furniture'),
                                                ('Máy lọc nước', 250.00, 'Home'),
                                                ('Tủ lạnh LG', 800.00, 'Home'),
                                                ('Sách giáo khoa', 10.00, 'Books'),
                                                ('Tai nghe Sony', 100.00, 'Electronics'),
                                                ('Bình giữ nhiệt', 20.00, 'Accessories'),
                                                ('Đèn bàn LED', 35.00, 'Home');
INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
                                                                       (1, 1550.00, '2025-11-01', 'Completed'),
                                                                       (2, 1200.00, '2025-11-02', 'Completed'),
                                                                       (3, 450.00, '2025-11-03', 'Pending'),
                                                                       (4, 250.00, '2025-11-04', 'Completed'),
                                                                       (5, 800.00, '2025-11-05', 'Shipped'),
                                                                       (6, 110.00, '2025-11-06', 'Pending'),
                                                                       (7, 20.00, '2025-11-07', 'Completed'),
                                                                       (8, 135.00, '2025-11-08', 'Cancelled'),
                                                                       (9, 35.00, '2025-11-09', 'Completed'),
                                                                       (10, 300.00, '2025-11-10', 'Shipped');
INSERT INTO order_detail (order_id, product_id, quantity) VALUES
                                                              (1, 1, 1),
                                                              (2, 2, 1),
                                                              (3, 3, 1),
                                                              (4, 5, 1),
                                                              (5, 6, 1),
                                                              (6, 7, 5),
                                                              (7, 9, 1),
                                                              (8, 8, 1),
                                                              (9, 10, 1),
                                                              (10, 4, 2);
create view v_revenue_by_region as
    select c.region, sum (o.total_amount) as total_revenue
from customer c
join orders o on c.customer_id = o.customer_id
group by c.region
order by total_revenue desc
limit 3 ;
--c2
CREATE VIEW v_completed_orders AS
SELECT order_id, customer_id, total_amount, order_date, status
FROM orders
WHERE status = 'Completed'
        WITH CHECK OPTION;
UPDATE v_completed_orders
SET status = 'Shipped'
WHERE order_id = 1;
-- [2025-12-11 10:43:30] [44000] ERROR: new row violates check option for view "v_completed_orders"
-- [2025-12-11 10:43:30] Detail: Failing row contains (1, 1, 1550.00, 2025-11-01, Shipped).

