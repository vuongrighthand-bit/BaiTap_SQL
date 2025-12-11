set search_path to bai3;
CREATE TABLE post (
                      post_id SERIAL PRIMARY KEY,
                      user_id INT NOT NULL,
                      content TEXT,
                      tags TEXT[],
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
                           user_id INT NOT NULL,
                           post_id INT NOT NULL,
                           liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (user_id, post_id)
);
create index idx_hehe on post (is_public);
select * from post
where is_public = true and content ilike '%du lịch%';
create index idx_post_lower_content on post(lower(content));
SELECT * FROM post
WHERE LOWER(content) LIKE '%travel%';
--c2
create index idx_post_tag on post using gin (tags);
explain analyse
select * from post where tags > array ['travel'];
-- Seq Scan on post  (cost=0.00..19.25 rows=247 width=81) (actual time=0.006..0.006 rows=0.00 loops=1)
--   Filter: (tags > '{travel}'::text[])
-- Planning:
--   Buffers: shared hit=20 dirtied=1
-- Planning Time: 0.484 ms
-- Execution Time: 0.017 ms
--c3
CREATE INDEX idx_post_public
    ON post (created_at desc)
    WHERE is_public = TRUE;
select * from post
where is_public = true and created_at > now()   - interval '7 days';
--c4
create index idx_user_id on post (user_id);
create index idx_created_at_desc on post(created_at);
SELECT *
FROM post
WHERE user_id IN (101, 202, 303)
ORDER BY created_at DESC
LIMIT 50;
-- [2025-12-11 10:32:55] 0 rows retrieved in 331 ms (execution: 5 ms, fetching: 326 ms)