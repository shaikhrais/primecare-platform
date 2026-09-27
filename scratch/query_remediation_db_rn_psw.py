import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- SCREENS MATCHING RN-ASSESSMENTS OR PATIENT-PROFILE ---")
    cursor.execute("SELECT id, screen_code, screen_name, allowed_roles_text, route_path, data_cy_required_json FROM screens WHERE route_path LIKE '%rn-assessments%' OR route_path LIKE '%patient-profile%';")
    for r in cursor.fetchall():
        print(dict(r))
        
    print("\n--- REMEDIATION STATUS ---")
    cursor.execute("SELECT * FROM screen_remediation_registry WHERE route_path LIKE '%rn-assessments%' OR route_path LIKE '%patient-profile%';")
    for r in cursor.fetchall():
        print(dict(r))
        
    conn.close()

if __name__ == '__main__':
    main()
