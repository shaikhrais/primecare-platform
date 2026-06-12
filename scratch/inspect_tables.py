import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = [r[0] for r in cursor.fetchall()]
    print(f"Total tables: {len(tables)}")
    print("Tables list:")
    for t in sorted(tables):
        print(f"  {t}")
    conn.close()

if __name__ == '__main__':
    main()
