CREATE TABLE customers (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(255),
                           credit_limit NUMERIC
);
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_amount NUMERIC
);
INSERT INTO customers (name, credit_limit) VALUES
                                               ('Khách hàng 1', 5000000),
                                               ('Khách hàng 2', 3000000),
                                               ('Khách hàng 3', 7000000),
                                               ('Khách hàng 4', 2000000),
                                               ('Khách hàng 5', 9000000);
INSERT INTO orders (customer_id, order_amount) VALUES
                                                   (1, 1500000),
                                                   (2, 500000),
                                                   (3, 2000000),
                                                   (4, 300000),
                                                   (5, 4500000);
create or replace function check_credit_limit()
returns trigger
language plpgsql
as $$
    declare tonghientai numeric;
           hanmuc numeric;
    begin
        select credit_limit into hanmuc
        from customers
        where id=new.customer_id;
        select sum(order_amount) into tonghientai
        from orders
        where customer_id = new.customer_id;
        if tonghientai + new.order_amount > hanmuc then raise exception 'vuot qua tin dung the ';
        end if;
        return new;

    end;$$;
create trigger trig_check_credit_limit
    before insert on orders
    for each row
    execute function check_credit_limit();
insert into orders(customer_id, order_amount) values (1,3000000);
select *from orders where id=1;
insert into orders(customer_id, order_amount) values (1,23210010293);
insert into customers(name, credit_limit) values (1,3000000);
INSERT INTO orders (customer_id, order_amount)
VALUES (1, 3000000);
