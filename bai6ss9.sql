CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(255),
                          price NUMERIC,
                          category_id INT
);
INSERT INTO products (name, price, category_id) VALUES
                                                    ('Laptop Dell Inspiron', 15000000, 1),
                                                    ('Chuột Logitech M331', 350000, 2),
                                                    ('Bàn phím cơ Keychron K2', 1800000, 2),
                                                    ('Màn hình Samsung 27 inch', 4200000, 3),
                                                    ('Tai nghe Sony WH-CH510', 1200000, 4);
create or replace procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC)
   language plpgsql
   as $$
  begin
      update products set price = price + ( price * p_increase_percent/100)
      where product_id = p_category_id;
end;
$$;
call update_product_price(1,200000);