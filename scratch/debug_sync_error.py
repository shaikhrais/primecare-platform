import os
import sqlite3
import json

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    # Let's inspect the unique constraint on screens
    cur.execute("PRAGMA index_list(screens);")
    for idx in cur.fetchall():
        print("Index:", dict(idx))
        cur.execute(f"PRAGMA index_info({idx['name']});")
        for col in cur.fetchall():
            print("  Col:", dict(col))

    conn.close()

if __name__ == '__main__':
    main()
