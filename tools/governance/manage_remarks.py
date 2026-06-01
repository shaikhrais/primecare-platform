import sqlite3
import os
import argparse
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    parser = argparse.ArgumentParser(description="Manage Screen User Review Remarks in governance.db")
    parser.add_argument("--screen", type=str, help="The screen code (e.g. pswdashboard)")
    parser.add_argument("--remark", type=str, help="The review remark text")
    parser.add_argument("--status", type=str, choices=["none", "pending", "remediated"], help="Remark status")
    parser.add_argument("--list", action="store_true", help="List all screens with active remarks")

    args = parser.parse_args()

    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    if args.list:
        cursor.execute("""
            SELECT s.screen_code, s.screen_name, s.user_remarks, s.user_remark_status 
            FROM screens s 
            WHERE s.user_remarks IS NOT NULL AND s.user_remarks != '' 
               OR s.user_remark_status != 'none'
        """)
        rows = cursor.fetchall()
        print(f"=== Screens with User Review Remarks ({len(rows)} found) ===")
        for r in rows:
            print(f"🖥️  Screen: {r['screen_code']} ({r['screen_name']})")
            print(f"   Status: [{r['user_remark_status'].upper()}]")
            print(f"   Remark: {r['user_remarks']}")
            print("-" * 50)
        conn.close()
        return

    if not args.screen:
        print("[ERROR] Please provide --screen <screen_code> or --list to manage remarks.")
        conn.close()
        sys.exit(1)

    # Search for screen
    screen_code = args.screen.strip()
    cursor.execute("SELECT id, screen_name, user_remarks, user_remark_status FROM screens WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))", (screen_code,))
    screen = cursor.fetchone()

    if not screen:
        print(f"[ERROR] Screen code '{screen_code}' not found in database registry.")
        conn.close()
        sys.exit(1)

    print(f"Found Screen: '{screen['screen_name']}'")
    print(f"  Current Status: {screen['user_remark_status']}")
    print(f"  Current Remark: {screen['user_remarks']}")

    # Apply changes
    updates = []
    params = []
    
    if args.remark is not None:
        updates.append("user_remarks = ?")
        params.append(args.remark)
        print(f"  Updating Remark to: \"{args.remark}\"")

    if args.status is not None:
        updates.append("user_remark_status = ?")
        params.append(args.status)
        print(f"  Updating Status to: {args.status}")

    if not updates:
        print("No changes specified. Use --remark or --status to update.")
        conn.close()
        return

    params.append(screen_code)
    query = f"UPDATE screens SET {', '.join(updates)} WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))"
    
    cursor.execute(query, tuple(params))
    conn.commit()
    print("✨ Successfully updated screen remarks in SQLite governance.db!")
    conn.close()

if __name__ == '__main__':
    main()
