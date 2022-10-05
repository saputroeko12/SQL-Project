-- Overall Performance by Year
SELECT 
    YEAR(order_date) AS years,
    SUM(sales) AS sales,
    COUNT(order_quantity) AS number_of_order
FROM
    `sales store`
WHERE
    order_status = 'Order Finished'
GROUP BY YEAR(order_date);

-- Overall Performance by Product Subcategory
SELECT 
    YEAR(order_date) AS years,
    product_sub_category,
    SUM(sales) AS sales
FROM
    `sales store`
WHERE
    order_status = 'Order Finished'
        AND YEAR(order_date) > 2010
GROUP BY years , product_sub_category
ORDER BY years , sales DESC;

-- Promotion Effectiveness and Efficiency by Years
SELECT 
    YEAR(order_date) AS years,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND((SUM(discount_value) / SUM(sales)) * 100,
            2) AS burn_rate_percentage
FROM
    `sales store`
WHERE
    order_status = 'Order Finished'
GROUP BY years;

-- Promotion Effectiveness and Efficiency by Product Subcategory
SELECT 
    YEAR(order_date) AS years,
    product_sub_category,
    product_category,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND((SUM(discount_value) / SUM(sales)) * 100,
            2) AS burn_rate_percentage
FROM
    `sales store`
WHERE
    order_status = 'Order Finished'
        AND YEAR(order_date) = 2012
GROUP BY years , product_sub_category , product_category
ORDER BY sales DESC;

-- Customers Per Year
SELECT 
 YEAR(order_date) AS years, 
 COUNT(DISTINCT customer) AS number_of_customer
FROM `sales store`
WHERE order_status = 'Order Finished'
GROUP BY years
ORDER BY years;

-- New Customers Per Year
SELECT 
    YEAR(date_first_transaction) AS years,
    COUNT(DISTINCT customer) AS number_of_new_customer
FROM
    (SELECT 
        customer, MIN(order_date) AS date_first_transaction
    FROM
        `sales store`
    WHERE
        order_status = 'Order Finished'
    GROUP BY customer) AS table_a
GROUP BY years
ORDER BY years;



