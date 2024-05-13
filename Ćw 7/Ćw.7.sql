USE AdventureWorks2019

CREATE SCHEMA "zad7";

---1)

CREATE OR REPLACE FUNCTION generate_fibonacci_sequence(n INT)
RETURNS INT
AS $$
DECLARE
    a INT := 0;
    b INT := 1;
    c INT;
    i INT := 1;
BEGIN
    IF n = 1 THEN
        RETURN NEXT a;
    ELSIF n = 2 OR n = 3 THEN
        RETURN NEXT b;
    ELSE
        WHILE i <= n LOOP
            IF i <= 2 THEN
                RETURN NEXT b;
            ELSE
                c := a + b;
                a := b;
                b := c;
                RETURN NEXT c;
            END IF;
            i := i + 1;
        END LOOP;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE print_fibonacci_sequence(n INT)
AS $$
DECLARE
    fib_num INT;
BEGIN
    FOR fib_num IN SELECT * FROM generate_fibonacci_sequence(n) LOOP
        RAISE NOTICE '%', fib_num;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL print_fibonacci_sequence(8);

---2)

CREATE OR ALTER TRIGGER UpperName 
ON Person.Person FOR UPDATE AS
BEGIN
	UPDATE Person.Person SET LastName = UPPER(LastName);
END

---3)

CREATE OR ALTER TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate 
FOR UPDATE AS
BEGIN
	SELECT @new = SalexTaxRate 
	FROM deleted;
	SELECT @old = SalexTaxRate 
	FROM inserted;
	
	IF ABS(@old - @new) > (0.30 * @old)
	BEGIN
		RAISERROR('You can not change TaxRate more than 30%', 1, 1)
	END
END
