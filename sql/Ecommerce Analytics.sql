SHOW VARIABLES LIKE 'local_infile';
USE olist_ecommerce;
SHOW TABLES;
SELECT COUNT(*) AS total_customers
FROM olist_customers_dataset;

LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_customers_dataset.csv'
INTO TABLE olist_customers_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id, customer_unique_id, customer_zip_code_prefix,
 customer_city, customer_state);
 
 CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(geolocation_zip_code_prefix, geolocation_lat,
 geolocation_lng, geolocation_city, geolocation_state);
 SHOW WARNINGS;
 TRUNCATE TABLE olist_geolocation_dataset;
 ALTER TABLE olist_geolocation_dataset
MODIFY geolocation_zip_code_prefix VARCHAR(5),
MODIFY geolocation_lat DECIMAL(20,15),
MODIFY geolocation_lng DECIMAL(20,15);
ALTER TABLE olist_geolocation_dataset
MODIFY geolocation_lat DOUBLE,
MODIFY geolocation_lng DOUBLE;
SELECT COUNT(*) AS total_geolocation_records
FROM olist_geolocation_dataset;

CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_order_items_dataset.csv'
INTO TABLE olist_order_items_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, order_item_id, product_id, seller_id,
 shipping_limit_date, price, freight_value);
 SELECT COUNT(*) AS total_order_items
FROM olist_order_items_dataset;

CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, payment_sequential, payment_type,
 payment_installments, payment_value);
 SELECT COUNT(*) AS total_order_payments
FROM olist_order_payments_dataset;

CREATE TABLE olist_order_reviews_dataset (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(review_id, order_id, review_score, review_comment_title,
 review_comment_message, review_creation_date, review_answer_timestamp);
 TRUNCATE TABLE olist_order_reviews_dataset;
 SHOW warnings;
 SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids,
    SUM(review_creation_date IS NULL) AS missing_creation_dates,
    SUM(review_answer_timestamp IS NULL) AS missing_answer_timestamps
FROM olist_order_reviews_dataset;
SELECT
    review_id,
    COUNT(*) AS occurrences
FROM olist_order_reviews_dataset
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC
LIMIT 10;
 SELECT COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset;
SELECT
    review_id,
    order_id,
    review_score,
    review_creation_date,
    review_answer_timestamp
FROM olist_order_reviews_dataset
WHERE review_id = '08528f70f579f0c830189efc523d2182';
SELECT
    order_id,
    review_score,
    review_comment_title,
    review_comment_message
FROM olist_order_reviews_dataset
WHERE review_id = '08528f70f579f0c830189efc523d2182';
SELECT
    COUNT(*) AS total_rows,
    SUM(review_creation_date = '0000-00-00 00:00:00') AS invalid_creation_dates,
    SUM(review_answer_timestamp = '0000-00-00 00:00:00') AS invalid_answer_dates,
    MIN(review_creation_date) AS earliest_review,
    MAX(review_creation_date) AS latest_review
FROM olist_order_reviews_dataset;
SELECT
    COUNT(*) AS total_rows,
    SUM(review_creation_date IS NULL) AS missing_creation_dates,
    SUM(review_answer_timestamp IS NULL) AS missing_answer_dates,
    MIN(review_creation_date) AS earliest_review,
    MAX(review_creation_date) AS latest_review
FROM olist_order_reviews_dataset;
SELECT
    SUM(YEAR(review_creation_date) = 0) AS zero_creation_dates,
    SUM(YEAR(review_answer_timestamp) = 0) AS zero_answer_dates
FROM olist_order_reviews_dataset;

CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_sellers_dataset.csv'
INTO TABLE olist_sellers_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(seller_id, seller_zip_code_prefix, seller_city, seller_state);
SELECT COUNT(*) AS total_sellers
FROM olist_sellers_dataset;

CREATE TABLE olist_products_dataset (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_products_dataset.csv'
INTO TABLE olist_products_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(product_id, product_category_name, product_name_lenght,
 product_description_lenght, product_photos_qty, product_weight_g,
 product_length_cm, product_height_cm, product_width_cm);
 SHOW WARNINGS;
 SELECT COUNT(*) AS total_products
FROM olist_products_dataset;
SELECT
    SUM(product_name_lenght IS NULL) AS missing_name_length,
    SUM(product_description_lenght IS NULL) AS missing_description_length,
    SUM(product_photos_qty IS NULL) AS missing_photos,
    SUM(product_weight_g IS NULL) AS missing_weight,
    SUM(product_length_cm IS NULL) AS missing_length,
    SUM(product_height_cm IS NULL) AS missing_height,
    SUM(product_width_cm IS NULL) AS missing_width
FROM olist_products_dataset;
SELECT COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_product_ids
FROM olist_products_dataset;
SELECT COUNT(DISTINCT product_category_name) AS unique_categories
FROM olist_products_dataset;
SELECT COUNT(*) AS missing_categories
FROM olist_products_dataset
WHERE product_category_name IS NULL
   OR TRIM(product_category_name) = '';
   
DESCRIBE olist_order_items_dataset;
SELECT COUNT(*) AS total_rows
FROM olist_order_items_dataset;
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM olist_order_items_dataset;
SELECT COUNT(*) - COUNT(DISTINCT CONCAT(order_id, '-', order_item_id))
       AS duplicate_order_items
FROM olist_order_items_dataset;
DESCRIBE olist_orders_dataset;
SHOW TABLES;

CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);
LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_orders_dataset.csv'
INTO TABLE olist_orders_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, customer_id, order_status, order_purchase_timestamp,
 order_approved_at, order_delivered_carrier_date,
 order_delivered_customer_date, order_estimated_delivery_date);
 TRUNCATE TABLE olist_orders_dataset;
 LOAD DATA LOCAL INFILE
'C:/Users/anjal/Downloads/Ecommerce_Analytics/E commerce/olist_orders_dataset.csv'
INTO TABLE olist_orders_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_id,
    customer_id,
    order_status,
    @purchase_date,
    @approved_date,
    @carrier_date,
    @delivered_date,
    @estimated_date
)
SET
    order_purchase_timestamp = NULLIF(@purchase_date, ''),
    order_approved_at = NULLIF(@approved_date, ''),
    order_delivered_carrier_date = NULLIF(@carrier_date, ''),
    order_delivered_customer_date = NULLIF(@delivered_date, ''),
    order_estimated_delivery_date = NULLIF(@estimated_date, '');
    SELECT COUNT(*) AS total_orders
FROM olist_orders_dataset;

SELECT COUNT(*) AS total_payment_records
FROM olist_order_payments_dataset;
SELECT
    COUNT(*) - COUNT(DISTINCT order_id, payment_sequential)
    AS duplicate_payment_records
FROM olist_order_payments_dataset;
SELECT COUNT(*) AS total_geolocation_records
FROM olist_geolocation_dataset;
DESCRIBE olist_geolocation_dataset;
SELECT
    COUNT(*) AS total_orders,
    SUM(order_purchase_timestamp IS NULL) AS missing_purchase_dates
FROM olist_orders_dataset;

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS monthly_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

SHOW TABLES;

-- Query 20: Top 10 Product Categories by Revenue
-- Business Question: Which product categories generate the highest revenue?
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS category_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY category_revenue DESC
LIMIT 10;

-- Query 21: Top 10 Cities by Customer Count
-- Business Question: Which cities have the highest number of customers?
SELECT
    customer_city,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- Query 22: Top 10 Best-Selling Product Categories
-- Business Question: Which product categories have the highest sales volume?
SELECT
    p.product_category_name,
    COUNT(*) AS items_sold
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY items_sold DESC
LIMIT 10;

-- Query 23: Order Status Distribution
-- Business Question: How are orders distributed across different statuses?
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset),
        2
    ) AS percentage
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- Query 24: Average Order Value (AOV)
SELECT
    COUNT(DISTINCT o.order_id) AS total_delivered_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(
        SUM(oi.price + oi.freight_value) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- Query 25: Payment Type Analysis
SELECT
    payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- Query 26: Customer Review Score Analysis
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_order_reviews_dataset),
        2
    ) AS review_percentage
FROM olist_order_reviews_dataset
GROUP BY review_score
ORDER BY review_score DESC;

-- Query 27: Average Review Score by Product Category
SELECT
    p.product_category_name,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM olist_order_reviews_dataset r
JOIN olist_order_items_dataset oi
    ON r.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(r.review_id) >= 50
ORDER BY average_review_score DESC
LIMIT 10;

-- Query 28: Lowest-Rated Product Categories
SELECT
    p.product_category_name,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM olist_order_reviews_dataset r
JOIN olist_order_items_dataset oi
    ON r.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(r.review_id) >= 50
ORDER BY average_review_score ASC
LIMIT 10;

