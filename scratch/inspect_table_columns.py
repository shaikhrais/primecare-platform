import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

def print_cols(table):
    c.execute(f"PRAGMA table_info({table})")
    cols = [col[1] for col in c.fetchall()]
    print(f"{table}: {cols}")

print_cols("apps")
print_cols("role_test_user_seeds")
print_cols("languages")

conn.close()
