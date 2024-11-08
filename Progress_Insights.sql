--Query to find number of sections in each category--
SELECT Category_name, COUNT(externalTable2.Category_ID) AS Sectional_count
FROM extCategoryTbl
INNER JOIN  externalTable2
ON extCategoryTbl.Category_id = externalTable2.Category_ID
GROUP BY Category_name

--Query ro find total number tasks that are Completed, in progress and incomplete--
SELECT Customer_name, status, COUNT(status) AS Progress FROM extCustomerTbl
INNER JOIN externalTable2
ON extCustomerTbl.customer_id = externalTable2.customer_id
GROUP BY Customer_name,Status

select * from externalTable2



