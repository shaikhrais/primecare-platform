import sqlite3
import os
import sys
import json

# Absolute project root path
PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "No query provided"}))
        sys.exit(1)
        
    query = sys.argv[1]
    params = []
    if len(sys.argv) > 2:
        try:
            params = json.loads(sys.argv[2])
        except Exception as e:
            params = [sys.argv[2]]
            
    try:
        conn = sqlite3.connect(DB_PATH)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        cursor.execute(query, params)
        if query.strip().lower().startswith(("insert", "update", "delete", "replace")):
            conn.commit()
            result = [{"changes": cursor.rowcount, "lastrowid": cursor.lastrowid}]
        else:
            rows = cursor.fetchall()
            result = [dict(r) for r in rows]
        print(json.dumps(result))
        conn.close()
    except Exception as e:
        print(json.dumps({"error": str(e)}))
        sys.exit(1)

if __name__ == '__main__':
    main()
