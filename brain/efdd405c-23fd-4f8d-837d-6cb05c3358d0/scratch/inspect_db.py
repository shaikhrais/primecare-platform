import sqlite3
import os
import json

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # 1. Print all tables
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [r[0] for r in cursor.fetchall()]
    print("Tables:", tables)

    # 2. Print columns of roles
    print("\n--- ROLES TABLE ---")
    cursor.execute("PRAGMA table_info(roles);")
    for r in cursor.fetchall():
        print(f"Col: {r['name']} ({r['type']})")

    # 3. Print count of roles and details
    cursor.execute("SELECT count(*) as count FROM roles;")
    print("Total roles:", cursor.fetchone()["count"])
    
    cursor.execute("SELECT role_code, test_email, test_login_verified, test_login_last_status FROM roles LIMIT 5;")
    for r in cursor.fetchall():
        print(dict(r))

    # 4. Print columns and contents of release_operations
    if "release_operations" in tables:
        print("\n--- RELEASE OPERATIONS ---")
        cursor.execute("PRAGMA table_info(release_operations);")
        for r in cursor.fetchall():
            print(f"Col: {r['name']} ({r['type']})")
        cursor.execute("SELECT * FROM release_operations;")
        for r in cursor.fetchall():
            print(dict(r))
    else:
        print("\nrelease_operations table does NOT exist yet! Creating it?")

    conn.close()

if __name__ == '__main__':
    main()
