create schema baiss11;
set search_path to baiss11;
CREATE TABLE flights (
                         flight_id SERIAL PRIMARY KEY,
                         flight_name VARCHAR(100),
                         available_seats INT
);
CREATE TABLE bookings (
                          booking_id SERIAL PRIMARY KEY,
                          flight_id INT REFERENCES flights(flight_id),
                          customer_name VARCHAR(100)
);
INSERT INTO flights (flight_name, available_seats)
VALUES
    ('VN123', 3),
    ('VN456', 2);
SELECT * FROM flights;
SELECT * FROM bookings;

BEGIN;

-- Giảm số ghế của chuyến bay 'VN123' đi 1
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- Thêm bản ghi đặt vé cho khách hàng 'Nguyen Van A'
INSERT INTO bookings (flight_id, customer_name)
VALUES (
           (SELECT flight_id FROM flights WHERE flight_name = 'VN123'),
           'Nguyen Van A'
       );

COMMIT;
-- Kiểm tra số ghế còn lại
SELECT * FROM flights;

-- Kiểm tra danh sách đặt vé
SELECT * FROM bookings;
BEGIN;

-- Giảm số ghế của chuyến bay 'VN123' đi 1
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- Lỗi: nhập sai flight_id (ví dụ: flight_id = 999 không tồn tại)
INSERT INTO bookings (flight_id, customer_name)
VALUES (999, 'Nguyen Van A');

-- Hủy toàn bộ thay đổi
ROLLBACK;
SELECT * FROM flights;
SELECT * FROM bookings;

