-- Tổng thay đổi theo log
WITH deltas AS (
    SELECT
        t.account_id,
        SUM(CASE WHEN t.trans_type = 'DEPOSIT' THEN t.amount
                 WHEN t.trans_type = 'WITHDRAW' THEN -t.amount
                 ELSE 0 END) AS delta
    FROM transactions t
    GROUP BY t.account_id
)
SELECT a.account_id, a.customer_name, a.balance, d.delta
FROM accounts a
         LEFT JOIN deltas d ON d.account_id = a.account_id
ORDER BY a.account_id;
