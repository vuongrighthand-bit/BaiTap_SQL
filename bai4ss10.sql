CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255),
                          stock INT
);

CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        product_id INT,
                        quantity INT
);
create or replace function ft_poo()
returns trigger
language plpgsql
as $$
    begin
        if tg_op ='insert' then update products set stock= stock - new.quantity where id=new.product_id;
        return new;
        end if;
        if tg_op = 'update' then
            if new.quantity>old.quantity then update products set stock = stock - (new.quantity-old.quantity)
                where id= new.product_id;
            else
                update products set stock= stock +(old.quantity - new.quantity)
                where id = new.product_id;
            end if;
            return new;
        end if;
        if tg_op ='delete' then update products set stock = stock + old.quantity
            where id = old.product_id;
        return old;
        end if;
        return null;
end;
$$;
create trigger change_ft_pooss
    before insert or update or delete on orders
    for each row
    execute function ft_poo();
drop table products;
drop table orders;
INSERT INTO products (name, stock) VALUES
                                       ('Sản phẩm A', 10),
                                       ('Sản phẩm B', 5),
                                       ('Sản phẩm C', 20),
                                       ('Sản phẩm D', 15),
                                       ('Sản phẩm E', 8);


