CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'NCPL@1234';

CREATE DATABASE SCOPED CREDENTIAL sasToken 
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2024-11-07T00:28:04Z&st=2024-11-06T16:28:04Z&spr=https&sig=P%2FYOEjPdTVXowwADwLT9QRPoi4%2FMbA12eQ6tTvQ3T1Y%3D'

CREATE EXTERNAL FILE FORMAT delimitedTextFormat
WITH(
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS(
        FIRST_ROW = 2,
        STRING_DELIMITER = '"',
        FIELD_TERMINATOR = ','
    )
);
CREATE EXTERNAL DATA SOURCE extDataSource
WITH(
    LOCATION = 'https://saprogresstracker.blob.core.windows.net/raw/',
    CREDENTIAL= sasToken

);
CREATE EXTERNAL TABLE externalTable2
(
    Task_id INT,
    Category_ID INT,
    Customer_id INT,
    Task_name NVARCHAR(100),
    Start_date DATE,
    End_date DATE,
    Status NVARCHAR(50)

)
WITH
(
    LOCATION = 'Fact_progress/Fact_progress*',
    FILE_FORMAT=delimitedTextFormat,
     DATA_SOURCE = extDataSource
     
);
SELECT TOP 5 *
FROM externalTable2;

CREATE EXTERNAL TABLE extCategoryTbl
(
    
    Category_id INT,
    Category_name NVARCHAR(100),
)
WITH
(
    LOCATION = 'Dim_Category/Dim_Category*',
    FILE_FORMAT=delimitedTextFormat,
     DATA_SOURCE = extDataSource
     
);

SELECT * from extCategoryTbl;


CREATE EXTERNAL TABLE extCustomerTbl
(
    Customer_id INT,
    Customer_name NVARCHAR(100),
    Customer_email NVARCHAR(100)
)
WITH
(
    LOCATION = 'Dim_Customer/Dim_Customer*',
    FILE_FORMAT=delimitedTextFormat,
     DATA_SOURCE = extDataSource
     
);

SELECT * FROM extCustomerTbl
DROP EXTERNAL TABLE externalTable2;
DROP EXTERNAL TABLE extCustomerTbl;
DROP EXTERNAL TABLE extCategoryTbl;
DROP EXTERNAL DATA SOURCE extDataSource;
DROP EXTERNAL FILE FORMAT delimitedTextFormat;
DROP DATABASE SCOPED CREDENTIAL sasToken;
DROP MASTER KEY;

