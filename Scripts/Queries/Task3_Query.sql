-- Task 3:

-- Create result table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DuplicateCustomerAccounts')
CREATE TABLE DuplicateCustomerAccounts (
    CustomerIdTv INT,
    CustomerIdDsl INT,
    StartDate DATETIME
);

-- Clear existing data
TRUNCATE TABLE DuplicateCustomerAccounts;

-- Insert duplicate accounts
WITH DuplicateCustomers AS (
    SELECT c1.Id AS CustomerIdTv, c2.Id AS CustomerIdDsl
    FROM Customers c1
    INNER JOIN Customers c2 
        ON c1.Email = c2.Email 
        AND c1.Address = c2.Address 
        AND c1.Id < c2.Id
)
INSERT INTO DuplicateCustomerAccounts (CustomerIdTv, CustomerIdDsl, StartDate)
SELECT 
    dc.CustomerIdTv,
    dc.CustomerIdDsl,
    (SELECT MAX(StartDate) 
     FROM (
         SELECT MAX(tv.StartDate) AS StartDate
         FROM TvProducts tv 
         WHERE tv.CustomerId = dc.CustomerIdTv
         UNION ALL
         SELECT MAX(dsl.StartDate) 
         FROM DslProducts dsl 
         WHERE dsl.CustomerId = dc.CustomerIdDsl
     ) AS LatestDates
    ) AS StartDate
FROM DuplicateCustomers dc
WHERE EXISTS (
    SELECT 1 
    FROM TvProducts tv 
    WHERE tv.CustomerId = dc.CustomerIdTv
)
AND EXISTS (
    SELECT 1 
    FROM DslProducts dsl 
    WHERE dsl.CustomerId = dc.CustomerIdDsl
);

SELECT * FROM DuplicateCustomerAccounts;