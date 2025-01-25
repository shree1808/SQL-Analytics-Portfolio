use practise;

-- which of the 20 % products generate 80 % sales
select * from products;

-- Product wise sales
WITH product_wise_sales AS (
    SELECT 
        Name, 
        SUM(Price) AS total_sales 
    FROM 
        products 
    GROUP BY Name 
    ORDER BY total_sales DESC
), calc_sales_flag as (
SELECT 
	Name,
    total_sales,
    SUM(total_sales) OVER (ORDER BY total_sales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sales,
    0.8 * sum(total_sales) over() as eighty_percent_sales
FROM 
    product_wise_sales
)
select * from calc_sales_flag where running_sales <= eighty_percent_sales;

 

