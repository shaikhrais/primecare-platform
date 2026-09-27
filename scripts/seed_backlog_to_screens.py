# Scripts - Category: remodel | Purpose: Query screen_seed_backlog suggestions, seed them directly into screens table, and configure role permissions in role_screen_permissions.
import os
import sqlite3
from datetime import datetime

DB_PATH = os.path.join(".agents", "governance", "governance.db")

def seed_backlog_to_db():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Query all suggested backlog items
    cursor.execute("""
        SELECT id, app_id, role_id, suggested_screen_code, suggested_screen_name, screen_type, reason
        FROM screen_seed_backlog
        WHERE seed_status = 'pending'
    """)
    backlog_items = cursor.fetchall()
    
    print(f"Loaded {len(backlog_items)} suggested screens from screen_seed_backlog table.")

    seeded_screens_count = 0
    seeded_perms_count = 0

    for backlog_id, app_id, role_id, code, name, scr_type, reason in backlog_items:
        # Resolve role details to construct route_path and file_path
        cursor.execute("SELECT role_code, role_name FROM roles WHERE id = ?", (role_id,))
        role_match = cursor.fetchone()
        if not role_match:
            continue
        role_code, role_name = role_match
        
        # Determine logical subdirectory for the screen file
        role_code_lower = role_code.lower()
        dir_name = "common"
        if "psw" in role_code_lower or "caregiver" in role_code_lower:
            dir_name = "psw"
        elif "rn" in role_code_lower or "rpn" in role_code_lower or "clinical" in role_code_lower:
            dir_name = "rn" if "rn" in role_code_lower else ("rpn" if "rpn" in role_code_lower else "clinical")
        elif "rmt" in role_code_lower or "physio" in role_code_lower or "chiro" in role_code_lower:
            dir_name = "allied"
        elif "executive" in role_code_lower or "ceo" in role_code_lower or "coo" in role_code_lower or "cfo" in role_code_lower or "cto" in role_code_lower or "owner" in role_code_lower:
            dir_name = "executive"
        elif "manager" in role_code_lower or "director" in role_code_lower or "compliance" in role_code_lower:
            dir_name = "management"
        elif "staff" in role_code_lower or "coordinator" in role_code_lower or "scheduler" in role_code_lower or "billing" in role_code_lower or "hiring" in role_code_lower:
            dir_name = "staff"

        # Construct standard route and file paths
        route_path = f"/{dir_name}/{code.replace('_', '-')}"
        file_path = f"packages/primecare_ui/lib/src/screens/{dir_name}/{code}_screen.dart"
        route_name = name.replace("Screen", "")

        # 1. Insert screen into screens table if it doesn't exist
        cursor.execute("SELECT id FROM screens WHERE app_id = ? AND screen_code = ?", (app_id, code))
        scr_match = cursor.fetchone()
        
        if not scr_match:
            cursor.execute("""
                INSERT INTO screens (
                    app_id, screen_code, screen_name, route_path, layout_key, 
                    screen_type, implementation_status, file_path, route_name, is_route_active, created_at
                ) VALUES (?, ?, ?, ?, 'masterLayout', ?, 'planned', ?, ?, 1, ?)
            """, (app_id, code, name, route_path, scr_type, file_path, route_name, datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
            screen_id = cursor.lastrowid
            seeded_screens_count += 1
        else:
            screen_id = scr_match[0]

        # 2. Configure role screen permissions in role_screen_permissions
        cursor.execute("SELECT id FROM role_screen_permissions WHERE role_id = ? AND screen_id = ?", (role_id, screen_id))
        perm_match = cursor.fetchone()
        
        if not perm_match:
            cursor.execute("""
                INSERT INTO role_screen_permissions (
                    role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export
                ) VALUES (?, ?, 1, 1, 1, 1, 1)
            """, (role_id, screen_id))
            seeded_perms_count += 1

        # 3. Update status in screen_seed_backlog
        cursor.execute("UPDATE screen_seed_backlog SET seed_status = 'seeded' WHERE id = ?", (backlog_id,))

    conn.commit()
    print(f"\nBacklog Seeding to Core Registry Complete.")
    print(f"  Successfully seeded in screens table: {seeded_screens_count} screens")
    print(f"  Successfully configured in role_screen_permissions: {seeded_perms_count} permissions")

    # Let's check updated role coverage summary from the view
    cursor.execute("SELECT coverage_status, count(*) FROM v_role_screen_coverage GROUP BY coverage_status;")
    print("\nUpdated Role Coverage Summary:")
    for r in cursor.fetchall():
        print(f"  Role coverage status '{r[0]}': {r[1]} roles")

    conn.close()

if __name__ == "__main__":
    seed_backlog_to_db()
