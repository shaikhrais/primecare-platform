import sqlite3

db_path = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db'
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Get rows from translation_keys and translation_values
cursor.execute("""
    SELECT k.key_code, k.default_text, v.locale_code, v.translated_text 
    FROM translation_keys k 
    LEFT JOIN translation_values v ON k.id = v.key_id 
    WHERE k.key_code LIKE '%chiropractor_dashboard%'
    ORDER BY k.key_code, v.locale_code
""")
rows = cursor.fetchall()
for r in rows:
    print(f"Key: {r[0]} | Default: {r[1]} | Locale: {r[2]} | Trans: {r[3]}")

conn.close()
