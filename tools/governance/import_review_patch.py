import sqlite3
import os
import json
import argparse
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    parser = argparse.ArgumentParser(description="Import Crowdsourced E2E Review Remarks Patch into governance.db")
    parser.add_argument("--patch", type=str, required=True, help="Path to the primecare_review_patch.json file")

    args = parser.parse_args()

    if not os.path.exists(args.patch):
        print(f"[ERROR] Patch file not found at: {args.patch}")
        sys.exit(1)

    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        sys.exit(1)

    # 1. Read patch JSON data
    try:
        with open(args.patch, "r", encoding="utf-8") as f:
            patch_data = json.load(f)
    except Exception as e:
        print(f"[ERROR] Failed to parse JSON patch file: {e}")
        sys.exit(1)

    if not isinstance(patch_data, list):
        print("[ERROR] Invalid patch format. Expected a JSON array of screen reviews.")
        sys.exit(1)

    print(f"📂 Read {len(patch_data)} screen remarks from review patch: {args.patch}")

    # 2. Connect to DB and apply updates
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    applied_count = 0
    for entry in patch_data:
        screen_code = entry.get("screen_code")
        user_remarks = entry.get("user_remarks")
        user_remark_status = entry.get("user_remark_status", "none")

        if not screen_code or not user_remarks:
            continue

        # Execute SQLite update
        cursor.execute("""
            UPDATE screens 
            SET user_remarks = ?, user_remark_status = ? 
            WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))
        """, (user_remarks, user_remark_status, screen_code))

        if cursor.rowcount > 0:
            print(f"  [IMPORTED] Screen: '{screen_code}' | Remarks: '{user_remarks}' | Status: {user_remark_status}")
            applied_count += 1
        else:
            print(f"  [SKIPPED] No matching screen code in DB: '{screen_code}'")

    conn.commit()
    conn.close()

    # 3. Automatically re-compile the dashboard to sync the new changes
    print(f"\n✨ Successfully imported and merged {applied_count} review remarks into governance.db!")
    print("🔄 Re-compiling Interactive Governance Dashboard...")
    try:
        import sys
        sys.path.append(os.path.join(PROJECT_ROOT, "tools", "governance"))
        from generate_interactive_dashboard import main as compile_dashboard
        compile_dashboard()
    except Exception as e:
        print(f"  [WARN] Failed to re-compile dashboard: {e}")

    print("\n🏁 Crowdsourced Patch Merging completed successfully!")

if __name__ == '__main__':
    main()
