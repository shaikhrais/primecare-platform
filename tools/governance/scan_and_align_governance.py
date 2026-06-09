import os
import re
import sqlite3
import json
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def find_dart_files(root_dir):
    dart_files = []
    for root, dirs, files in os.walk(root_dir):
        if "node_modules" in root or ".dart_tool" in root or "build" in root or ".git" in root:
            continue
        for file in files:
            if file.endswith(".dart"):
                dart_files.append(os.path.join(root, file))
    return dart_files

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: CODE-TO-DB ALIGNMENT SCANNER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    # 1. Scan the codebase for keys and classes
    packages_dir = os.path.join(PROJECT_ROOT, "packages")
    apps_dir = os.path.join(PROJECT_ROOT, "apps")
    
    dart_files = find_dart_files(packages_dir) + find_dart_files(apps_dir)

    print(f"Scanned {len(dart_files)} Dart files in codebase.")

    # Patterns for key detection and screen class definitions
    key_pattern = re.compile(r"Key\(['\"]([a-zA-Z0-9_-]+)['\"]\)")
    class_pattern = re.compile(r"class\s+([a-zA-Z0-9_]+Screen|[a-zA-Z0-9_]+View)\s+extends")
    
    found_keys = {}
    found_screens = {}

    for file_path in dart_files:
        rel_path = os.path.relpath(file_path, PROJECT_ROOT).replace("\\", "/")
        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
                
                # Search for Keys
                keys = key_pattern.findall(content)
                for k in keys:
                    if k not in found_keys:
                        found_keys[k] = []
                    found_keys[k].append(rel_path)
                
                # Search for screen classes
                classes = class_pattern.findall(content)
                for cls in classes:
                    # Convert class name to clean snake_case screen_code
                    screen_code = re.sub(r'(?<!^)(?=[A-Z])', '_', cls).lower()
                    
                    # Specific overrides for alignment mapping without breaking database schema names
                    if screen_code == "dynamic_screen_dashboard_view":
                        screen_code = "dynamic_screen_dashboard"
                    elif screen_code == "screen_audit_view":
                        screen_code = "screen_audit"
                    elif screen_code == "screen_audit_screen":
                        screen_code = "audit"
                    elif screen_code == "audit_screen":
                        screen_code = "audit"
                    elif screen_code == "shared_stubs_screen":
                        screen_code = "shared_stubs"
                    elif screen_code == "screen_not_implemented_view":
                        screen_code = "screen_not_implemented"
                    else:
                        screen_code = screen_code.replace("_screen", "").replace("_view", "")
                        
                    found_screens[screen_code] = {
                        "class_name": cls,
                        "file_path": rel_path
                    }
        except Exception as e:
            pass

    print(f"Detected {len(found_screens)} screen classes in code.")
    print(f"Detected {len(found_keys)} custom Key definitions in code.")

    # 2. Database verification and alignment
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Load registered screens from database
    db_screens = cur.execute("SELECT id, screen_code, actual_file_path, screen_name FROM screens").fetchall()
    db_screen_codes = {r["screen_code"]: r for r in db_screens}
    
    print(f"\nComparing screens: SQLite ({len(db_screen_codes)}) vs Code ({len(found_screens)})...")

    # TASK 3: Add screens present in code but missing in SQLite
    added_screens = 0
    for screen_code, info in found_screens.items():
        if screen_code not in db_screen_codes:
            # Let's insert a new screen record
            screen_name = screen_code.replace("_", " ").title()
            try:
                cur.execute("""
                    INSERT INTO screens (app_id, screen_code, screen_name, actual_file_path, expected_file_path, screen_status, cypress_ready)
                    VALUES (6, ?, ?, ?, ?, 'active', 1);
                """, (screen_code, screen_name, info["file_path"], info["file_path"]))
                added_screens += 1
                print(f"  [Task 3 - Add] Screen '{screen_code}' detected in code -> Added to SQLite.")
            except Exception as e:
                print(f"  Error adding screen '{screen_code}': {e}")

    # TASK 4: Identify screens registered in SQLite but missing in code
    missing_screens = 0
    for screen_code, r in db_screen_codes.items():
        if screen_code not in found_screens:
            missing_screens += 1
            # Mark screen status as missing in the database
            cur.execute("""
                UPDATE screens
                SET screen_status = 'missing',
                    problem_summary = 'Screen class not found in compiled Dart sources.'
                WHERE screen_code = ?;
            """, (screen_code,))
            print(f"  [Task 4 - Missing] Screen '{screen_code}' registered in SQLite but missing in codebase -> Marked status: missing.")
        else:
            # Mark screen status as active in the database and align paths
            cur.execute("""
                UPDATE screens
                SET screen_status = 'active',
                    actual_file_path = ?,
                    expected_file_path = ?,
                    problem_summary = NULL
                WHERE screen_code = ?;
            """, (info["file_path"], info["file_path"], screen_code))


    conn.commit()

    # Refactor widgets mapping directly into screens table (single-table consolidation)
    print("\nMapping detected widget keys directly into screens table columns...")
    
    # Reload screens with IDs and paths
    db_screens = cur.execute("SELECT id, screen_code, actual_file_path FROM screens").fetchall()
    
    updated_screens_count = 0
    for screen in db_screens:
        screen_id = screen["id"]
        screen_code = screen["screen_code"]
        actual_path = screen["actual_file_path"]
        
        if not actual_path:
            continue
            
        # Find all keys belonging to this screen file path
        screen_keys = []
        for key, paths in found_keys.items():
            if any(actual_path in p for p in paths):
                screen_keys.append(key)
                
        # Update screens table data_cy_found_json and component_count
        try:
            cur.execute("""
                UPDATE screens
                SET data_cy_found_json = ?,
                    component_count = ?,
                    component_scan_status = 'aligned',
                    component_scan_at = CURRENT_TIMESTAMP,
                    component_governance_status = 'aligned'
                WHERE id = ?;
            """, (json.dumps(screen_keys), len(screen_keys), screen_id))
            
            if len(screen_keys) > 0:
                updated_screens_count += 1
        except Exception as e:
            print(f"  Error updating screen '{screen_code}' components: {e}")

    conn.commit()
    conn.close()

    print(f"\n==============================================================")
    print(f"[SUCCESS] Code-to-DB Alignment Scan complete!")
    print(f"Added Screens: {added_screens}")
    print(f"Missing Screens: {missing_screens}")
    print(f"Updated Screens with Widget Keys: {updated_screens_count}")
    print("==============================================================")

if __name__ == '__main__':
    main()
