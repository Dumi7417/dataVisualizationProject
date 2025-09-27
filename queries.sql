SELECT * FROM artists LIMIT 10;

SELECT artist_name, gender, age
FROM artists
WHERE gender IS NOT NULL
ORDER BY age DESC
LIMIT 20;

SELECT c.country_name, COUNT(*) AS artist_count
FROM countries c
JOIN artist_countries ac ON c.country_id = ac.country_id
GROUP BY c.country_name
ORDER BY artist_count DESC
LIMIT 20;

SELECT ci.city_name, c.country_name, COUNT(*) AS artist_count
FROM cities ci
JOIN countries c ON ci.country_id = c.country_id
JOIN artist_cities ac ON ci.city_id = ac.city_id
GROUP BY ci.city_name, c.country_name
ORDER BY artist_count DESC
LIMIT 20;

SELECT gender, COUNT(*) FROM artists GROUP BY gender;

SELECT type, COUNT(*) FROM artists GROUP BY type;

SELECT AVG(age) AS avg_age, gender
FROM artists
WHERE age IS NOT NULL
GROUP BY gender;

SELECT c.country_name, AVG(age) AS avg_age
FROM artists a
JOIN artist_countries ac ON a.artist_id = ac.artist_id
JOIN countries c ON ac.country_id = c.country_id
WHERE a.age IS NOT NULL
GROUP BY c.country_name
ORDER BY avg_age DESC
LIMIT 20;

SELECT ci.city_name, AVG(age) AS avg_age
FROM artists a
JOIN artist_cities ac ON a.artist_id = ac.artist_id
JOIN cities ci ON ac.city_id = ci.city_id
WHERE a.age IS NOT NULL
GROUP BY ci.city_name
ORDER BY avg_age DESC
LIMIT 20;

SELECT c.country_name, gender, COUNT(*) AS cnt
FROM artists a
JOIN artist_countries ac ON a.artist_id = ac.artist_id
JOIN countries c ON ac.country_id = c.country_id
GROUP BY c.country_name, gender
ORDER BY cnt DESC
LIMIT 20;
