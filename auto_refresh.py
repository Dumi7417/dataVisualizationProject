#!/usr/bin/env python3

import psycopg2
import random
import time
import sys

DB = {
    "dbname": "spotifydb",
    "user": "dbuser",
    "password": "",
    "host": "localhost",
    "port": "5432",
}

SLEEP_SECONDS = 10  # interval between inserts

def main():
    try:
        conn = psycopg2.connect(**DB)
    except Exception as e:
        print("ERROR: cannot connect to database:", e)
        sys.exit(1)

    cur = conn.cursor()

    # Pools for realistic values
    genders = ["male", "female", "mixed", "other", ""]
    types = ["person", "group"]

    # Load existing country IDs for valid foreign keys
    cur.execute("SELECT country_id FROM countries;")
    country_rows = cur.fetchall()
    country_ids = [r[0] for r in country_rows]

    if not country_ids:
        print("ERROR: No country_id values found in the database.")
        print("Make sure 'countries' table is populated.")
        conn.close()
        sys.exit(1)

    print("Starting auto data insertion... (Press Ctrl+C to stop)\n")

    try:
        while True:
            name = f"NewArtist_{random.randint(1000, 9999)}"
            gender = random.choice(genders)
            age = random.randint(18, 70)
            a_type = random.choice(types)
            country_id = random.choice(country_ids)

            try:
                # Insert into artists
                cur.execute(
                    """
                    INSERT INTO artists (artist_name, gender, age, type, country_id)
                    VALUES (%s, %s, %s, %s, %s)
                    RETURNING artist_id;
                    """,
                    (name, gender, age, a_type, country_id),
                )
                artist_id = cur.fetchone()[0]
                conn.commit()
                print(f"✅ Added artist: {name}, gender={gender or 'unknown'}, age={age}, type={a_type}")

            except Exception as e:
                conn.rollback()
                print("Insert failed, rolled back. Error:", e)

            time.sleep(SLEEP_SECONDS)

    except KeyboardInterrupt:
        print("\n🛑 Stopped by user.")
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    main()
