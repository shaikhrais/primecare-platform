import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM screen_e2e_compliance_tracker WHERE screen_code LIKE '%clinical_director_dashboard%' OR route_path LIKE '%clinical_director/dashboard%';")
    rows = cursor.fetchall()
    print("RECORDS MATCHING CLINICAL DIRECTOR DASHBOARD:")
    for r in rows:
        print(dict(r))
    conn.close()

if __name__ == '__main__':
    main()
