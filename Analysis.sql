CREATE DATABASE ecommerceLB;

Use ecommerceLB;

--Business Queries--

--1--How much total money has the platform made so far, and how has it changed over time?
SELECT 
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS Month,
    SUM(oi.price + oi.freight_value) AS Total_Revenue
FROM Orders_table o
JOIN Order_items_table oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY Month;

--2--Which product categories are the most popular, and how do their sales numbers compare?
SELECT 
    p.product_category_name,
    COUNT(oi.order_item_id) AS Total_Orders,
    SUM(oi.price) AS Total_Sales
FROM Order_items_table oi
JOIN Products_table p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Total_Orders DESC;

--3--What is the average amount spent per order, and how does it change depending on the product category or payment method?
SELECT 
    p.payment_type,
    pc.product_category_name,
    AVG(oi.price + oi.freight_value) AS Avg_Order_Value
FROM Order_items_table oi
JOIN Orders_table o ON oi.order_id = o.order_id
JOIN Payments_table p ON o.order_id = p.order_id
JOIN Products_table pc ON oi.product_id = pc.product_id
GROUP BY p.payment_type, pc.product_category_name
ORDER BY Avg_Order_Value DESC;

--4--How many active sellers are there on the platform, and does this number go up or down over time?

SELECT 
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS Month,
    COUNT(DISTINCT oi.seller_id) AS Active_Sellers
FROM Order_items_table oi
JOIN Orders_table o ON oi.order_id = o.order_id
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY Month;

--5--Which products sell the most, and how have their sales changed over time?
SELECT 
    p.product_category_name,
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS Month,
    COUNT(oi.order_item_id) AS Items_Sold,
    SUM(oi.price) AS Revenue
FROM Order_items_table oi
JOIN Orders_table o ON oi.order_id = o.order_id
JOIN Products_table p ON oi.product_id = p.product_id
GROUP BY p.product_category_name, FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY Revenue DESC;

--6--Do customer reviews and ratings help products sell more or perform better on the platform? 
SELECT 
    p.product_category_name,
    AVG(cr.review_score) AS Avg_Rating,
    COUNT(cr.review_id) AS Review_Count,
    SUM(oi.price) AS Total_Sales
FROM Customers_review_table cr
JOIN Orders_table o ON cr.order_id = o.order_id
JOIN Order_items_table oi ON o.order_id = oi.order_id
JOIN Products_table p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Avg_Rating DESC;



