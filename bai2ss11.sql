set search_path to bai2ss11;
CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,
                          owner_name VARCHAR(100),
                          balance NUMERIC(10,2)
);
INSERT INTO accounts (owner_name, balance)
VALUES
    ('A', 500.00),
    ('B', 300.00);
BEGIN;

-- Giảm số dư tài khoản A đi 100.00
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Tăng số dư tài khoản B thêm 100.00
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'B';

COMMIT;
SELECT * FROM accounts;
BEGIN;

-- Giảm số dư tài khoản A đi 100.00
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Lỗi: cố ý nhập sai tên người nhận (ví dụ: 'Z' không tồn tại)
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'Z';

-- Nếu lỗi xảy ra, hủy toàn bộ giao dịch
ROLLBACK;
SELECT * FROM accounts;
