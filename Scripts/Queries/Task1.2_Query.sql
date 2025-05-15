-- Task 1.2:

-- Customers with only active DslProducts and no active TvProducts
SELECT c.Id, c.Email, c.Address
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM DslProducts dsl
    WHERE dsl.CustomerId = c.Id
        AND dsl.StartDate < GETDATE()
        AND (dsl.EndDate > GETDATE() OR dsl.EndDate IS NULL)
)
AND NOT EXISTS (
    SELECT 1
    FROM TvProducts tv
    WHERE tv.CustomerId = c.Id
        AND tv.StartDate < GETDATE()
        AND (tv.EndDate > GETDATE() OR tv.EndDate IS NULL)
);
