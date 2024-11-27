USE DATABASE pacificretail_db;
CREATE SCHEMA IF NOT EXISTS GOLD;
USE pacificretail_db.gold;

-- This view can be used to analyse sales by region to see the best performing regions
CREATE OR REPLACE VIEW VW_REGION_ANALYSIS AS
SELECT
    CASE
        WHEN c.COUNTRY IN ('USA', 'Canada') THEN 'NA'
        WHEN c.COUNTRY IN ('Brazil') THEN 'SA'
        WHEN c.COUNTRY IN ('Australia') THEN 'AUS'
        WHEN c.COUNTRY IN ('Germany', 'UK', 'France') THEN 'EU'
        WHEN c.COUNTRY IN ('China', 'India', 'Japan') THEN 'ASIA'
        ELSE 'UNKNOWN'
    END AS REGION,
    o.STORE_TYPE,
    SUM(o.TOTAL_AMOUNT) AS TOTAL_SALES,
    AVG(o.TOTAL_AMOUNT) AS AVG_SALE,
    AVG(o.QUANTITY) AS AVG_QUANTITY
FROM SILVER.ORDERS AS o
JOIN SILVER.PRODUCT AS p 
    ON o.product_id = p.product_id
JOIN SILVER.CUSTOMER AS c
    ON o.customer_id = c.customer_id
GROUP BY
    REGION,
    o.STORE_TYPE
ORDER BY 
    TOTAL_SALES DESC,
    AVG_SALE DESC,
    AVG_QUANTITY DESC;

SELECT * FROM VW_REGION_ANALYSIS;
