CREATE DATABASE IF NOT EXISTS pacificretail_db
CREATE SCHEMA IF NOT EXISTS bronze
USE pacificretial_db.bronze;

CREATE OR REPLACE STORAGE INTEGRATION azure_pacificretail_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = AZURE
    ENABLED = TRUE
    AZURE_TENANT_ID = '<enter tenant id here>'
    STORAGE_ALLOWED_LOCATIONS = ('<azure data lake storage location>'); 

DESC STORAGE INTEGRATION azure_pacificretail_integration;

-- use pacificretail_db.bronze
CREATE OR REPLACE STAGE adls_stage
    STORAGE_INTEGRATION = azure_pacificretail_integration
    URL = '<azure data lake storage location>'

-- -- To test if the created stage is working
-- ls @adls_stage
