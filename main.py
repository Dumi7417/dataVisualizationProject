import psycopg2
import pandas as pd
import os
import subprocess
import matplotlib.pyplot as plt

DB_NAME = "spotifydb"
DB_USER = "dbuser"
DB_PASSWORD = ""
DB_HOST = "localhost"
DB_PORT = "5432"
CSV_FILE = "spotify_artists.csv"

def run_sql_file(conn, filename):
    with open(filename, "r") as f:
        sql = f.read()
    with conn.cursor() as cur:
        cur.execute(sql)
    conn.commit()

with open("queries.sql", "r") as f:
    queries = [q.strip() for q in f.read().split(";") if q.strip()]

os.makedirs("results", exist_ok=True)

conn = psycopg2.connect(
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD,
    host=DB_HOST,
    port=DB_PORT
)

print("Connected to database:", DB_NAME)

print("\nRunning schema.sql...")
run_sql_file(conn, "schema.sql")

print("\nLoading CSV into staging_artists...")
subprocess.run([
    "psql",
    "-U", DB_USER,
    "-d", DB_NAME,
    "-c", f"\\copy staging_artists FROM '{CSV_FILE}' CSV HEADER"
])

print("\nRunning normalize.sql...")
run_sql_file(conn, "normalize.sql")

excel_writer = pd.ExcelWriter("results/results.xlsx", engine="xlsxwriter")

for i, query in enumerate(queries, start=1):
    print(f"\nRunning Query {i}:")
    df = pd.read_sql(query, conn)
    print(df.head())
    
    csv_file = f"results/query_{i}.csv"
    df.to_csv(csv_file, index=False)
    
    sheet_name = f"Query_{i}"
    df.to_excel(excel_writer, sheet_name=sheet_name, index=False)
    
    if not df.empty:
        plt.figure(figsize=(8,5))
        
        if i == 3:  
            df.plot(x="country_name", y="artist_count", kind="bar", legend=False, ax=plt.gca())
            plt.title("Top Countries by Number of Artists")
            plt.ylabel("Artist Count")
            plt.xticks(rotation=45, ha="right")
        
        elif i == 4:  
            df.plot(x="city_name", y="artist_count", kind="bar", legend=False, ax=plt.gca())
            plt.title("Top Cities by Number of Artists")
            plt.ylabel("Artist Count")
            plt.xticks(rotation=45, ha="right")
        
        elif i == 5:  
            df.plot(x="gender", y="count", kind="bar", legend=False, ax=plt.gca())
            plt.title("Artist Gender Distribution")
            plt.ylabel("Count")
        
        elif i == 6:  
            df.plot(x="type", y="count", kind="bar", legend=False, ax=plt.gca())
            plt.title("Artist Type Distribution")
            plt.ylabel("Count")
        
        elif i == 7:  
            df.plot(x="gender", y="avg_age", kind="bar", legend=False, ax=plt.gca())
            plt.title("Average Artist Age by Gender")
            plt.ylabel("Average Age")
        
        if plt.gca().has_data():
            chart_file = f"results/chart_{i}.png"
            plt.tight_layout()
            plt.savefig(chart_file)
            plt.close()
            print(f"Saved chart to {chart_file}")

excel_writer.close()
conn.close()

print("\nAll queries executed. Results saved to 'results/' folder and 'results/results.xlsx'.")
