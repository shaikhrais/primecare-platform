import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
AGENTS_DIR = os.path.join(PROJECT_ROOT, ".agents")

def search_and_cleanup_db(db_path):
    print(f"\n--- Scanning Database: {os.path.basename(db_path)} ---")
    try:
        conn = sqlite3.connect(db_path)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = [r['name'] for r in cursor.fetchall()]
        
        found_any = False
        
        for table in tables:
            if table.startswith("sqlite_"):
                continue
                
            cursor.execute(f"PRAGMA table_info([{table}]);")
            columns = [col['name'] for col in cursor.fetchall()]
            
            for col in columns:
                try:
                    cursor.execute(f"SELECT rowid, [{col}] FROM [{table}] WHERE [{col}] LIKE ?;", ("%npx%",))
                    rows = cursor.fetchall()
                    if rows:
                        found_any = True
                        print(f"  [FOUND] Table: {table} | Column: {col} | Matches: {len(rows)}")
                        # Run cleanup
                        cursor.execute(f"UPDATE [{table}] SET [{col}] = REPLACE([{col}], 'npx ', '') WHERE [{col}] LIKE ?;", ("%npx%",))
                        print(f"  [CLEANED] Removed 'npx ' from table: {table}, column: {col} ({cursor.rowcount} rows)")
                except Exception as e:
                    pass
                    
        if found_any:
            conn.commit()
            print("  [SUCCESS] Database changes committed.")
        else:
            print("  [CLEAN] No 'npx' occurrences found.")
            
        conn.close()
    except Exception as e:
        print(f"  Error opening database: {e}")

def main():
    # Find all .db files under .agents recursively
    for root, dirs, files in os.walk(AGENTS_DIR):
        for file in files:
            if file.endswith(".db"):
                db_path = os.path.join(root, file)
                search_and_cleanup_db(db_path)

if __name__ == '__main__':
    main()
