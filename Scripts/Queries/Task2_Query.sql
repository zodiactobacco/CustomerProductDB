-- Task 2:

WITH ActiveTvProducts AS (
    SELECT Id, CustomerId, Product, StartDate, EndDate
    FROM TvProducts
    WHERE StartDate < GETDATE()
        AND (EndDate > GETDATE() OR EndDate IS NULL)
)
SELECT 
    t1.Id AS ProductId1, 
    t1.CustomerId, 
    t1.Product, 
    t1.StartDate AS StartDate1, 
    t1.EndDate AS EndDate1,
    t2.Id AS ProductId2, 
    t2.Product AS Product2, 
    t2.StartDate AS StartDate2, 
    t2.EndDate AS EndDate2
FROM ActiveTvProducts t1
INNER JOIN ActiveTvProducts t2 
    ON t1.CustomerId = t2.CustomerId 
    AND t1.Id < t2.Id
WHERE t1.StartDate <= ISNULL(t2.EndDate, '9999-12-31')
    AND t2.StartDate <= ISNULL(t1.EndDate, '9999-12-31');