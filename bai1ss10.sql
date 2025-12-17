CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255),
                          price NUMERIC,
                          last_modified DATE
);
INSERT INTO products (name, price, last_modified) VALUES
                                                      ('Sản phẩm 1', 10000, CURRENT_DATE),
                                                      ('Sản phẩm 2', 20000, CURRENT_DATE),
                                                      ('Sản phẩm 3', 30000, CURRENT_DATE),
                                                      ('Sản phẩm 4', 40000, CURRENT_DATE),
                                                      ('Sản phẩm 5', 50000, CURRENT_DATE),
                                                      ('Sản phẩm 6', 60000, CURRENT_DATE),
                                                      ('Sản phẩm 7', 70000, CURRENT_DATE),
                                                      ('Sản phẩm 8', 80000, CURRENT_DATE),
                                                      ('Sản phẩm 9', 90000, CURRENT_DATE),
                                                      ('Sản phẩm 10', 100000, CURRENT_DATE);

create or replace function update_last_modified()
returns trigger
    language plpgsql

as $$
    begin
     new.last_modified := current_date;
     return new;
    end;$$
create trigger trg_update_last_modified
    before update on products
    for each row
    execute function update_last_modified();
update products set price = 50000000 where id =1;
select *from products where id=1;