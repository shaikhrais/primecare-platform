import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT sql FROM sqlite_master WHERE name='role_screen_permissions'")
    print(c.fetchone()[0])
    conn.close()

if __name__ == "__main__":
    main()
