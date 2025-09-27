# DumAnalyticsMusic 🎵

## About the Company
**DumAnalyticsMusic** is a data analytics company that focuses on exploring the music industry.  
We provide insights for streaming platforms by analyzing data about Spotify artists, their popularity, followers, genres, and relationships with other artists.  

## About the Project
This project uses the **Spotify Artist Metadata Top 10k** dataset from Kaggle.  
The main goal is to analyze artists and genres, identify popularity trends, and explore connections between them.  
The project will be developed throughout the trimester, with new tasks expanding the analysis and visualizations step by step.  

Dataset: [Spotify Artist Metadata Top 10k (Kaggle)](https://www.kaggle.com/datasets/jackharding/spotify-artist-metadata-top-10k)

## Tools and Technologies
- Python (pandas, matplotlib, psycopg2)
- PostgreSQL (database)
- SQL (queries and schema design)
- Apache Superset (visualization)

## Example Analytics

![screenshot](images/analytics_example.png)  

## How to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/Dumi7417/DumAnalyticsMusic.git
   cd DumAnalyticsMusic
2. Install requirements:
   ```bash
   pip install -r requirements.txt
3. Create the PostgreSQL database:
   ```bash
   createdb spotifydb
4. Load the schema:
   ```bash
   psql -d spotifydb -f schema.sql
5. Load the dataset into the database:
   ```bash
   python load_data.py
6. Run analytics queries:
   ```bash
   python main.py
7. (Optional) Start Apache Superset for dashboards:
   ```bash
   superset run -p 8088


