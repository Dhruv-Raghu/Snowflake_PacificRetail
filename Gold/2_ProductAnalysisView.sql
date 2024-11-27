USE pacificretail_db.gold;

-- This view can be used to analyse the well performing product categories by gender
CREATE OR REPLACE VIEW VW_PROD_ANALYSIS AS
SELECT
    p.CATEGORY,
    c.GENDER,
    SUM(o.TOTAL_AMOUNT) AS TOTAL_SALES,
    AVG(p.RATING) AS AVG_RATING
FROM SILVER.ORDERS AS o
JOIN SILVER.PRODUCT AS p 
    ON o.product_id = p.product_id
JOIN SILVER.CUSTOMER AS c
    ON o.customer_id = c.customer_id
GROUP BY
    CATEGORY,
    GENDER
ORDER BY
    GENDER,
    TOTAL_SALES DESC;

SELECT * FROM VW_PROD_ANALYSIS;
