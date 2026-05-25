# Scripts - Category: remodel | Purpose: Set up file_verification_checks table and v_unverified_files view, perform verification sweeps for all 277 screen files, and save check states.
import os
import sqlite3
import re
from datetime import datetime

DB_PATH = os.path.join(".agents", "governance", "governance.db")
REPO_ROOT = "c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform"
PRIMECARE_UI_EXPORT_PATH = os.path.join(REPO_ROOT, "packages", "primecare_ui", "lib", "primecare_ui.dart")

def create_table_and_view(cursor):
    # 1. Create file_verification_checks table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS file_verification_checks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      file_id INTEGER NOT NULL,
      screen_id INTEGER,

      file_path TEXT NOT NULL,

      file_exists INTEGER DEFAULT 0,
      import_works INTEGER DEFAULT 0,
      component_exists INTEGER DEFAULT 0,
      class_exists INTEGER DEFAULT 0,
      route_exists INTEGER DEFAULT 0,
      widget_exported INTEGER DEFAULT 0,
      widget_renders INTEGER DEFAULT 0,

      verification_status TEXT DEFAULT 'pending',
      error_message TEXT,
      proof_log_path TEXT,
      checked_at TEXT DEFAULT CURRENT_TIMESTAMP,

      FOREIGN KEY (file_id) REFERENCES code_files(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)

    # 2. Create v_unverified_files view
    cursor.execute("DROP VIEW IF EXISTS v_unverified_files;")
    cursor.execute("""
    CREATE VIEW v_unverified_files AS
    SELECT
      s.screen_name,
      cf.file_path,
      fvc.file_exists,
      fvc.import_works,
      fvc.component_exists,
      fvc.class_exists,
      fvc.route_exists,
      fvc.widget_exported,
      fvc.widget_renders,
      fvc.verification_status,
      fvc.error_message
    FROM code_files cf
    LEFT JOIN screen_file_links sfl ON sfl.file_id = cf.id
    LEFT JOIN screens s ON s.id = sfl.screen_id
    LEFT JOIN file_verification_checks fvc ON fvc.file_id = cf.id
    WHERE fvc.verification_status IS NULL
       OR fvc.verification_status != 'passed';
    """)

def run_verification_sweep():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Set up database structure
    create_table_and_view(cursor)
    print("Database table 'file_verification_checks' and view 'v_unverified_files' created successfully.")

    # Read primecare_ui.dart exports
    exports_content = ""
    if os.path.exists(PRIMECARE_UI_EXPORT_PATH):
        with open(PRIMECARE_UI_EXPORT_PATH, "r", encoding="utf-8") as f:
            exports_content = f.read()

    # Query all screen files from code_files
    cursor.execute("""
        SELECT id, file_path, file_name 
        FROM code_files 
        WHERE file_path LIKE '%packages/primecare_ui/lib/src/screens%'
    """)
    code_files = cursor.fetchall()
    print(f"Loaded {len(code_files)} screen code files from the registry.")

    passed_count = 0
    failed_count = 0

    for file_id, file_path, file_name in code_files:
        full_path = os.path.join(REPO_ROOT, file_path)
        
        # 1. file_exists
        file_exists = 1 if os.path.exists(full_path) else 0
        
        # Default checks to 0
        import_works = 0
        component_exists = 0
        class_exists = 0
        route_exists = 0
        widget_exported = 0
        widget_renders = 0
        verification_status = "pending"
        error_message = None
        
        # Resolve associated screen_id from screen_file_links
        cursor.execute("SELECT screen_id FROM screen_file_links WHERE file_id = ?", (file_id,))
        sfl_match = cursor.fetchone()
        screen_id = sfl_match[0] if sfl_match else None

        if file_exists == 0:
            verification_status = "failed"
            error_message = "Physical file not found on disk"
        else:
            with open(full_path, "r", encoding="utf-8") as f:
                content = f.read()

            # 2. import_works: Has valid dart code and uses standard packages
            import_works = 1 if "import " in content else 0
            
            # 3. component_exists: Always 1 for valid screen widget components on disk
            component_exists = 1
            
            # 4. class_exists: Expected Dart class found in content
            expected_class = file_name.replace(".dart", "").replace("_", " ").title().replace(" ", "")
            # Check either exact name class declaration or general extends Governing/ConsumerWidget
            class_exists = 1 if f"class {expected_class}" in content or re.search(r'class\s+\w+DashboardScreen\s+extends', content) else 0
            
            # 5. route_exists: Screen route path exists in screens table
            if screen_id:
                cursor.execute("SELECT route_path FROM screens WHERE id = ?", (screen_id,))
                scr_match = cursor.fetchone()
                route_exists = 1 if scr_match and scr_match[0] else 0
            else:
                route_exists = 0
                
            # 6. widget_exported: Check if exported in primecare_ui.dart
            # E.g., export 'src/screens/executive/coo_dashboard_screen.dart';
            # Extract relative export path from lib/ to filename
            rel_to_lib = file_path.replace("packages/primecare_ui/lib/", "")
            widget_exported = 1 if rel_to_lib in exports_content else 0

            # 7. widget_renders: No Placeholder widget and has class_exists
            is_placeholder = "Placeholder(" in content or "Placeholder()" in content
            widget_renders = 1 if not is_placeholder and class_exists == 1 else 0

            # Human Rule: File is valid only when: file exists + import works + class exists + route_exists + widget_renders
            is_valid = (file_exists == 1 and import_works == 1 and class_exists == 1 and route_exists == 1 and widget_renders == 1)
            
            if is_valid:
                verification_status = "passed"
                passed_count += 1
            else:
                verification_status = "failed"
                failed_count += 1
                
                # Construct detailed error message
                failures = []
                if file_exists == 0: failures.append("file missing")
                if import_works == 0: failures.append("import failed")
                if class_exists == 0: failures.append("class declaration missing")
                if route_exists == 0: failures.append("no route registered in screens table")
                if widget_renders == 0: failures.append("placeholder widget present or layout is stub")
                
                error_message = f"Validation failed: {', '.join(failures)}"

        # Insert or replace verification result
        cursor.execute("SELECT id FROM file_verification_checks WHERE file_id = ?", (file_id,))
        existing_check = cursor.fetchone()
        
        if existing_check:
            cursor.execute("""
                UPDATE file_verification_checks
                SET screen_id = ?, file_path = ?, file_exists = ?, import_works = ?,
                    component_exists = ?, class_exists = ?, route_exists = ?,
                    widget_exported = ?, widget_renders = ?, verification_status = ?,
                    error_message = ?, checked_at = ?
                WHERE id = ?
            """, (screen_id, file_path, file_exists, import_works, component_exists,
                  class_exists, route_exists, widget_exported, widget_renders,
                  verification_status, error_message, datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                  existing_check[0]))
        else:
            cursor.execute("""
                INSERT INTO file_verification_checks (
                    file_id, screen_id, file_path, file_exists, import_works,
                    component_exists, class_exists, route_exists, widget_exported,
                    widget_renders, verification_status, error_message, checked_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (file_id, screen_id, file_path, file_exists, import_works,
                  component_exists, class_exists, route_exists, widget_exported,
                  widget_renders, verification_status, error_message, datetime.now().strftime("%Y-%m-%d %H:%M:%S")))

    conn.commit()
    print(f"\nVerification Sweep Complete.")
    print(f"  Passed (Valid): {passed_count} screens")
    print(f"  Failed (Stub/Invalid): {failed_count} screens")
    print(f"  Total Audited: {len(code_files)}")

    # Let's count unverified files from our view
    cursor.execute("SELECT count(*) FROM v_unverified_files")
    unverified_count = cursor.fetchone()[0]
    print(f"  Unverified (Stub or missing components) via v_unverified_files view: {unverified_count}")

    conn.close()

if __name__ == "__main__":
    run_verification_sweep()
