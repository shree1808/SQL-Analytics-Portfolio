-- ### 2. **Advanced Joins and Aggregations**
--    - Write a query to find the top 5 customers who rented the most films across all categories.
--    - How would you modify the query to exclude customers who have not rented any films in the last 6 months?
--    - Write a query to show the total number of rentals per customer, but only for customers who have rented more than 10 films.

WITH top_customer_flag AS (
	SELECT CONCAT(c.first_name , '  ' , c.last_name) as customer_name,
	cc.name AS category_name,
	COUNT(f.film_id) AS total_films_rented
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fm on f.film_id = fm.film_id
join category cc on fm.category_id = cc.category_id
GROUP BY 1,2
)
SELECT *
FROM (
SELECT 	*,
		DENSE_RANK() OVER(ORDER BY total_films_rented DESC) AS rank
FROM top_customer_flag
)
WHERE rank <=5;
