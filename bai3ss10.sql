create schema bai3ss10;
set search_path to bai3ss10;
CREATE TABLE employees (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(50),
                           position TEXT,
                           salary NUMERIC(10,2)
);
CREATE TABLE employees_log (
                               id SERIAL PRIMARY KEY,
                               employee_id INT,
                               operation VARCHAR(10),
                               old_data JSONB,
                               new_data JSONB,
                               change_time TIMESTAMP DEFAULT NOW()
);
CREATE OR REPLACE FUNCTION employ_ft()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN

    IF TG_OP = 'INSERT' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (
                   NEW.id,
                   'INSERT',
                   NULL,
                   TO_JSONB(NEW)
               );
        RETURN NEW;
    END IF;


    IF TG_OP = 'UPDATE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (
                   NEW.id,
                   'UPDATE',
                   TO_JSONB(OLD),
                   TO_JSONB(NEW)
               );
        RETURN NEW;
    END IF;


    IF TG_OP = 'DELETE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (
                   OLD.id,
                   'DELETE',
                   TO_JSONB(OLD),
                   NULL
               );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;
CREATE TRIGGER change_employ_ft
    AFTER INSERT OR UPDATE OR DELETE ON employees
    FOR EACH ROW
EXECUTE FUNCTION employ_ft();
INSERT INTO employees(name, position, salary)
VALUES ('Nguyễn Văn A', 'Developer', 15000000);
UPDATE employees
SET salary = 20000000
WHERE id = 1;
DELETE FROM employees WHERE id = 1;




