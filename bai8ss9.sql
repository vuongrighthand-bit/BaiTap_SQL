CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(255),
                           total_spent NUMERIC DEFAULT 0
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        total_amount NUMERIC,
                        order_date DATE DEFAULT CURRENT_DATE
);
create or replace procedure add_order_and_update_customer(p_customer_id INT, p_amount NUMERIC)
    language plpgsql
as $$
declare id_kh int;
begin
    select customer_id into id_kh from customers where customer_id=p_customer_id;
    if id_kh is null then raise exception 'khach hang khong ton tai ';
    else
        insert into orders(customer_id, total_amount,order_date)
        values (p_customer_id,p_amount,current_date);
        update customers set total_spent = total_spent + p_amount where customer_id=p_customer_id;
    end if;

end;
$$;
