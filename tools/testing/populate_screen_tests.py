import os
import sqlite3
import json

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

DEFAULT_FORBIDDEN_TEXT = [
    "Fully Implemented",
    "Placeholder",
    "Coming Soon",
    "TODO",
    "Lorem ipsum",
    "Under Construction",
    "Sample Data",
    "Screen Implemented"
]

def main():
    print("==============================================================")
    print("POPULATING CYPRESS SCREEN TEST DATA ENTRY LAYER SCREEN-BY-SCREEN")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Clear previous test data entries to build a clean set
    print("Clearing obsolete test steps and definitions...")
    c.execute("DELETE FROM screen_test_steps")
    c.execute("DELETE FROM screen_test_definitions")
    c.execute("DELETE FROM screen_test_results")
    c.execute("DELETE FROM screen_test_runs")
    conn.commit()

    # Fetch all screens
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, s.role_id,
               r.role_code, r.role_name
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
    """)
    screens = [dict(row) for row in c.fetchall()]
    total_screens = len(screens)
    print(f"Loaded {total_screens} screens to process.\n")

    definitions_count = 0
    steps_count = 0

    for idx, s in enumerate(screens, 1):
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        route_path = s["route_path"]
        role_code = s["role_code"] or "guest"

        # Check for public routes
        public_keywords = ["login", "signup", "forgot_password", "reset_password", "mfa", "register"]
        requires_auth = 1
        if not route_path or not route_path.startswith("/"):
            # Skip invalid/unmapped routes
            print(f"[{idx}/{total_screens}] Screen '{screen_code}' -> SKIPPED (Invalid Route: {route_path})")
            continue

        if any(kw in screen_code.lower() for kw in public_keywords) or any(kw in route_path.lower() for kw in public_keywords):
            requires_auth = 0

        # Fetch required elements for this screen from screen_required_elements
        c.execute("""
            SELECT element_key, test_id, element_type, required
            FROM screen_required_elements
            WHERE screen_id = ?
        """, (screen_id,))
        elements = [dict(row) for row in c.fetchall()]

        required_test_ids = [el["test_id"] for el in elements if el["required"] == 1 and el["test_id"]]
        
        # Build JSON metadata strings
        required_elements_json = json.dumps(required_test_ids)
        forbidden_text_json = json.dumps(DEFAULT_FORBIDDEN_TEXT)
        acceptance_criteria = [
            f"Screen '{screen_name}' mounts successfully",
            f"Access route '{route_path}' renders without blank errors"
        ]
        for el in elements:
            if el["required"] == 1:
                acceptance_criteria.append(f"Required element '{el['element_key']}' is visible")
        acceptance_criteria_json = json.dumps(acceptance_criteria)

        test_code = f"{screen_code}_runtime"
        test_name = f"{screen_name} Runtime Test"

        # Insert test definition record
        c.execute("""
            INSERT INTO screen_test_definitions (
                screen_id, test_code, test_name, test_type, enabled, priority, requires_auth, 
                role_id, route_path, sidebar_label, expected_title, expected_layout, 
                required_elements_json, forbidden_text_json, acceptance_criteria_json
            ) VALUES (?, ?, ?, 'e2e', 1, 100, ?, ?, ?, ?, ?, 'dashboard', ?, ?, ?)
        """, (
            screen_id,
            test_code,
            test_name,
            requires_auth,
            s["role_id"],
            route_path,
            screen_name,
            screen_name,
            required_elements_json,
            forbidden_text_json,
            acceptance_criteria_json
        ))
        def_id = c.lastrowid
        definitions_count += 1

        # Build test steps
        steps = []
        step_order = 1

        # Step 1: login (if requires_auth = 1)
        if requires_auth == 1:
            steps.append((def_id, step_order, "login_as_role", None, role_code, None))
            step_order += 1

        # Step 2: visit route
        steps.append((def_id, step_order, "visit", None, route_path, None))
        step_order += 1

        # Step 3+: Verify each required element
        for el in elements:
            if el["required"] == 1 and el["test_id"]:
                # We normalize the selector format for Cypress semantics check
                steps.append((def_id, step_order, "should_be_visible", el["test_id"], None, None))
                step_order += 1

        # Step N-1: check for no console errors
        steps.append((def_id, step_order, "check_no_console_error", None, None, None))
        step_order += 1

        # Step N: screenshot proof
        steps.append((def_id, step_order, "screenshot", None, None, None))
        step_order += 1

        # Insert steps bulk for the screen
        c.executemany("""
            INSERT INTO screen_test_steps (test_definition_id, step_order, action, selector, value, expected)
            VALUES (?, ?, ?, ?, ?, ?)
        """, steps)
        steps_count += len(steps)

        print(f"[{idx}/{total_screens}] Screen '{screen_code}' -> Created test: {test_code} (Steps: {len(steps)})")

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("DATA ENTRY POPULATION COMPLETE!")
    print(f"  - Total Test Definitions Inserted: {definitions_count}")
    print(f"  - Total Test Steps Inserted: {steps_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
