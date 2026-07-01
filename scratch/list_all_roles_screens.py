import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT role_key, COUNT(*) FROM screens GROUP BY role_key;")
    rows = cursor.fetchall()
    print("--- Screens per role ---")
    for r in rows:
        print(f"Role: {r[0]} -> {r[1]} screens")
    conn.close()

if __name__ == '__main__':
    main()
