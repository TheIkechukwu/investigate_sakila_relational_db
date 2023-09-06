/* Query 1: Query used for first insight */
SELECT category_name,
	SUM(rental_count) AS total_rental_count
FROM (
	SELECT  DISTINCT (title) AS film_title,
			name AS category_name,
			COUNT(title) OVER (PARTITION BY title) AS rental_count
	FROM category AS c
	JOIN film_category AS fc
	ON c.category_id = fc.category_id
	JOIN film AS f
	ON f.film_id = fc.film_id
	JOIN inventory AS i
	ON i.film_id = f.film_id
	JOIN rental AS r
	ON r.inventory_id = i.inventory_id
) t1
GROUP BY 1
ORDER BY 2 DESC;

/* Query 2: Query used for 2nd insight */
SELECT country,
		COUNT(*) AS number_of_customers
FROM (
	SELECT *
	FROM customer AS c
	JOIN address AS a
	ON c.address_id = a.address_id 
	JOIN city AS cty
	ON cty.city_id = a.city_id 
	JOIN country AS ct
	ON ct.country_id = cty.country_id
) t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

/* Query 3: Query used for 3rd insight */
SELECT  country,
		SUM(amount)
FROM (
	SELECT *
	FROM customer AS c
	JOIN address AS a
	ON c.address_id = a.address_id 
	JOIN city AS cty
	ON cty.city_id = a.city_id 
	JOIN country AS ct
	ON ct.country_id = cty.country_id
	JOIN payment AS p
	ON p.customer_id = c.customer_id
) t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

/* Query 4: Query used for 4th insight */
SELECT first_name ||' '||last_name AS Customer_name,
			COUNT(*) AS rental_count
FROM (
	SELECT *
	FROM customer AS c
	JOIN address AS a
	ON c.address_id = a.address_id
	JOIN city AS cty
	ON cty.city_id = a.city_id
	JOIN country AS ct
	ON ct.country_id = cty.country_id
	JOIN payment AS p
	ON p.customer_id = c.customer_id
	JOIN rental AS r
	ON r.rental_id = p.rental_id
) t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
