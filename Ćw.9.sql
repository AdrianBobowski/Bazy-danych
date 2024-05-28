USE AdventureWorks2019;

---1) 

BEGIN TRANSACTION;

UPDATE Production.Product 
SET ListPrice = 1.1 * ListPrice 
WHERE ProductID = 680;

COMMIT;


---2)

SELECT * FROM Production.Product WHERE ProductID = 707;

BEGIN TRANSACTION;

DELETE FROM Production.Product
WHERE ProductID = 707;

ROLLBACK;


---3)

BEGIN TRANSACTION;

INSERT INTO Production.Product
(
    Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color,  SafetyStockLevel,
    ReorderPoint, StandardCost, ListPrice, DaysToManufacture,
	ProductSubcategoryID, ProductModelID, SellStartDate, rowguid,
    ModifiedDate
)
VALUES
(
    'HL Mountain Frame - Silver, 39', 'FR-M94S-53', 1, 1,'black', 500, 350, 20.00, 
	50.00, 5, 1, 1, GETDATE(), NEWID(), GETDATE()              
);

COMMIT;


---4)

BEGIN TRANSACTION
UPDATE Production.Product
SET StandardCost = StandardCost * 1.1

IF(SELECT SUM(StandardCost) FROM Production.Product) > 50000
BEGIN
	ROLLBACK;
END

ELSE
BEGIN
	COMMIT;
END;

---5)

BEGIN TRANSACTION

IF EXISTS (SELECT * FROM Production.Product WHERE ProductNumber = 'FR-M94S-53')
BEGIN
	PRINT 'The product already exists'
	ROLLBACK;
END

ELSE
BEGIN
	INSERT INTO Production.Product
(
    Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color,  SafetyStockLevel,
    ReorderPoint, StandardCost, ListPrice, DaysToManufacture,
	ProductSubcategoryID, ProductModelID, SellStartDate, rowguid,
    ModifiedDate
)
VALUES
(
    'HL Mountain Frame - Silver, 39', 'FR-M94S-53', 1, 1,'black', 500, 350, 20.00, 
	50.00, 5, 1, 1, GETDATE(), NEWID(), GETDATE()              
);
END;


---6)

BEGIN TRANSACTION
IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
	PRINT 'Transakcja wycofana'
	ROLLBACK;
END

ELSE
BEGIN
	UPDATE Sales.SalesOrderDetail
	SET OrderQty += 10;
	COMMIT;
END;

SELECT * FROM Sales.SalesOrderDetail;


---7)

BEGIN TRANSACTION

DECLARE @mean FLOAT;
DECLARE @number INT;

SELECT @mean = AVG(StandardCost) FROM Production.Product;

SELECT @number = COUNT(*) FROM Production.Product 
WHERE StandardCost > @mean;

IF @number > 10
BEGIN
	PRINT 'Transakcja odrzucona'
	ROLLBACK;
END

ELSE
BEGIN
	DELETE FROM Production.Product WHERE StandardCost > @mean
	COMMIT;
END;


