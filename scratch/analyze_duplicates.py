import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Query all screens from 1241 to 1261
    c.execute("""
        SELECT id, screen_code, route_path, actual_file_path, file_path 
        FROM screens 
        WHERE id BETWEEN 1241 AND 1261
    """)
    problem_screens = c.fetchall()

    print("Checking duplicates for IDs 1241 to 1261:")
    for ps in problem_screens:
        code = ps["screen_code"]
        # Search for screens with the same screen_code or actual_file_path but different ID
        c.execute("""
            SELECT id, screen_code, route_path, actual_file_path, implementation_status, production_ready
            FROM screens
            WHERE (screen_code = ? OR actual_file_path = ?) AND id != ?
        """, (code, ps["actual_file_path"], ps["id"]))
        dups = c.fetchall()
        print(f"\nTarget screen: ID={ps['id']}, Code={code}, Route={ps['route_path']}, Path={ps['actual_file_path']}")
        if dups:
            print("Duplicates found:")
            for d in dups:
                print(f"  - ID={d['id']}, Code={d['screen_code']}, Route={d['route_path']}, Path={d['actual_file_path']}, Status={d['implementation_status']}, ProdReady={d['production_ready']}")
        else:
            print("No duplicates found.")

    conn.close()

if __name__ == "__main__":
    main()
