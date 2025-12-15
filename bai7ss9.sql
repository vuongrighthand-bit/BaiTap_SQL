CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(255),
                           email VARCHAR(255)
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        amount NUMERIC,
                        order_date DATE
);
create or replace procedure add_order(p_customer_id INT, p_amount NUMERIC)
language plpgsql
as $$
    declare id_khachhang int;
begin
        select customer_id into id_khachhang from customers where customer_id = p_customer_id;
        if id_khachhang is null then raise exception ' khach hang khong ton tai ';
            else
            insert into orders(customer_id, amount, order_date)
            values (p_customer_id,p_amount,current_date );
            end if;

end;
$$;
create schema bai8ss9;
set search_path to baitapss9;