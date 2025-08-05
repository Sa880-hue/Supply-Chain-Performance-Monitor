-- --------------------------------------------
-- SUPPLY CHAIN PERFORMANCE MONITOR - SQL STRUCTURE
-- --------------------------------------------

-- CUSTOMERS TABLE
CREATE TABLE df_Customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_city VARCHAR(100),
    customer_state VARCHAR(100),
    customer_zip_code_prefix INT
);

-- ORDERS TABLE
CREATE TABLE df_Orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES df_Customers(customer_id)
);

-- ORDER ITEMS TABLE (with computed sales)
CREATE TABLE df_OrderItems (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    price FLOAT,
    shipping_charges FLOAT,
    sales FLOAT GENERATED ALWAYS AS (price + shipping_value) STORED,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES df_Orders(order_id)
);

-- PRODUCTS TABLE
CREATE TABLE df_Products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

-- PAYMENTS TABLE
CREATE TABLE df_Payments (
    order_id VARCHAR(50),
    payment_type VARCHAR(50),
    payment_sequential INT,
    payment_installments INT,
    payment_value FLOAT,
    PRIMARY KEY (order_id, payment_type),
    FOREIGN KEY (order_id) REFERENCES df_Orders(order_id)
);

-- --------------------------------------------
-- SAMPLE INSERTS
-- --------------------------------------------

INSERT INTO df_Customers VALUES ('c1', 'Sao Paulo', 'SP', 12345);
INSERT INTO df_Orders VALUES ('o1', 'c1', '2023-06-10 13:00:00', '2023-06-10 14:00:00');
INSERT INTO df_Products VALUES ('p1', 'electronics', 400, 30, 20, 25);
INSERT INTO df_OrderItems VALUES ('o1', 'p1', 's1', 150.00, 20.00, 170.00);
INSERT INTO df_Payments VALUES ('o1', 'credit_card', 1, 3, 170.00);

-- --------------------------------------------
-- UPDATE EXAMPLE
-- --------------------------------------------

-- Standardize full state names to abbreviations
UPDATE df_Customers
SET customer_state = 'SP'
WHERE customer_state = 'Sao Paulo';

-- --------------------------------------------
-- JOIN QUERIES
-- --------------------------------------------

-- Orders joined with customer details
SELECT o.*, c.customer_city, c.customer_state
FROM df_Orders o
JOIN df_Customers c ON o.customer_id = c.customer_id;

-- Order items with product details
SELECT oi.*, p.product_category_name
FROM df_OrderItems oi
JOIN df_Products p ON oi.product_id = p.product_id;

-- Full payment view per order
SELECT o.order_id, p.payment_type, p.payment_value
FROM df_Orders o
JOIN df_Payments p ON o.order_id = p.order_id;

-- --------------------------------------------
-- GROUP BY / AGGREGATES
-- --------------------------------------------

-- Total sales by product category
SELECT p.product_category_name, SUM(oi.sales) AS total_sales
FROM df_OrderItems oi
JOIN df_Products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC;

-- Average shipping per category
SELECT p.product_category_name, AVG(oi.freight_value) AS avg_shipping
FROM df_OrderItems oi
JOIN df_Products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING AVG(oi.freight_value) > 10;

-- Orders per state
SELECT c.customer_state, COUNT(o.order_id) AS total_orders
FROM df_Orders o
JOIN df_Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state;

-- Payment method distribution
SELECT payment_type, COUNT(*) AS count, SUM(payment_value) AS total_value
FROM df_Payments
GROUP BY payment_type
ORDER BY total_value DESC;

-- Installment analysis
SELECT payment_installments, COUNT(*) AS total_transactions
FROM df_Payments
GROUP BY payment_installments
ORDER BY payment_installments;

-- --------------------------------------------

