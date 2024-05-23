
---1)

USE AdventureWorks2019;

WITH TempEmployeeInfo AS
(
SELECT pp.FirstName, pp.LastName, hre.JobTitle, hre.BirthDate, eph.Rate
FROM HumanResources.EmployeePayHistory eph
JOIN Person.Person pp 
ON eph.BusinessEntityID = pp.BusinessEntityID
JOIN HumanResources.Employee hre 
ON eph.BusinessEntityID = hre.BusinessEntityID
)

SELECT *FROM TempEmployeeInfo


---2)

USE AdventureWorksLT2019;

WITH Przychod AS
(
SELECT c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')' AS CompanyContract, SUM(h.TotalDue) AS Revenue
FROM SalesLT.Customer c 
JOIN SalesLT.SalesOrderHeader h ON c.CustomerID = h.CustomerID
GROUP BY c.CompanyName, c.FirstName, c.LastName
)

SELECT *FROM Przychod
ORDER BY Revenue DESC;

---3)

USE AdventureWorksLT2019;

WITH Sprzedaz AS
(
SELECT pc.Name AS Category, FORMAT(SUM(sod.LineTotal), '0.0') AS SalesValue 
FROM SalesLT.ProductCategory pc
JOIN SalesLT.Product p 
ON pc.ProductCategoryID = p.ProductCategoryID
JOIN SalesLT.SalesOrderDetail sod 
ON p.ProductID = sod.ProductID
GROUP BY pc.Name
)
SELECT *FROM Sprzedaz
