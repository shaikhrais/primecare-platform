import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT required_components_json FROM screens WHERE role_key = 'physician';")
    rows = cursor.fetchall()
    print("--- Physician Screen Components ---")
    for r in rows:
        print(r[0])
    conn.close()

if __name__ == '__main__':
    main()
