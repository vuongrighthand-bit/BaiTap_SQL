set search_path to bai2;
CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          email VARCHAR(100),
                          phone VARCHAR(15)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE
);
--c1
create view v_oder_summary as select from customer c join orders o on c.customer_id = o.customer_id;
--c2
select from v_oder_summary;
--c3
create view v_order_total as
select order_id , order_date, customer_id ,total_amount
from orders
where total_amount > 0
with check option;
create view v_monthly_sales as select from customer c join orders o on c.customer_id = o.customer_id;
drop view v_monthly_sales;
create view v_monthly_sales as
    select sum(total_amount)
from orders
group by order_date;
-- Xóa View thường
DROP VIEW v_monthly_sales;

-- Nếu muốn xóa mà không báo lỗi khi View không tồn tại
DROP VIEW IF EXISTS v_monthly_sales;
-- DROP VIEW chỉ xóa định nghĩa truy vấn, không ảnh hưởng dữ liệu gốc.

-- DROP MATERIALIZED VIEW xóa cả dữ liệu đã lưu trữ, giải phóng dung lượng.