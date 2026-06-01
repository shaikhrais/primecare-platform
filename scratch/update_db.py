import sqlite3

def main():
    conn = sqlite3.connect('.agents/governance/governance.db')
    cur = conn.cursor()
    cur.execute("""
        UPDATE roles 
        SET primary_app_url = 'https://54d34ef7.primecare-clinic.pages.dev', 
            auth_redirect_url = 'https://54d34ef7.primecare-clinic.pages.dev/auth/callback' 
        WHERE primary_app_code = 'clinic';
    """)
    conn.commit()
    conn.close()
    print("Successfully updated SQLite roles table for new clinic deployment!")

if __name__ == '__main__':
    main()
