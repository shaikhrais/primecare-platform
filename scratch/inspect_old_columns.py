import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    tables = ["apps", "roles", "screens", "ui_components", "api_endpoints", "role_screen_permissions", "screen_api_links"]
    for t in tables:
        print(f"=== COLUMNS FOR {t} ===")
        c.execute(f"PRAGMA table_info({t})")
        cols = [r[1] for r in c.fetchall()]
        print(cols)
    conn.close()

if __name__ == "__main__":
    main()
