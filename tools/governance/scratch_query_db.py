import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- TOTAL PUBLIC READ APIs (GET) ---")
    cursor.execute("SELECT count(*) as count FROM api_endpoints WHERE http_method = 'GET'")
    total_get = cursor.fetchone()["count"]
    print("Total GET APIs:", total_get)
    
    print("\n--- GET APIs WITHOUT PAGINATION ---")
    cursor.execute("SELECT count(*) as count FROM api_endpoints WHERE http_method = 'GET' AND uses_pagination = 0")
    print("GET without pagination:", cursor.fetchone()["count"])
    
    print("\n--- GET APIs WITHOUT SELECT ---")
    cursor.execute("SELECT count(*) as count FROM api_endpoints WHERE http_method = 'GET' AND uses_select = 0")
    print("GET without select:", cursor.fetchone()["count"])
    
    conn.close()

if __name__ == '__main__':
    main()

