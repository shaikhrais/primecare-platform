import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    
    # Let's inspect the roles table
    c.execute("SELECT id, role_code, role_name FROM roles")
    roles = c.fetchall()
    print("ALL ROLES IN DB:")
    for r in roles:
        print(f"ID: {r['id']} | Code: {r['role_code']} | Name: {r['role_name']}")
        
    print("\nScreens route_path patterns containing '/roles/':")
    c.execute("SELECT DISTINCT route_path FROM screens WHERE route_path LIKE '%/roles/%'")
    for r in c.fetchall():
        print(r[0])
        
    conn.close()

if __name__ == "__main__":
    main()
