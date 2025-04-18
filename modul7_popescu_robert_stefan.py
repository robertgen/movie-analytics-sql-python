import mysql.connector
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="789878",
    database="movies"
)

query_genres = """
SELECT 
    g.genre_name,
    SUM(m.box_office) AS Castiguri_totale
FROM 
    movie_genre mg
JOIN 
    genre g ON mg.genre_id = g.genre_id
JOIN 
    movie m ON mg.movie_id = m.movie_id
GROUP BY 
    g.genre_name
ORDER BY 
    Castiguri_totale DESC
LIMIT 3;
"""
df_top_genres = pd.read_sql(query_genres, conn)

print(" Top 3 genuri după încasările totale:")
print(df_top_genres)

top_genuri = ", ".join(df_top_genres["genre_name"])
print(f"\n Recomandare: Compania ar trebui să investească în următorul an în genurile: {top_genuri}.")

plt.figure(figsize=(8, 6))
sns.barplot(data=df_top_genres, x="genre_name", y="Castiguri_totale", palette="magma")
plt.title("Top 3 genuri cu cele mai mari încasări")
plt.xlabel("Gen")
plt.ylabel("Încasări totale")
plt.tight_layout()
plt.show()

query_budget_box = """
SELECT 
    title,
    budget,
    box_office
FROM movie
WHERE budget IS NOT NULL AND box_office IS NOT NULL;
"""
df_budget_box = pd.read_sql(query_budget_box, conn)


query_avg = """
SELECT 
    AVG(budget) AS Buget_mediu, 
    AVG(box_office) AS Castig_mediu
FROM movie;
"""
df_avg = pd.read_sql(query_avg, conn)

print("\n Bugetul și câștigul mediu pe film:")
print(df_avg)

plt.figure(figsize=(10, 6))
sns.scatterplot(data=df_budget_box, x="budget", y="box_office")
plt.xlabel("Bugetul filmului")
plt.ylabel("Câștigul filmului")
plt.title("Corelație între buget și câștiguri")
plt.tight_layout()
plt.show()

correlation = df_budget_box[["budget", "box_office"]].corr().iloc[0, 1]
print(f"\n Coeficientul Pearson între buget și câștig: {correlation:.2f}")

if correlation >= 0.7:
    interpretare = "Există o corelație pozitivă puternică – bugetele mai mari tind să aducă încasări mai mari."
elif 0.3 <= correlation < 0.7:
    interpretare = "Există o corelație moderată – bugetul influențează câștigurile, dar nu decisiv."
elif 0.1 <= correlation < 0.3:
    interpretare = "Corelație slabă – bugetul are o influență redusă asupra câștigurilor."
else:
    interpretare = "Nu există o legătură semnificativă între buget și câștiguri."

print(f" Interpretare: {interpretare}")

query_tari = """
SELECT 
    c.country_name,
    AVG(m.box_office) AS Castig_mediu
FROM 
    movie m
JOIN 
    country c ON m.country_id = c.country_id
WHERE 
    m.box_office IS NOT NULL
GROUP BY 
    c.country_name
ORDER BY 
    Castig_mediu DESC
LIMIT 5;
"""
df_tari = pd.read_sql(query_tari, conn)

print("\n Top 5 țări cu cel mai mare câștig mediu pe film:")
print(df_tari)

plt.figure(figsize=(8, 6))
sns.barplot(data=df_tari, x="country_name", y="Castig_mediu", palette="coolwarm")
plt.title("Top 5 țări după câștigul mediu per film")
plt.xlabel("Țară")
plt.ylabel("Câștig mediu (box office)")
plt.tight_layout()
plt.show()

tari_recomandate = ", ".join(df_tari["country_name"])
print(f" Recomandare: Compania ar trebui să investească în producția de filme în următoarele țări: {tari_recomandate}.")

query_top_filme = """
SELECT 
    title,
    box_office
FROM 
    movie
WHERE 
    box_office IS NOT NULL
ORDER BY 
    box_office DESC
LIMIT 10;
"""
df_top_filme = pd.read_sql(query_top_filme, conn)

print("\n Top 10 cele mai de succes filme (după încasări):")
print(df_top_filme)

plt.figure(figsize=(10, 6))
sns.barplot(data=df_top_filme, x="box_office", y="title", palette="crest")
plt.title("Top 7 filme cu cele mai mari încasări")
plt.xlabel("Box Office")
plt.ylabel("Titlu Film")
plt.tight_layout()
plt.show()
conn.close()