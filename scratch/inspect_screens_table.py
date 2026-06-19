import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT sql FROM sqlite_master WHERE type='table' AND name='screens'")
    row = cursor.fetchone()
    if row:
        print(row[0])
    else:
        print("screens table not found")
    conn.close()

if __name__ == '__main__':
    main()
