CREATE TABLE sales (
                       sale_id SERIAL PRIMARY KEY,
                       customer_id INT,
                       amount NUMERIC,
                       sale_date DATE
);
create or replace procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC)
language plpgsql
as $$
    begin
        select sum(amount) into total from sales
        where sale_date between start_date and end_date;
        if total is  null then total := 0;
        end if;



    end;
    $$;
call calculate_total_sales('2023-12-21','2022-12-12',null);
