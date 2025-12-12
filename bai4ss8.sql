set search_path to bai4ss8;
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          discount_percent INT
);
INSERT INTO products (name, price, discount_percent) VALUES
                                                         ('Laptop Lenovo', 15000000, 10),
                                                         ('Chuột Logitech', 350000, 5),
                                                         ('Bàn phím cơ Akko', 1200000, 15),
                                                         ('Màn hình LG 24 inch', 3200000, 10),
                                                         ('Tai nghe Sony WH-1000XM4', 6000000, 20),
                                                         ('Ổ cứng SSD 1TB', 2500000, 5),
                                                         ('Điện thoại Samsung S23', 22000000, 10),
                                                         ('Loa Bluetooth JBL', 1800000, 15),
                                                         ('Máy in Canon LBP2900', 2800000, 10),
                                                         ('Camera an ninh Xiaomi', 950000, 5);

create or replace procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC)
language plpgsql
as $$
    declare price_ok numeric(10,2);
        discount_ok int;
        begin
        select price into price_ok from products where id = p_id;
        select discount_percent into discount_ok from products where id = p_id;
        if discount_ok > 50 then update products set price = price - (price * 1/2) where id = p_id;
        else
            update products set price = price - ( price * discount_ok/100) where id=p_id;
end if;
        select price into p_final_price from products where id = p_id;


end;
$$;
call calculate_discount(1, null);