USE ecommerce_sql;
SHOW TABLES;
USE ecommerce_sql;
DESCRIBE customers;
DESCRIBE order_items;
DESCRIBE payments;

##   SELECT + WHERE + ORDER BY
SELECT 
    id,
    full_name,
    loyalty_points
FROM customers
WHERE loyalty_points > 500
ORDER BY loyalty_points DESC;


##   GROUP BY + SUM + AVG
SELECT
    status,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
GROUP BY status
ORDER BY total_revenue DESC;

 ##   INNER JOIN
SELECT
    c.id AS customer_id,
    c.full_name,
    o.id AS order_id,
    o.order_date,
    o.status,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id
ORDER BY o.total_amount DESC;

##  LEFT JOIN
SELECT
    c.id AS customer_id,
    c.full_name,
    o.id AS order_id,
    o.order_date,
    o.total_amount
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
ORDER BY c.id;


##  RIGHT JOIN
SELECT
    o.id AS order_id,
    o.order_date,
    o.total_amount,
    p.id AS payment_id,
    p.payment_date,
    p.amount AS payment_amount,
    p.payment_method
FROM payments p
RIGHT JOIN orders o
    ON p.order_id = o.id
ORDER BY o.id;

##  SUBQUERY
SELECT
    id AS order_id,
    customer_id,
    order_date,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY total_amount DESC;

##  SUBQUERY + MAX
SELECT
    id AS order_id,
    customer_id,
    order_date,
    total_amount
FROM orders
WHERE total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);

##  CREATE VIEW
CREATE VIEW customer_order_analysis AS
SELECT
    c.id AS customer_id,
    c.full_name,
    o.id AS order_id,
    o.order_date,
    o.status,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id;
    
## created view
SELECT *
FROM customer_order_analysis
ORDER BY total_amount DESC;


## INDEX + QUERY OPTIMIZATION
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);
EXPLAIN
SELECT
    c.id AS customer_id,
    c.full_name,
    o.id AS order_id,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id
WHERE c.id = 10;


##  CUSTOMER REVENUE ANALYSIS
SELECT
    c.id AS customer_id,
    c.full_name,
    COUNT(o.id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS average_order_value
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.id, c.full_name
ORDER BY total_revenue DESC;























