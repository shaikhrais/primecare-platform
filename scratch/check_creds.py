import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    row = cur.execute("SELECT test_email, test_password FROM roles WHERE role_code = 'chiropractor';").fetchone()
    print("DB Credentials for chiropractor:", row)
    conn.close()

if __name__ == '__main__':
    main()
