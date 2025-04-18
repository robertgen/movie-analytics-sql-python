# 🎬 Movie Database Analysis (Python + MySQL)

This project performs insightful analysis on a movie database using Python, SQL, and data visualization libraries. It extracts key metrics like top-earning genres, correlation between movie budgets and revenues, and highlights countries and movies with high performance.

---

## 📌 What This Project Does

- Connects to a MySQL `movies` database.
- Retrieves and analyzes:
  - Top 3 genres by total box office earnings.
  - Correlation between budget and revenue using Pearson's coefficient.
  - Countries with the highest average movie earnings.
  - Top 10 highest-grossing films.
- Provides recommendations based on results (e.g., best genres or countries to invest in).
- Visualizes results with charts using Seaborn and Matplotlib.

---

## 🧰 Technologies Used

- Python 3
- MySQL
- Pandas
- Seaborn
- Matplotlib

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/robertgen/movie-analytics-sql-python.git
   cd movie-analytichs-sql-python
Make sure your MySQL server is running locally.

Import the database using the provided SQL file:

mysql -u root -p < movies_database(prs).sql
(Optional) Update MySQL credentials in the Python script if needed:

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="movies"
)

Run the Python script:
python modul7_popescu_robert_stefan.py

---

🧱 Database Schema
The movies database includes the following tables:

movie: Movie details including title, year, budget, box office, and foreign keys.
genre: List of genres.
country: List of countries.
language: List of languages.
director: List of directors.
movie_genre: Many-to-many relationship between movies and genres.

📊 Relationships
One movie can belong to multiple genres (movie_genre).
Each movie has one director, one country, and one language.
Foreign keys ensure referential integrity across the schema.

🧪 Sample Data
The SQL file includes sample data for:

10 movies
10 genres
10 directors
10 countries
10 languages
This makes it easy to test the script without additional data entry.

📈 Example Outputs

Top Genres by Revenue
Budget vs Box Office Correlation
Top Countries by Average Earnings
Top 10 Grossing Movies
All visualized using bar plots and scatter plots for easy interpretation.

✅ Recommendations Generated
The script prints human-friendly suggestions based on the analysis, such as:
What genres a production company should invest in
Which countries generate the most revenue per film
How strong the relationship is between movie budgets and revenues

📎 File Overview

modul7_popescu_robert_stefan.py – Python script with the full analysis
movies_database(prs).sql – SQL file to create and populate the database
README.md – Documentation file (this one)
