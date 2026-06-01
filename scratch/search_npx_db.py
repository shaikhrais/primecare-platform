import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Get all tables
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [r['name'] for r in cursor.fetchall()]
    
    print(f"Searching governance.db ({len(tables)} tables) for occurrences of 'npx'...")
    
    found_any = False
    
    for table in tables:
        # Avoid SQLite system tables
        if table.startswith("sqlite_"):
            continue
            
        cursor.execute(f"PRAGMA table_info({table});")
        columns = [col['name'] for col in cursor.fetchall()]
        
        for col in columns:
            try:
                # Search query
                cursor.execute(f"SELECT rowid, [{col}] FROM [{table}] WHERE [{col}] LIKE ?;", ("%npx%",))
                rows = cursor.fetchall()
                if rows:
                    found_any = True
                    print(f"\n[FOUND] Table: {table} | Column: {col} | Matches: {len(rows)}")
                    for r in rows[:10]:
                        val_str = str(r[1])
                        # Truncate for readability
                        if len(val_str) > 100:
                            val_str = val_str[:100] + "..."
                        print(f"  RowID: {r[0]} | Value: {val_str}")
            except Exception as e:
                # Column might not support LIKE or be a binary type
                pass
                
    if not found_any:
        print("\nNo occurrences of 'npx' were found in the database!")
        
    conn.close()

if __name__ == '__main__':
    main()
