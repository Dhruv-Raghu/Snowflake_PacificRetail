USE pacificretail_db.bronze;

-- Streams record changes made to tables

-- Raw customer table stream
CREATE OR REPLACE STREAM customer_changes_stream ON TABLE raw_customer
    APPEND_ONLY = TRUE;
-- Raw product table stream
CREATE OR REPLACE STREAM product_changes_stream ON TABLE raw_product
    APPEND_ONLY = TRUE;
-- Raw order table stream    
CREATE OR REPLACE STREAM order_changes_stream ON TABLE raw_order
    APPEND_ONLY = TRUE;

-- view created streams
SHOW STREAMS IN pacificretail_db.bronze;

-- SELECT * FROM CUSTOMER_CHANGES_STREAM;
