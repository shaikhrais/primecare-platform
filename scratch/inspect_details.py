import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT id, app_code, app_name, platform, publish_url, api_url FROM apps")
    rows = cursor.fetchall()
    print("=== APPS TABLE ===")
    for r in rows:
        print(f"ID: {r['id']}, Code: {r['app_code']}, Name: {r['app_name']}, Platform: {r['platform']}, PubURL: {r['publish_url']}, ApiURL: {r['api_url']}")
        
    conn.close()

if __name__ == '__main__':
    main()
