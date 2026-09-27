import sqlite3
import re

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT DISTINCT route_path FROM screens")
    routes = [r[0] for r in c.fetchall() if r[0]]
    
    roles_from_offices = {}
    for r in routes:
        m = re.search(r'/offices/([^/]+)/roles/([^/]+)', r)
        if m:
            category = m.group(1)
            role = m.group(2)
            if role not in roles_from_offices:
                roles_from_offices[role] = set()
            roles_from_offices[role].add(category)
            
    print(f"Total screens: {len(routes)}")
    print(f"Roles from offices paths: {len(roles_from_offices)}")
    for r, cats in sorted(roles_from_offices.items()):
        print(f"Role: {r} | Categories: {list(cats)}")
        
    conn.close()

if __name__ == "__main__":
    main()
