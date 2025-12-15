set search_path to baitapss9;
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_amount NUMERIC
);
select * from orders where customer_id = 1;
-- [2025-12-15 14:02:15] 0 rows retrieved in 476 ms (execution: 6 ms, fetching: 470 ms)
create index idx_customer_id on orders (customer_id);
select * from orders where customer_id = 1;
-- [2025-12-15 14:04:07] 0 rows retrieved in 402 ms (execution: 5 ms, fetching: 397 ms)