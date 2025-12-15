set search_path to bai2ss9;
CREATE TABLE users (
                       user_id SERIAL PRIMARY KEY,
                       email VARCHAR(255),
                       username VARCHAR(100)
);
create index idx_hash_email on users using hash(email);
select * from users where email ='asd@gmail.com';
explain select * from users where email ='asd@gmail.com';
-- Index Scan using idx_hash_email on users  (cost=0.00..8.02 rows=1 width=738)
--   Index Cond: ((email)::text = 'asd@gmail.com'::text)
-- -- 