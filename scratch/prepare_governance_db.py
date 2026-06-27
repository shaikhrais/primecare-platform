import sqlite3
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def prepare_db():
    print("Connecting to governance.db...")
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    c.execute("PRAGMA table_info(screens)")
    columns = [row[1] for row in c.fetchall()]
    print(f"Current columns: {columns}")
    
    new_cols = {
        "screenshot_path": "TEXT",
        "render_success": "INTEGER DEFAULT 0",
        "render_error": "TEXT",
        "visual_quality_score": "INTEGER DEFAULT 0"
    }
    
    for col, col_type in new_cols.items():
        if col not in columns:
            c.execute(f"ALTER TABLE screens ADD COLUMN {col} {col_type}")
            print(f"Added column {col} ({col_type})")
        else:
            print(f"Column {col} already exists.")
            
    conn.commit()
    conn.close()
    print("Database preparation complete.")

if __name__ == "__main__":
    prepare_db()
