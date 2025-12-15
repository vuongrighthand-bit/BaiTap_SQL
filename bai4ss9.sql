CREATE TABLE sales (
                       sale_id SERIAL PRIMARY KEY,
                       customer_id INT,
                       product_id INT,
                       sale_date DATE,
                       amount NUMERIC
);
create view customersales as
    select  customer_id,
    sum(amount) as total_amount
from sales
group by customer_id;
select * from customersales where total_amount >1000;
UPDATE CustomerSales
SET total_amount = 5000
WHERE customer_id = 2;
