import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    print("=== SCREENS STATISTICS ===")
    cursor.execute("SELECT COUNT(*) FROM screens")
    total = cursor.fetchone()[0]
    print(f"Total Screens in DB: {total}")
    
    cursor.execute("SELECT is_valid, COUNT(*) FROM screens GROUP BY is_valid")
    print("\nScreens by is_valid (1 = Valid/Tested, 0 = Untested/Invalid):")
    for r in cursor.fetchall():
        print(f"  is_valid = {r[0]}: {r[1]} screens")
        
    cursor.execute("SELECT cypress_ready, COUNT(*) FROM screens GROUP BY cypress_ready")
    print("\nScreens by cypress_ready (1 = Ready, 0 = Not Ready):")
    for r in cursor.fetchall():
        print(f"  cypress_ready = {r[0]}: {r[1]} screens")
        
    cursor.execute("SELECT screen_status, COUNT(*) FROM screens GROUP BY screen_status")
    print("\nScreens by screen_status:")
    for r in cursor.fetchall():
        print(f"  {r[0]}: {r[1]} screens")
        
    cursor.execute("SELECT COUNT(*) FROM screens WHERE screenshot_path IS NOT NULL AND screenshot_path != ''")
    with_screenshots = cursor.fetchone()[0]
    print(f"\nScreens with screenshots: {with_screenshots}")
    
    cursor.execute("SELECT COUNT(*) FROM screens WHERE video_recording_path IS NOT NULL AND video_recording_path != ''")
    with_videos = cursor.fetchone()[0]
    print(f"Screens with videos: {with_videos}")
    
    conn.close()

if __name__ == '__main__':
    main()
