import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT role_code, primary_app_code FROM roles;")
    rows = cursor.fetchall()
    print("--- Roles and Primary App Codes ---")
    for r in rows:
        print(f"Role: {r[0]} -> App Code: {r[1]}")
    conn.close()

if __name__ == '__main__':
    main()
