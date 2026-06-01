import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print(f"Connecting to database at {DB_PATH}...")
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Check all columns in screens table
    cursor.execute("PRAGMA table_info(screens)")
    cols = cursor.fetchall()
    print("\nColumns in 'screens' table:")
    for col in cols:
        print(f"  {col[1]} ({col[2]})")
        
    # Query all screens where when_tested is not null
    cursor.execute("""
        SELECT screen_code, screenshot_path, video_recording_path, when_tested, is_valid 
        FROM screens 
        WHERE when_tested IS NOT NULL
    """)
    rows = cursor.fetchall()
    print(f"\nUpdated screens ({len(rows)} rows):")
    for row in rows:
        print(f"  Code: {row[0]:<25} | Valid: {row[4]} | Tested At: {row[3]}")
        print(f"    Screenshot: {row[1]}")
        print(f"    Video:      {row[2]}")
        
    conn.close()

if __name__ == '__main__':
    main()
