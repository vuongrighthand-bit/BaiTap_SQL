set search_path to bai2ss8;
CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);
create or replace procedure check_stock(p_id int, p_qty int )
language plpgsql
as $$
    declare
        current_qty int;
 begin
select quantity
into current_qty
from inventory
where product_id = p_id;
if current_qty is null then
raise notice 'sản phẩm id % không tồn tại', p_id;
elsif current_qty >= p_qty then
    raise notice 'đủ hàng : yêu cầu %, tồn kho % ', p_qty, current_qty ;
    else
        raise notice 'KHông đur hàng : yêu cầu %, tồn kho %', p_qty , current_qty;
        end if;
end
;
$$;
call check_stock(1,10);
call check_stock(99999,10);