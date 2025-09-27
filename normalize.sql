TRUNCATE TABLE artists RESTART IDENTITY CASCADE;
TRUNCATE TABLE countries RESTART IDENTITY CASCADE;
TRUNCATE TABLE cities RESTART IDENTITY CASCADE;
TRUNCATE TABLE artist_countries RESTART IDENTITY CASCADE;
TRUNCATE TABLE artist_cities RESTART IDENTITY CASCADE;

INSERT INTO countries (country_name)
SELECT DISTINCT country
FROM staging_artists
WHERE country IS NOT NULL
  AND country <> 'n/a'
  AND country <> '';

INSERT INTO artists (artist_name, gender, age, type)
SELECT DISTINCT artist, gender, age, type
FROM staging_artists
WHERE artist IS NOT NULL
  AND artist <> '';

INSERT INTO artist_countries (artist_id, country_id)
SELECT a.artist_id, c.country_id
FROM artists a
JOIN staging_artists s ON a.artist_name = s.artist
JOIN countries c ON c.country_name = s.country
WHERE s.country IS NOT NULL
  AND s.country <> 'n/a'
  AND s.country <> ''
ON CONFLICT DO NOTHING;

INSERT INTO cities (city_name, district_name, country_id)
SELECT DISTINCT s.city_1, s.district_1, c.country_id
FROM staging_artists s
JOIN countries c ON s.country = c.country_name
WHERE s.city_1 IS NOT NULL
  AND s.city_1 <> 'n/a'
  AND s.city_1 <> '';

INSERT INTO cities (city_name, district_name, country_id)
SELECT DISTINCT s.city_2, s.district_2, c.country_id
FROM staging_artists s
JOIN countries c ON s.country = c.country_name
WHERE s.city_2 IS NOT NULL
  AND s.city_2 <> 'n/a'
  AND s.city_2 <> ''
ON CONFLICT DO NOTHING;

INSERT INTO cities (city_name, district_name, country_id)
SELECT DISTINCT s.city_3, s.district_3, c.country_id
FROM staging_artists s
JOIN countries c ON s.country = c.country_name
WHERE s.city_3 IS NOT NULL
  AND s.city_3 <> 'n/a'
  AND s.city_3 <> ''
ON CONFLICT DO NOTHING;

INSERT INTO artist_cities (artist_id, city_id)
SELECT a.artist_id, ci.city_id
FROM artists a
JOIN staging_artists s ON a.artist_name = s.artist
JOIN countries c ON s.country = c.country_name
JOIN cities ci ON ci.city_name = s.city_1
              AND ci.country_id = c.country_id
WHERE s.city_1 IS NOT NULL
  AND s.city_1 <> 'n/a'
  AND s.city_1 <> ''
ON CONFLICT DO NOTHING;

INSERT INTO artist_cities (artist_id, city_id)
SELECT a.artist_id, ci.city_id
FROM artists a
JOIN staging_artists s ON a.artist_name = s.artist
JOIN countries c ON s.country = c.country_name
JOIN cities ci ON ci.city_name = s.city_2
              AND ci.country_id = c.country_id
WHERE s.city_2 IS NOT NULL
  AND s.city_2 <> 'n/a'
  AND s.city_2 <> ''
ON CONFLICT DO NOTHING;

INSERT INTO artist_cities (artist_id, city_id)
SELECT a.artist_id, ci.city_id
FROM artists a
JOIN staging_artists s ON a.artist_name = s.artist
JOIN countries c ON s.country = c.country_name
JOIN cities ci ON ci.city_name = s.city_3
              AND ci.country_id = c.country_id
WHERE s.city_3 IS NOT NULL
  AND s.city_3 <> 'n/a'
  AND s.city_3 <> ''
ON CONFLICT DO NOTHING;
