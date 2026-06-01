import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("PRAGMA table_info(screens);")
    cols = [col[1] for col in cursor.fetchall()]
    print("ALL COLUMNS OF screens:")
    for col in cols:
        print(f"  {col}")
    conn.close()

if __name__ == '__main__':
    main()
