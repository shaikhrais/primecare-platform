import sqlite3

def print_roles_info(db_path):
    print(f"--- Columns in {db_path} ---")
    try:
        conn = sqlite3.connect(db_path)
        c = conn.cursor()
        c.execute("PRAGMA table_info(roles)")
        cols = [col[1] for col in c.fetchall()]
        print(cols)
        conn.close()
    except Exception as e:
        print(e)

print_roles_info(r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db.pre_import_backup")
print_roles_info(r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance_backup_before_screen_sections.db")
print_roles_info(r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db.bak")
