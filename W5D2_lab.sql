#Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT 
title,
length, 
rank() over (order by length desc) as Ranks_length
FROM film
WHERE length is not null or length <> 0;

#Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

SELECT 
title,
length,
rating, 
rank() over (partition by rating order by length desc) as "rank"
FROM film
WHERE length is not null or length <> 0;

#How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT 
    c.name as categories,
    COUNT(fc.film_id) as count_film
FROM 
    film_category fc
LEFT JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    count_film DESC;

#Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

SELECT
	a.actor_id,
	a.first_name,
	a.last_name,
	count(fa.film_id) 
FROM 
	actor a
JOIN 
	film_actor fa on a.actor_id = fa.actor_id
GROUP BY 
	a.actor_id
ORDER BY 
	count(fa.film_id) DESC;


#Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	count(r.rental_id) as "Count_rentals"
FROM 
	customer c
JOIN 
	rental r ON r.customer_id = c.customer_id
GROUP BY 
	c.customer_id
ORDER BY count(r.rental_id) DESC
LIMIT 1;

#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

SELECT
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM
    rental r
JOIN
    inventory i ON i.inventory_id = r.inventory_id
JOIN
    film f ON i.film_id = f.film_id
GROUP BY
    f.film_id,
    f.title
ORDER BY COUNT(r.rental_id) DESC
LIMIT 1;
