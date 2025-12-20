set search_path to bai3ss11;
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          product_name VARCHAR(100),
                          stock INT,
                          price NUMERIC(10,2)
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_name VARCHAR(100),
                        total_amount NUMERIC(10,2),
                        created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE order_items (
                             order_item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_id INT REFERENCES products(product_id),
                             quantity INT,
                             subtotal NUMERIC(10,2)
);
BEGIN;

-- Kiểm tra tồn kho sản phẩm 1
SELECT stock INTO TEMP TABLE temp_stock1
FROM products
WHERE product_id = 1 AND stock >= 2;

-- Kiểm tra tồn kho sản phẩm 2
SELECT stock INTO TEMP TABLE temp_stock2
FROM products
WHERE product_id = 2 AND stock >= 1;

-- Nếu một trong hai bảng tạm không có dữ liệu → rollback
DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM temp_stock1) OR NOT EXISTS (SELECT 1 FROM temp_stock2) THEN
            RAISE EXCEPTION 'Không đủ hàng trong kho';
        END IF;
    END $$;

-- Tạo đơn hàng
INSERT INTO orders (customer_name, total_amount)
VALUES ('Nguyen Van A', 0)
RETURNING order_id INTO TEMP TABLE temp_order;

-- Lấy order_id vừa tạo
SELECT order_id INTO STRICT order_id FROM temp_order;

-- Thêm chi tiết sản phẩm
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES
    (order_id, 1, 2, (SELECT price FROM products WHERE product_id = 1) * 2),
    (order_id, 2, 1, (SELECT price FROM products WHERE product_id = 2) * 1);

-- Giảm tồn kho
UPDATE products SET stock = stock - 2 WHERE product_id = 1;
UPDATE products SET stock = stock - 1 WHERE product_id = 2;

-- Tính tổng tiền
UPDATE orders
SET total_amount = (
    SELECT SUM(subtotal)
    FROM order_items
    WHERE order_id = orders.order_id
)
WHERE order_id = order_id;

COMMIT;
-- Giảm tồn kho sản phẩm 1 xuống 0 để tạo lỗi
UPDATE products SET stock = 0 WHERE product_id = 1;

-- Bắt đầu transaction
BEGIN;

-- Kiểm tra tồn kho sản phẩm 1
SELECT stock INTO TEMP TABLE temp_stock1
FROM products
WHERE product_id = 1 AND stock >= 2;

-- Kiểm tra tồn kho sản phẩm 2
SELECT stock INTO TEMP TABLE temp_stock2
FROM products
WHERE product_id = 2 AND stock >= 1;

-- Nếu thiếu hàng → rollback
DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM temp_stock1) OR NOT EXISTS (SELECT 1 FROM temp_stock2) THEN
            ROLLBACK;
            RAISE NOTICE 'Giao dịch bị hủy do không đủ hàng';
        END IF;
    END $$;
-- Kiểm tra tồn kho
SELECT product_id, stock FROM products;

-- Kiểm tra đơn hàng
SELECT * FROM orders;

-- Kiểm tra chi tiết đơn hàng
SELECT * FROM order_items;
