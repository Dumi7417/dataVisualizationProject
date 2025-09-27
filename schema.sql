DROP TABLE IF EXISTS artist_genres CASCADE;
DROP TABLE IF EXISTS staging_artists CASCADE;
DROP TABLE IF EXISTS artist_cities CASCADE;
DROP TABLE IF EXISTS artist_countries CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS countries CASCADE;
DROP TABLE IF EXISTS artists CASCADE;


CREATE TABLE staging_artists (
  row_id INT,
  artist_index INT,
  artist TEXT,
  gender TEXT,
  age INT,
  type TEXT,
  country TEXT,
  city_1 TEXT,
  district_1 TEXT,
  city_2 TEXT,
  district_2 TEXT,
  city_3 TEXT,
  district_3 TEXT
);

CREATE TABLE artists (
  artist_id SERIAL PRIMARY KEY,
  artist_name TEXT NOT NULL,
  gender TEXT,
  age INT,
  type TEXT
);

CREATE TABLE countries (
  country_id SERIAL PRIMARY KEY,
  country_name TEXT UNIQUE NOT NULL
);

CREATE TABLE artist_countries (
  artist_id INT REFERENCES artists(artist_id) ON DELETE CASCADE,
  country_id INT REFERENCES countries(country_id) ON DELETE CASCADE,
  PRIMARY KEY (artist_id, country_id)
);

CREATE TABLE cities (
  city_id SERIAL PRIMARY KEY,
  city_name TEXT NOT NULL,
  district_name TEXT,
  country_id INT REFERENCES countries(country_id) ON DELETE CASCADE,
  UNIQUE (city_name, district_name, country_id)
);

CREATE TABLE artist_cities (
  artist_id INT REFERENCES artists(artist_id) ON DELETE CASCADE,
  city_id INT REFERENCES cities(city_id) ON DELETE CASCADE,
  PRIMARY KEY (artist_id, city_id)
);
