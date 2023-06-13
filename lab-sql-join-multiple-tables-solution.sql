-- 1. Write a query to display for each store its store ID, city, and country.

select s.store_id, c.city, co.country
from sakila.store s
join sakila.address a using (address_id)
join sakila.city c using (city_id)
join sakila.country co using (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(p.amount) 
from sakila.store s 
join sakila.staff st using (store_id)
join sakila.payment p using (staff_id)
group by s.store_id;

-- 3. What is the average running time of films by category?

select c.name as category, round(avg(f.length),0) as "average time"
from sakila.film f
join sakila.film_category fc using (film_id)
join sakila.category c using (category_id)
group by c.name;

-- 4. Which film categories are longest?
-- if we understand this question as asking for the film category with the highest total length of all movies in the given category: 

select c.name as category, round(sum(f.length),0) as "total length"
from sakila.film f
join sakila.film_category fc using (film_id)
join sakila.category c using (category_id)
group by c.name
order by "total length" desc
limit 1;


-- 5. Display the most frequently rented movies in descending order.
-- showing top 10

select f.title, count(r.rental_id)
from sakila.film f 
join sakila.inventory i using (film_id)
join sakila.rental r using (inventory_id)
group by f.title
order by count(r.rental_id) desc
limit 10;

-- 6. List the top five genres in gross revenue in descending order.

select c.name, sum(p.amount) as revenue
from sakila.category c
join sakila.film_category fc using (category_id)
join sakila.film f using (film_id)
join sakila.inventory i using (film_id)
join sakila.rental r using (inventory_id)
join sakila.payment p using (rental_id)
group by c.name
order by revenue desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select i.inventory_id, f.title, r.rental_date, r.return_date from sakila.rental r
join sakila.inventory i using (inventory_id)
join sakila.film f using (film_id)
where f.title = "Academy Dinosaur" and i.store_id = 1
order by r.rental_date desc
limit 10;

-- Based on the results, we can see that Store 1 owns 4 copies of this movie, out of which 3 are available. 
-- In the previous lab we added one rental of this movie without a return_date (suggesting this copy hasn't been returned yet). 
-- For other 3 copies, they all seem to be returned and available for rent. 
