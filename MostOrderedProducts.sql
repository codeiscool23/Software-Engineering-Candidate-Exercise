  --When executed this query will display two columns one of the Top 10 Products
  --the other of the total quantity of those products labelled as "Total Ordered"
  --they will be output in descending order

SELECT TOP(10) ProductID, SUM(Quantity) AS "Total Ordered"
FROM [databasename].[dbo].[orders_tbl]
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC 