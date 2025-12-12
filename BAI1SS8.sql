set search_path to baitapss8;
CREATE TABLE order_detail (
                              id SERIAL PRIMARY KEY,
                              order_id INT,
                              product_name VARCHAR(100),
                              quantity INT,
                              unit_price NUMERIC
);
--C1
create or replace procedure calculate_order_total(order_id_input int, out total numeric)
language plpgsql
as $$
begin
 select sum(quantity * unit_price)
into total
from order_detail
where order_id = order_id_input;
end;
$$;
call calculate_order_total(1, 2500000);
