import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    tables = ["apps", "roles", "screens", "ui_components", "api_endpoints", "role_screen_permissions", "screen_api_links"]
    for t in tables:
        print(f"=== SCHEMA FOR TABLE: {t} ===")
        c.execute(f"SELECT sql FROM sqlite_master WHERE type='table' AND name='{t}'")
        row = c.fetchone()
        if row:
            print(row[0])
        else:
            print("Table not found.")
        print()

    conn.close()

if __name__ == "__main__":
    main()
