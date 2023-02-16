use sakila;

-- Get all pairs of actors that worked together
select fa1.film_id, a1.actor_id, a1.last_name, a1.first_name, a2.actor_id, a2.last_name, a2.first_name from actor a1
join film_actor fa1 on a1.actor_id = fa1.actor_id
join film_actor fa2
on fa1.actor_id <> fa2.actor_id
and fa1.film_id = fa2.film_id
join actor a2 on fa2.actor_id = a2.actor_id;


-- Get all pairs of customers that have rented the same film more than 3 times
select r1.customer_id, r2.customer_id, r2.film_id from (
	select i.film_id, r.customer_id, count(r.rental_id)
    from rental r
    join inventory i on r.inventory_id = i.inventory_id
    group by i.film_id, r.customer_id
    having count(r.rental_id) > 1
    ) as r1
join (
	select r.customer_id, i.film_id, count(r.rental_id)
    from rental r
	join inventory i on r.inventory_id = i.inventory_id
	group by r.customer_id, i.film_id
	having count(r.rental_id) > 1
    ) as r2
on r1.film_id = r2.film_id
and r1.customer_id > r2.customer_id;

-- Get all possible pairs of actors and films
select * from film f
cross join film_actor fa on f.film_id = fa.film_id
cross join actor a on fa.actor_id = a.actor_id;