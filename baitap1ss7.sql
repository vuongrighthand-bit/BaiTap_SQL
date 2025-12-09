create database baitapss7;
create schema baitapss7;
set search_path to baitapss7;
CREATE TABLE book (
                      book_id SERIAL PRIMARY KEY,
                      title VARCHAR(255),
                      author VARCHAR(100),
                      genre VARCHAR(50),
                      price DECIMAL(10,2),
                      description TEXT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO book (title, author, genre, price, description) VALUES
                                                                ('Lập trình C# cơ bản', 'Nguyễn Văn A', 'Công nghệ thông tin', 120000, 'Cuốn sách hướng dẫn lập trình C# từ cơ bản đến nâng cao.'),
                                                                ('Tiếng Anh giao tiếp', 'Trần Thị B', 'Ngoại ngữ', 95000, 'Giúp người học cải thiện kỹ năng giao tiếp tiếng Anh hàng ngày.'),
                                                                ('Tư duy phản biện', 'Lê Văn C', 'Kỹ năng sống', 87000, 'Phát triển khả năng phân tích và đánh giá thông tin.'),
                                                                ('Lịch sử Việt Nam', 'Phạm Quốc D', 'Lịch sử', 105000, 'Tổng hợp các sự kiện lịch sử quan trọng của Việt Nam.'),
                                                                ('Toán học vui', 'Ngô Thị E', 'Giáo dục', 98000, 'Giải thích các khái niệm toán học qua trò chơi và ví dụ thực tế.'),
                                                                ('Marketing hiện đại', 'Hoàng Minh F', 'Kinh tế', 135000, 'Chiến lược tiếp thị trong thời đại số.'),
                                                                ('Thiền và đời sống', 'Vũ Hồng G', 'Tâm lý học', 89000, 'Ứng dụng thiền trong cuộc sống để giảm căng thẳng.'),
                                                                ('Lập trình Python nâng cao', 'Nguyễn Văn A', 'Công nghệ thông tin', 145000, 'Kỹ thuật lập trình Python chuyên sâu cho dự án thực tế.'),
                                                                ('Văn học dân gian Việt Nam', 'Đặng Thị H', 'Văn học', 92000, 'Tuyển tập truyện cổ tích, ngụ ngôn và ca dao.'),
                                                                ('Kỹ năng quản lý thời gian', 'Trần Văn I', 'Kỹ năng sống', 99000, 'Phương pháp sắp xếp công việc hiệu quả và khoa học.');
-- c1
create index book_author on book(author);
select *from book where author Ilike '%rowling%';
create index book_genre on book using hash(genre);
select * from book where genre = 'Fantasy';
--c2
explain analyse select *from book where author Ilike '%rowling%';
-- Seq Scan on book  (cost=0.00..1.12 rows=1 width=912) (actual time=0.142..0.143 rows=0.00 loops=1)
--   Filter: ((author)::text ~~* '%rowling%'::text)
--   Rows Removed by Filter: 10
--   Buffers: shared hit=1
-- Planning Time: 0.283 ms
-- Execution Time: 0.176 ms

drop index book_author;
-- Seq Scan on book  (cost=0.00..1.12 rows=1 width=912) (actual time=0.078..0.078 rows=0.00 loops=1)
--   Filter: ((author)::text ~~* '%rowling%'::text)
--   Rows Removed by Filter: 10
--   Buffers: shared hit=1
-- Planning Time: 0.182 ms
-- Execution Time: 0.111 ms
--c3
create index genre_book on book(genre);
create index title_book on Book using gin(description);
CREATE EXTENSION pg_trgm;
CREATE EXTENSION btree_gin;
--c4
    create index genre_book on book(genre);
cluster book using genre_book;
-- B-tree index: phù hợp nhất cho truy vấn so sánh (=, <, >, BETWEEN) và ORDER BY.
--
-- GIN index: tối ưu cho tìm kiếm toàn văn (FULLTEXT), JSONB, mảng.
--
-- GiST index: dùng cho dữ liệu không gian, tìm kiếm gần đúng.
--
-- BRIN index: hiệu quả với bảng rất lớn có dữ liệu tuần tự (ví dụ: theo thời gian).
--
-- Hash index: chỉ hỗ trợ so sánh bằng (=), nhưng không khuyến khích vì kém ổn định, ít tính năng, và B-tree thường nhanh hơn trong hầu hết trường hợp.