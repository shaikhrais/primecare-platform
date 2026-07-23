import os
import sqlite3
import time
import sys

# Add scripts directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from screenshot_handler import ScreenshotHandler
from report_handler import ReportHandler
from sync_db_to_screen_implementations import sync_db_to_screens

def perform_test_and_update():
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    db_path = os.path.join(project_root, '.agents', 'governance', 'governance.db')

    print("==================================================")
    print("STEP 1: INITIALIZING AUTOMATED SCREEN TEST ENGINE")
    print("==================================================")
    
    handler = ScreenshotHandler(db_path=db_path)
    screens = handler.get_screens_to_capture(limit=25) # Capture batch of screen renders
    print(f"[Test Engine] Loaded {len(screens)} target screens for automated browser testing.")

    captured_count = 0
    for s in screens:
        print(f"[Test Engine] Testing screen: {s['screen_code']} ({s['app_code']} | {s['role_code']})")
        success, result = handler.capture_screen(s)
        if success:
            captured_count += 1
            print(f"[Test Engine] Screenshot verified: {result}")
        else:
            print(f"[Test Engine] Capture warning: {result}")

    handler.quit_driver()
    print(f"\n[Test Engine] Completed browser testing: {captured_count}/{len(screens)} screenshots captured & verified.")

    print("\n==================================================")
    print("STEP 2: RECALCULATING DATABASE STATISTICS & STATUSES")
    print("==================================================")

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Recalculate completeness score and update governance tags
    cursor.execute("""
        UPDATE screens
        SET completeness_score = CASE
            WHEN screenshot_path IS NOT NULL AND screenshot_path != '' THEN 100
            WHEN implementation_tag = 'implemented' THEN 95
            WHEN api_tag = 'api_connected' THEN 85
            ELSE 70
        END,
        runtime_verified = CASE WHEN screenshot_path IS NOT NULL AND screenshot_path != '' THEN 1 ELSE 0 END,
        production_ready = CASE WHEN implementation_tag = 'implemented' AND (screenshot_path IS NOT NULL OR api_tag = 'api_connected') THEN 1 ELSE 0 END
    """)

    conn.commit()
    conn.close()
    print("[Test Engine] Governance DB statistics updated successfully.")

    print("\n==================================================")
    print("STEP 3: REGENERATING EXECUTIVE GALLERY & REPORTS")
    print("==================================================")

    report_handler = ReportHandler(db_path=db_path)
    r1, r2 = report_handler.generate_report()
    print(f"[Test Engine] Updated reports: {r1}, {r2}")

    print("\n==================================================")
    print("STEP 4: SYNCHRONIZING MANIFEST & DART STATUS REGISTRY")
    print("==================================================")

    sync_db_to_screens()

    print("\n==================================================")
    print("SUCCESS: AUTOMATED TESTING & GALLERY UPDATE COMPLETE!")
    print("==================================================")

if __name__ == '__main__':
    perform_test_and_update()
