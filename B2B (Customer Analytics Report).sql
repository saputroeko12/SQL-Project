SELECT * FROM orders_1 limit 5;
SELECT * FROM orders_2 limit 5;
SELECT * FROM customer limit 5;

-- 
SELECT 
    SUM(quantity) total_penjualan,
    SUM(quantity * priceeach) revenue
FROM
    orders_1;

SELECT 
    SUM(quantity) total_penjualan,
    SUM(quantity * priceeach) revenue
FROM
    orders_2
WHERE
    status = 'Shipped';
    
-- 
SELECT 
    quarter,
    SUM(quantity) total_penjualan,
    SUM(quantity * priceEach) revenue
FROM
    (SELECT 
        orderNumber, status, quantity, priceEach, 1 AS quarter
    FROM
        orders_1 UNION SELECT 
        orderNumber, status, quantity, priceEach, 2 AS quarter
    FROM
        orders_2) AS tabel_a
WHERE
    status = 'Shipped'
GROUP BY quarter;

-- 
SELECT 
    QUARTER(createdate) quarter,
    COUNT(DISTINCT customerid) total_customers
FROM
    (SELECT 
        customerid, createdate, QUARTER(createdate) AS quarter
    FROM
        customer
    WHERE
        createdate BETWEEN '2004-01-01' AND '2004-06-30') AS tabel_b
GROUP BY QUARTER(createdate);

-- 
SELECT 
    QUARTER(createdate) quarter,
    COUNT(DISTINCT customerid) total_customers
FROM
    (SELECT 
        customerid, createdate, QUARTER(createdate) AS quarter
    FROM
        customer
    WHERE
        createdate BETWEEN '2004-01-01' AND '2004-06-30'
            AND customerid IN (SELECT DISTINCT
                customerid
            FROM
                orders_1 UNION SELECT DISTINCT
                customerid
            FROM
                orders_2)) AS tabel_b
GROUP BY QUARTER(createdate);


-- 
SELECT 
    LEFT(productcode, 3) categoryid,
    COUNT(DISTINCT ordernumber) total_order,
    SUM(quantity) total_penjualan
FROM
    (SELECT 
        productcode,
            ordernumber,
            quantity,
            status,
            LEFT(productcode, 3) AS categoryid
    FROM
        orders_2
    WHERE
        status = 'Shipped') tabel_c
GROUP BY LEFT(productcode, 3)
ORDER BY COUNT(DISTINCT ordernumber) DESC;

--
SELECT 
    COUNT(DISTINCT customerID) AS total_customers
FROM
    orders_1;
SELECT 
    '1' AS quarter,
    (COUNT(DISTINCT customerID) * 100) / 25 AS q2
FROM
    orders_1
WHERE
    customerid IN (SELECT DISTINCT
            customerID
        FROM
            orders_2);

 