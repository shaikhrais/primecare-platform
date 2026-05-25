# Scripts - Category: scan | Purpose: Scan physical screens for empty/stub files (no buttons or very small code) and register them as pending implementation tasks in the SQLite database.
import os
import sqlite3
from datetime import datetime

DB_PATH = os.path.join(".agents", "governance", "governance.db")
REPO_ROOT = "c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform"
SCREENS_DIR = os.path.join(REPO_ROOT, "packages", "primecare_ui", "lib", "src", "screens")

BUTTON_KEYWORDS = [
    "ElevatedButton",
    "TextButton",
    "IconButton",
    "OutlinedButton",
    "FloatingActionButton",
    "MaterialButton",
    "InkWell",
    "GestureDetector"
]

def scan_and_seed_tasks():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Get a list of all physical dart files in packages/primecare_ui/lib/src/screens/
    physical_files = []
    for root, dirs, files in os.walk(SCREENS_DIR):
        for file in files:
            if file.endswith(".dart"):
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, REPO_ROOT).replace("\\", "/")
                physical_files.append((file, rel_path, full_path))

    print(f"Found {len(physical_files)} physical Dart screen files in {SCREENS_DIR}.")

    empty_screens = []
    for filename, rel_path, full_path in physical_files:
        with open(full_path, "r", encoding="utf-8") as f:
            content = f.read()

        lines = content.splitlines()
        byte_size = len(content)

        # Check for buttons
        found_buttons = [kw for kw in BUTTON_KEYWORDS if kw in content]
        has_button = len(found_buttons) > 0

        # Check for placeholder layouts
        is_placeholder = "Placeholder(" in content or "Placeholder()" in content

        # Determine if it is a stub or empty screen
        is_empty = False
        reason = ""

        if not has_button:
            is_empty = True
            reason = "No interactive buttons found"
        elif is_placeholder:
            is_empty = True
            reason = "Contains Placeholder() layout"
        elif len(lines) < 60 or byte_size < 2000:
            is_empty = True
            reason = f"Extremely small file ({len(lines)} lines, {byte_size} bytes)"

        if is_empty:
            # Query package_files to resolve the file ID
            cursor.execute("SELECT id, purpose FROM package_files WHERE file_path = ?", (rel_path,))
            pf_match = cursor.fetchone()
            package_file_id = pf_match[0] if pf_match else None
            purpose = pf_match[1] if pf_match else f"UI Screen component rendering the {filename.replace('.dart', '').replace('_', ' ').title()} workspace interface."

            # Query screens to see if it is registered as an active screen
            cursor.execute("SELECT id, app_id, screen_name FROM screens WHERE file_path = ? OR file_path LIKE ?", (rel_path, f"%{filename}"))
            scr_match = cursor.fetchone()
            
            screen_id = scr_match[0] if scr_match else None
            db_app_id = scr_match[1] if scr_match else None
            screen_name = scr_match[2] if scr_match else filename.replace(".dart", "").replace("_", " ").title().replace(" ", "")

            # If not found in screens, query artifact_ownership or fallback to directory logic
            app_id = db_app_id
            if not app_id and package_file_id:
                cursor.execute("SELECT logical_app_id FROM artifact_ownership WHERE package_file_id = ?", (package_file_id,))
                ao_match = cursor.fetchone()
                if ao_match:
                    app_id = ao_match[0]

            # Failsafe directory fallback mapping
            if not app_id:
                dir_name = rel_path.split("/")[-2]
                if dir_name in ["allied", "clinical", "rn", "rpn"]:
                    app_id = 6 # Primecare Clinic
                elif dir_name in ["executive", "management", "premium"]:
                    app_id = 7 # Primecare Corporate
                elif dir_name in ["psw"]:
                    app_id = 12 # Primecare Support
                else:
                    app_id = 1 # PrimeCare UI Client (Failsafe)

            empty_screens.append({
                "filename": filename,
                "rel_path": rel_path,
                "reason": reason,
                "details": f"Lines: {len(lines)}, Bytes: {byte_size}, Buttons: {found_buttons}",
                "package_file_id": package_file_id,
                "screen_id": screen_id,
                "app_id": app_id,
                "screen_name": screen_name,
                "purpose": purpose
            })

    print(f"\nScan completed. Found {len(empty_screens)} empty or non-interactive physical screens.")

    # Now register tasks for each empty/stub screen in implementation_tasks
    new_tasks_count = 0
    for screen in empty_screens:
        screen_id = screen["screen_id"]
        package_file_id = screen["package_file_id"]
        app_id = screen["app_id"]
        screen_name = screen["screen_name"]
        rel_path = screen["rel_path"]
        reason = screen["reason"]

        # Check if task already exists for this screen
        if screen_id:
            cursor.execute("""
                SELECT id, status FROM implementation_tasks 
                WHERE related_screen_id = ? AND task_title LIKE ?
            """, (screen_id, "%Wire interactive buttons%"))
            existing = cursor.fetchone()
        elif package_file_id:
            cursor.execute("""
                SELECT id, status FROM implementation_tasks 
                WHERE related_file_id = ? AND task_title LIKE ?
            """, (package_file_id, "%Wire interactive buttons%"))
            existing = cursor.fetchone()
        else:
            existing = None

        if existing:
            print(f"Task already registered for screen {screen_name}: Task ID {existing[0]} ({existing[1]})")
            continue

        # Create new pending task
        task_title = f"Wire interactive buttons and state for {screen_name}"
        task_description = (
            f"The physical screen component '{rel_path}' is currently a stub or lacks interactive controls ({reason}). "
            f"Remediate this by implementing high-fidelity interactive elements (e.g., ElevatedButton, TextButton, "
            f"IconButton, form inputs, dynamic callbacks), wiring events to a StateNotifier/Notifier Riverpod "
            f"controller, and binding corresponding REST API endpoints."
        )

        cursor.execute("""
            INSERT INTO implementation_tasks (
                app_id, task_title, task_description, priority, task_type, 
                related_screen_id, related_file_id, assigned_agent, status, 
                verification_status, created_at
            ) VALUES (?, ?, ?, 'high', 'remediation', ?, ?, 'AI Agent Antigravity', 'pending', 'unverified', ?)
        """, (app_id, task_title, task_description, screen_id, package_file_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S")))

        new_task_id = cursor.lastrowid
        new_tasks_count += 1
        print(f"Registered NEW pending task ID {new_task_id} for screen {screen_name}")

    if new_tasks_count > 0:
        conn.commit()
        print(f"Successfully committed {new_tasks_count} new tasks to the SQLite database.")
    else:
        print("No new tasks seeded.")

    conn.close()

if __name__ == "__main__":
    scan_and_seed_tasks()
