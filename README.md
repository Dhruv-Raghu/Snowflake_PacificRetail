# Snowflake_PacificRetail
## Case Study
PacificRetail is a (imaginary) rapidly growing e-commerce company operating in 15 countries across North America and Europe. With over 5 million active customers and a catalog of more than 100,000 products, PacificRetail is facing significant challenges in managing and analyzing its growing data volumes.

PacificRetail aims to implement a modern data engineering solution using Snowflake to address these challenges. It wants to create a centralized database by consolidating data from various sources into Snowflake. It also looking a solution which can help to reduce data processing time to enable near to real-time reporting and analytics. Leveraging Snowflake's cloud native architecture can help to grow and scale to any heights and can manage the growing data problems of PacificRetail. As a part of the solution, they also want to implement data quality checks and standardization processes within the data pipeline.

## Implementation
The approach would be to create a multi-layer data warehouse architecture using Snowflake where we have three layers: the Bronze layer for data ingestion, Silver layer for clean and transform data, and Gold layer for business level aggregates and data mods.

### [Bronze Layer](https://github.com/Dhruv-Raghu/Snowflake_PacificRetail/tree/main/Bronze)
The Bronze Layer focuses on data ingestion from from Azure Data Lake Storage to Snowflake. This is done by creating an external stage specifying the location of the data in the Azure Data Lake Storage container in [ExternalStageCreation.sql](Bronze/1_ExternalStageCreation.sql). Using the External Stage, the data can be imported into Snowflake using defined 'tasks'. These tasks can be scheduled to run at certain times throghout the day to automate data ingestion and regularly update the data. [CustomerLoad.sql](Bronze/2_CustomerLoad.sql), [ProductLoad.sql](Bronze/3_ProductLoad.sql) and [OrderLoad.sql](Bronze/4_OrdersLoad.sql) focus on creating the tables and scheduling data ingestion using the external stage.

Finally, a stream is created for each of the tables to track and save any changes made to the tables in [StreamCreation.sql](Bronze/5_StreamCreation.sql). These streams can be used to identify changes in the bronze layer tables and make updates to the corresponding tables in the Silver Layer.

<img width="379" alt="Screenshot 2024-11-27 at 3 26 33 PM" src="https://github.com/user-attachments/assets/fad3ac17-a7c2-4c0c-832d-1ccfacef2e8d">

### [Silver Layer](https://github.com/Dhruv-Raghu/Snowflake_PacificRetail/tree/main/Silver)
The Silver Layer focuses on data cleaning and transformations. It uses the raw data from the bronze layer and transforms it to fit the needs of the company. These transformations include cleaning missing or abnormal values, data validation, and getting rid of unused or unimportant data. 

#### [Customer Data Transformations](Silver/2_CustomerTransform.sql)
| Transformation              | Details                                                         |
| --------------------------  | ----------------------------------------------------------------|
| Email Validation            | Ensures Email is not null                                       |
| Customer Type               | Normalizes Customer Types to 'Regular', 'Premium' or 'Unknown'  |
| Age Verification            | Ensures age is between 18 and 120                               |
| Gender Standardization      | Classifies gender as 'Male', 'Female' or 'Other'                |
| Total Purchases Validation  | Ensures total purchases is a number defaulting to 0 if invalid  |

#### [Product Data Transformations](Silver/3_ProductTransform.sql)
| Transformation              | Details                                                         |
| --------------------------  | ----------------------------------------------------------------|
| Price Validation            | Ensures Price is a postive number                               |
| Stock Quantity Validation   | Ensures Stock quantity is non-negative                          |
| Rating Validation           | Ensures Rating is between 0 and 5                               |

#### [Orders Data Transformations](Silver/4_OrdersTransform.sql)
| Transformation              | Details                                                         |
| --------------------------  | ----------------------------------------------------------------|
| Amount Validation           | Ensures Transaction Amount is greater than 0                    |
| Transaction ID Validation   | Ensures Transaction ID is not null                              |
