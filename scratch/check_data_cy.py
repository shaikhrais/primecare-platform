import sqlite3
import os
import json

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT id, screen_code, data_cy_required_json FROM screens WHERE data_cy_required_json IS NOT NULL LIMIT 20;")
    print("Samples of data_cy_required_json:")
    for row in cursor.fetchall():
        val = row["data_cy_required_json"]
        try:
            parsed = json.loads(val)
            print(f"ID: {row['id']} | Code: {row['screen_code']} | Type: {type(parsed)} | Value: {parsed}")
        except Exception as e:
            print(f"ID: {row['id']} | Code: {row['screen_code']} | Parse Error: {e} | Raw: {val}")
            
    conn.close()

if __name__ == '__main__':
    main()
