import os
import shutil
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
CYPRESS_SCREENSHOTS = os.path.join(PROJECT_ROOT, "cypress", "screenshots")
CYPRESS_VIDEOS = os.path.join(PROJECT_ROOT, "cypress", "videos")

def get_win_path(path):
    abs_path = os.path.abspath(path)
    if os.name == 'nt' and not abs_path.startswith('\\\\?\\'):
        return '\\\\?\\' + abs_path
    return abs_path

def main():
    print("🚨 WARNING: Initiating Full Visual Governance Reset...")
    print("This will DELETE all screenshot and video files on disk and mark all screens as Untested/Invalid in SQLite.")
    
    # 1. Delete all screenshots recursively
    if os.path.exists(CYPRESS_SCREENSHOTS):
        print(f"🗑️  Deleting E2E screenshots folder: {CYPRESS_SCREENSHOTS}")
        try:
            # Re-create empty directory after deleting
            shutil.rmtree(get_win_path(CYPRESS_SCREENSHOTS))
            os.makedirs(CYPRESS_SCREENSHOTS, exist_ok=True)
            print("  ✓ Successfully purged screenshots.")
        except Exception as e:
            print(f"  [WARN] Failed to delete screenshots folder: {e}")
    
    # 2. Delete all videos recursively
    if os.path.exists(CYPRESS_VIDEOS):
        print(f"🗑️  Deleting E2E videos folder: {CYPRESS_VIDEOS}")
        try:
            # Re-create empty directory after deleting
            shutil.rmtree(get_win_path(CYPRESS_VIDEOS))
            os.makedirs(CYPRESS_VIDEOS, exist_ok=True)
            print("  ✓ Successfully purged videos.")
        except Exception as e:
            print(f"  [WARN] Failed to delete videos folder: {e}")

    # 3. Update SQLite registry
    if os.path.exists(DB_PATH):
        print("\n⚙️ Resetting screens table in SQLite database...")
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()

        # Mark all screens as invalid, clear visual paths, and flag them for remakes
        cursor.execute("""
            UPDATE screens 
            SET screenshot_path = NULL, 
                video_recording_path = NULL, 
                is_valid = 0,
                user_remarks = CASE 
                    WHEN user_remarks IS NOT NULL AND user_remarks != '' AND user_remarks NOT LIKE '[REMAKE REQUIRED]%'
                    THEN '[REMAKE REQUIRED] ' || user_remarks
                    ELSE '[REMAKE REQUIRED] E2E visual sweep reset.'
                END,
                user_remark_status = 'pending'
        """)
        
        conn.commit()
        rows_updated = cursor.rowcount
        conn.close()
        print(f"  ✓ Successfully reset and flagged {rows_updated} screen records in governance.db.")

    # 4. Re-compile the interactive dashboard to reflect the clean slate
    print("\n🔄 Re-compiling Interactive Governance Dashboard...")
    try:
        import sys
        sys.path.append(os.path.join(PROJECT_ROOT, "tools", "governance"))
        from generate_interactive_dashboard import main as compile_dashboard
        compile_dashboard()
    except Exception as e:
        print(f"  [WARN] Failed to re-compile dashboard: {e}")

    print("\n✨ Full Visual Reset Gate Completed successfully! Everything is clean and flagged for remakes.")

if __name__ == '__main__':
    main()
