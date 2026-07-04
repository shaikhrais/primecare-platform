import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    c.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [row[0] for row in c.fetchall()]
    print("Tables in database:", tables)
    
    print("\nChecking for template tables:")
    for t in ["code_file_templates", "element_templates", "api_client_templates", "state_management_templates", "button_logic_templates", "route_templates", "sidebar_templates", "test_templates", "screen_file_graph", "project_file_registry"]:
        if t in tables:
            print(f"- Table {t} exists.")
            c.execute(f"PRAGMA table_info({t});")
            print([row[1] for row in c.fetchall()])
        else:
            print(f"- Table {t} DOES NOT exist.")

    conn.close()

if __name__ == "__main__":
    main()
