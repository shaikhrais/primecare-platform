import os
import shutil
import sqlite3
import re

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
CYPRESS_SCREENSHOTS = os.path.join(PROJECT_ROOT, "cypress", "screenshots")
CYPRESS_VIDEOS = os.path.join(PROJECT_ROOT, "cypress", "videos")
ROOT_SCREENSHOTS = os.path.join(PROJECT_ROOT, "screenshots")

def get_win_path(path):
    # Support Windows extended long paths to bypass 260 MAX_PATH limit
    abs_path = os.path.abspath(path)
    if os.name == 'nt' and not abs_path.startswith('\\\\?\\'):
        return '\\\\?\\' + abs_path
    return abs_path

def main():
    print("🧹 Starting Industry-Standard Visual Proof Clean-up & Alignment with Windows Long-Path support...")

    # 1. Nuke the root placeholder screenshots directory (messy stubs of 68 bytes)
    win_root_screenshots = get_win_path(ROOT_SCREENSHOTS)
    # Strip \\?\ for exists check, but use it for deletion
    if os.path.exists(ROOT_SCREENSHOTS):
        print(f"🗑️  Nuking root placeholder screenshots folder: {ROOT_SCREENSHOTS}")
        try:
            # We can use win path or shutil
            shutil.rmtree(ROOT_SCREENSHOTS)
            print("  ✓ Successfully deleted messy root screenshots folder.")
        except Exception as e:
            print(f"  [WARN] Failed to delete root screenshots folder: {e}")

    # 2. Purge old timestamped folders in cypress/screenshots
    if os.path.exists(CYPRESS_SCREENSHOTS):
        print(f"\n📂 Scanning Cypress screenshots folder: {CYPRESS_SCREENSHOTS}")
        for entry in os.listdir(CYPRESS_SCREENSHOTS):
            dir_path = os.path.join(CYPRESS_SCREENSHOTS, entry)
            if os.path.isdir(dir_path):
                # Match timestamped folders like '2026-05-30_*' or '2026-05-31_*'
                if re.match(r'^\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}$', entry):
                    print(f"  🗑️  Purging old historical folder: {entry}")
                    try:
                        shutil.rmtree(get_win_path(dir_path))
                    except Exception as e:
                        print(f"    [WARN] Failed to delete folder {entry}: {e}")

    # 3. Clean up duplicate parentheses screenshots inside spec folders
    if os.path.exists(CYPRESS_SCREENSHOTS):
        print("\n✨ Cleaning duplicate/parenthesized E2E screenshots...")
        for spec_dir in os.listdir(CYPRESS_SCREENSHOTS):
            spec_path = os.path.join(CYPRESS_SCREENSHOTS, spec_dir)
            if os.path.isdir(spec_path):
                # Clean parenthesized files in spec folder
                for file_name in os.listdir(spec_path):
                    file_path = os.path.join(spec_path, file_name)
                    # Match files like 'psw_dashboard (1).png' or 'auth-login-psw (12).png'
                    if "(" in file_name and file_name.endswith(".png"):
                        # Extract the base name (e.g. 'psw_dashboard.png' or 'auth-login-psw.png')
                        base_match = re.match(r'^([^\(]+)\s*\(\d+\)\.png$', file_name)
                        if base_match:
                            clean_base = base_match.group(1).strip() + ".png"
                            clean_path = os.path.join(spec_path, clean_base)
                            
                            # If the clean base version doesn't exist, rename it to be the clean version
                            if not os.path.exists(clean_path):
                                print(f"    Renaming parenthesized file: '{file_name}' -> '{clean_base}'")
                                try:
                                    os.rename(get_win_path(file_path), get_win_path(clean_path))
                                except Exception as e:
                                    print(f"      [WARN] Failed to rename {file_name}: {e}")
                            else:
                                # Clean base already exists, safely delete the redundant duplicate
                                print(f"    Deleting redundant duplicate screenshot: {file_name}")
                                try:
                                    os.remove(get_win_path(file_path))
                                except Exception as e:
                                    print(f"      [WARN] Failed to delete {file_name}: {e}")
                        else:
                            # Direct bracket matches
                            print(f"    Deleting unparseable bracket file: {file_name}")
                            try:
                                os.remove(get_win_path(file_path))
                            except Exception as e:
                                print(f"      [WARN] Failed to delete {file_name}: {e}")

    # 4. Synchronize SQLite Database Paths to cleaned structures
    if os.path.exists(DB_PATH):
        print("\n⚙️ Aligning screens table paths in SQLite database...")
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()

        # Query screens with visual paths
        cursor.execute("SELECT id, screen_code, screenshot_path, video_recording_path FROM screens")
        screens = cursor.fetchall()
        
        updated_count = 0
        for s_id, code, screenshot, video in screens:
            updated_screenshot = screenshot
            updated_video = video
            
            # Clean up duplicate paths in db columns
            if screenshot:
                # Remove parenthesized indicators in path names
                cleaned_screenshot = re.sub(r'\s*\(\d+\)\.png$', '.png', screenshot)
                
                # Check if file actually exists on disk
                full_screenshot_path = os.path.join(PROJECT_ROOT, cleaned_screenshot)
                if not os.path.exists(full_screenshot_path):
                    # Try scanning the cypress directory for matches
                    found = False
                    if os.path.exists(CYPRESS_SCREENSHOTS):
                        for spec_dir in os.listdir(CYPRESS_SCREENSHOTS):
                            spec_path = os.path.join(CYPRESS_SCREENSHOTS, spec_dir)
                            if os.path.isdir(spec_path):
                                # Check if a file matching code exists
                                for f in os.listdir(spec_path):
                                    if code in f.lower() and f.endswith(".png"):
                                        cleaned_screenshot = f"cypress/screenshots/{spec_dir}/{f}"
                                        found = True
                                        break
                            if found:
                                break
                    if not found:
                        cleaned_screenshot = None # Purge missing path
                updated_screenshot = cleaned_screenshot

            if video:
                # Check if file exists on disk
                full_video_path = os.path.join(PROJECT_ROOT, video)
                if not os.path.exists(full_video_path):
                    # Purge missing path
                    updated_video = None

            # Update DB record if changed
            if updated_screenshot != screenshot or updated_video != video:
                # If screenshot is missing, update the database valid flag accordingly
                is_valid_flag = 1 if updated_screenshot else 0
                cursor.execute("""
                    UPDATE screens 
                    SET screenshot_path = ?, 
                        video_recording_path = ?, 
                        is_valid = ?
                    WHERE id = ?
                """, (updated_screenshot, updated_video, is_valid_flag, s_id))
                updated_count += 1

        conn.commit()
        conn.close()
        print(f"  ✓ Aligned {updated_count} screen telemetry records inside governance.db.")

    print("\n🏁 Industry-Standard Visual Proof Cleanup Gate Completed successfully!")

if __name__ == '__main__':
    main()
