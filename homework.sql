--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating
--

create or replace procedure new_film(film_title varchar, des varchar, year1 integer, lang integer, duration integer, rate numeric(4,2), len integer, replace_cost numeric(5,2))            
language plpgsql
as $$
begin
	insert into film(title,description,release_year,language_id,rental_duration,rental_rate,"length",replacement_cost)
	values(film_title, des, year1 ,lang,duration,rate,len,replace_cost);
end;
$$


call new_film('Hello, WORLD!', 'Programming is the best!', 2024, 1, 10, 5.99, 200, 4.99 );
select *
from film f 
order by film_id desc
;
--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category
select * from category;

create or replace function num_of_films(id integer)
returns integer
language plpgsql
as $$
	 	declare film_count integer;
begin
		select count(*) as num_movies_in_cat into film_count
		from film_category f
		join category c
		on c.category_id = f.category_id 
		group by  f.category_id, c.name order by count(*) DESC;
		return film_count;
end;

$$;

select num_of_films(5);
select num_of_films(10);
