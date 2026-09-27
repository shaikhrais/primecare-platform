import sqlite3
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def execute_destruction():
    print("Connecting to governance.db...")
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    # 1. Add hard_fail column
    c.execute("PRAGMA table_info(screens)")
    existing_cols = [row[1] for row in c.fetchall()]
    
    if "hard_fail" not in existing_cols:
        c.execute("ALTER TABLE screens ADD COLUMN hard_fail INTEGER DEFAULT 0")
        print("Added hard_fail column to screens table.")
    else:
        print("hard_fail column already exists.")
        
    # 2. Update status
    c.execute("""
        UPDATE screens
        SET hard_fail = 1,
            production_ready = 0,
            business_ready = 0
        WHERE role_key = 'cfo'
    """)
    print(f"Downgraded {c.rowcount} CFO screens in SQLite (hard_fail = 1, production_ready = 0, business_ready = 0).")
    
    conn.commit()
    conn.close()

if __name__ == "__main__":
    execute_destruction()
