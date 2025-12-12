set search_path to bai3ss8;
CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           emp_name VARCHAR(100),
                           job_level INT,
                           salary NUMERIC
);
create or replace procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
language plpgsql
as $$
   declare salary numeric;
       job_level int ;
    begin
       select job_level, salary into salary, job_level
       from employees
       where emp_id = p_emp_id;
       if current_salary is null then
            raise notice 'không tìm thấy nhân viên có id % ', p_emp_id;
            p_new_salary := 0;
            return ;

       end if;
         case job_level
             when 1 then p_new_salary := salary *1.05;
             when 2 then p_new_salary := salary * 1.10;
             when 3 then p_new_salary := salary *1.15;
             raise notice ' job_level % không hợp lệ ', job_level;
             p_new_salary := salary;
             end case;
       update employees
       set salary = p_new_salary
       where emp_id = p_emp_id;
       raise notice ' lương mới của nhân viên % là % ', p_new_salary, p_emp_id;


end;
$$;
call adjust_salary(10000,3)x
select p_new_salary;
