import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
deployed_url = "https://primecare-clinic.pages.dev"

def main():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    
    roles = [
        'chiropractor', 'physio', 'social_worker', 'rmt', 
        'clinical_director', 'intake', 'training_coordinator', 
        'receptionist', 'qa_specialist', 'psw', 'rn', 'rpn'
    ]
    
    for role in roles:
        cur.execute("""
            UPDATE roles
            SET primary_app_url = ?,
                auth_redirect_url = ?
            WHERE role_code = ?
        """, (deployed_url, f"{deployed_url}/auth/callback", role))
        
    conn.commit()
    print("Successfully updated governance DB URLs for roles:", roles)
    conn.close()

if __name__ == '__main__':
    main()
