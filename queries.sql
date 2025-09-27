-- Query#1 Preview the first 10 artists
SELECT * FROM artists LIMIT 10;
--Query#2 Top 20 oldest artists
SELECT artist_name, gender, age
FROM artists
WHERE gender IS NOT NULL
ORDER BY age DESC
LIMIT 20;
--Query#3 Top 20 countries by number of artists
SELECT c.country_name, COUNT(*) AS artist_count
FROM countries c
JOIN artist_countries ac ON c.country_id = ac.country_id
GROUP BY c.country_name
ORDER BY artist_count DESC
LIMIT 20;
--Query#4 Top 20 cities by number of artists
SELECT ci.city_name, c.country_name, COUNT(*) AS artist_count
FROM cities ci
JOIN countries c ON ci.country_id = c.country_id
JOIN artist_cities ac ON ci.city_id = ac.city_id
GROUP BY ci.city_name, c.country_name
ORDER BY artist_count DESC
LIMIT 20;
--Query#5 Artist distribution by gender
SELECT gender, COUNT(*) FROM artists GROUP BY gender;
--Query#6 Artist distribution by type (Person/Group)
SELECT type, COUNT(*) FROM artists GROUP BY type;
--Query#7 Average age of artists by gender
SELECT AVG(age) AS avg_age, gender
FROM artists
WHERE age IS NOT NULL
GROUP BY gender;
--Query#8 Average artist age by country (Top-20)
SELECT c.country_name, AVG(age) AS avg_age
FROM artists a
JOIN artist_countries ac ON a.artist_id = ac.artist_id
JOIN countries c ON ac.country_id = c.country_id
WHERE a.age IS NOT NULL
GROUP BY c.country_name
ORDER BY avg_age DESC
LIMIT 20;
--Query#9 Average artist age by city (Top-20)
SELECT ci.city_name, AVG(age) AS avg_age
FROM artists a
JOIN artist_cities ac ON a.artist_id = ac.artist_id
JOIN cities ci ON ac.city_id = ci.city_id
WHERE a.age IS NOT NULL
GROUP BY ci.city_name
ORDER BY avg_age DESC
LIMIT 20;
--Query#10 Artist distribution by gender in countries (Top-20 )
SELECT c.country_name, gender, COUNT(*) AS cnt
FROM artists a
JOIN artist_countries ac ON a.artist_id = ac.artist_id
JOIN countries c ON ac.country_id = c.country_id
GROUP BY c.country_name, gender
ORDER BY cnt DESC
LIMIT 20;
