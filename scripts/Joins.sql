
-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue
USING (movie_id)
ORDER BY worldwide_gross
LIMIT 1;

--Answer: "Semi-Tough"	1977	37187139

-- 2. What year has the highest average imdb rating?

SELECT release_year, ROUND(avg(imdb_rating),2) AS avg_rating
FROM specs
INNER JOIN rating
using (movie_id)
GROUP BY release_year
ORDER BY avg_rating DESC
LIMIT 5;

--Answer: 1991	7.45

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT film_title, company_name, worldwide_gross
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
USING (movie_id)
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 5;

--Answer: "Toy Story 4"	"Walt Disney "	1073394593

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT DISTINCT company_name, COUNT(specs.movie_id) as movies_released
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name;

-- "Twentieth Century Fox"	49
-- "Fox Searchlight Pictures"	1
-- "American International Pictures"	1
-- "Paramount Pictures"	51
-- "Lionsgate"	5

-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT company_name, ROUND(avg(film_budget), 2) AS avg_budget
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
USING (movie_id)
GROUP BY company_name
ORDER BY avg_budget DESC;

-- "Walt Disney "	148735526.32
-- "Sony Pictures"	139129032.26
-- "Lionsgate"	    122600000.00
-- "DreamWorks"	    121352941.18
-- "Warner Bros."	103430985.92

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT headquarters, film_title, imdb_rating
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN rating
USING (movie_id)
WHERE headquarters NOT LIKE '%, CA%'
ORDER BY imdb_rating DESC;

--Answer: "Dirty Dancing"	7.0

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT
CASE
	WHEN length_in_min >= 120 THEN '>2 Hours'
	ELSE '<2 Hours'
END AS lengthtext, ROUND(avg(imdb_rating), 2) AS avg_rating
FROM specs
INNER JOIN rating
USING (movie_id)
GROUP BY lengthtext
ORDER BY avg_rating DESC;

-- ">2 Hours"	7.25
-- "<2 Hours"	6.92

