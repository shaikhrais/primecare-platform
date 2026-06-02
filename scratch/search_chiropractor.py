import sqlite3

db_path = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db'
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Search all tables for 'chiropractor' case-insensitive
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = [row[0] for row in cursor.fetchall()]

for table in tables:
    try:
        cursor.execute(f"PRAGMA table_info({table})")
        columns = [row[1] for row in cursor.fetchall()]
        
        # Build query to check if 'chiropractor' is in any column
        for col in columns:
            cursor.execute(f'SELECT "{col}" FROM "{table}" WHERE "{col}" LIKE "%chiropractor%" LIMIT 5')
            matches = cursor.fetchall()
            if matches:
                print(f"Table: {table}, Column: {col}")
                for m in matches:
                    print(f"  -> {m[0][:100]}")
    except Exception as e:
        pass

conn.close()
