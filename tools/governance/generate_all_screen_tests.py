import sqlite3
import os
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
    print("GENERATING SCREEN TEST DEFINITIONS AND STEPS FOR ALL SCREENS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. Fetch all screens, joining with roles and apps
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, s.role_id,
               r.role_code, r.role_name, a.app_code
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN apps a ON s.app_id = a.id
    """)
    screens = [dict(row) for row in c.fetchall()]
    print(f"Found {len(screens)} screens in the database.")

    # 2. Delete existing definitions and steps for these screens to avoid duplication (re-gen fresh)
    # except caregiver_schedule_runtime (id = 2) which we seeded manually and verified
    c.execute("DELETE FROM screen_test_steps WHERE test_definition_id IN (SELECT id FROM screen_test_definitions WHERE test_code != 'caregiver_schedule_runtime')")
    c.execute("DELETE FROM screen_test_definitions WHERE test_code != 'caregiver_schedule_runtime'")
    conn.commit()

    definitions_inserted = 0
    steps_inserted = 0

    for s in screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        route_path = s["route_path"]
        role_code = s["role_code"] or "guest"
        app_code = s["app_code"]

        # Skip manual caregiver schedule runtime test which is already defined (id = 2)
        if screen_code == "caregiver_schedule" or screen_id == 281:
            print("Skipping caregiver_schedule screen (pre-seeded manually).")
            continue

        # Skip screens without valid route paths
        if not route_path or not route_path.startswith("/"):
            continue

        # Determine if authentication is required
        # Public routes like login, signup, forgot password, MFA, reset password do not require auth
        public_keywords = ["login", "signup", "forgot_password", "reset_password", "mfa", "register"]
        requires_auth = 1
        if any(kw in screen_code.lower() for kw in public_keywords) or any(kw in route_path.lower() for kw in public_keywords):
            requires_auth = 0

        # Fetch sections for this screen
        c.execute("""
            SELECT id, section_code, section_name, section_type, test_id
            FROM screen_sections
            WHERE screen_id = ?
            ORDER BY section_order ASC
        """, (screen_id,))
        sections = [dict(row) for row in c.fetchall()]

        # Generate JSON configurations
        required_test_ids = []
        acceptance_criteria = [
            f"Screen '{screen_name}' mounts successfully",
            f"Access route '{route_path}' renders without blank errors"
        ]

        for sec in sections:
            required_test_ids.append(sec["test_id"])
            acceptance_criteria.append(f"Required section '{sec['section_name']}' is visible")
            
            c.execute("""
                SELECT element_key, test_id, element_type, required, action_required
                FROM screen_section_elements
                WHERE section_id = ?
                ORDER BY element_order ASC
            """, (sec["id"],))
            sec_elements = [dict(row) for row in c.fetchall()]
            sec["elements"] = sec_elements
            
            for el in sec_elements:
                if el["required"] == 1 and el["test_id"]:
                    required_test_ids.append(el["test_id"])
                    acceptance_criteria.append(f"Section element '{el['element_key']}' is visible")

        required_elements_json = json.dumps(required_test_ids)
        forbidden_text_json = json.dumps(DEFAULT_FORBIDDEN_TEXT)
        acceptance_criteria_json = json.dumps(acceptance_criteria)

        test_code = f"{screen_code}_runtime"
        test_name = f"{screen_name} Runtime Test"

        # Insert test definition
        try:
            c.execute("""
                INSERT INTO screen_test_definitions (
                    screen_id, test_code, test_name, test_type, enabled, priority, requires_auth, 
                    role_id, route_path, sidebar_label, expected_title, expected_layout, 
                    required_elements_json, forbidden_text_json, acceptance_criteria_json
                ) VALUES (?, ?, ?, ?, 1, 100, ?, ?, ?, ?, ?, 'dashboard', ?, ?, ?)
            """, (
                screen_id,
                test_code,
                test_name,
                "e2e",
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
            definitions_inserted += 1

            # Generate and insert steps
            steps = []
            step_order = 1

            # Step 1: Login (if auth required)
            if requires_auth == 1:
                steps.append((def_id, step_order, "login_as_role", None, role_code, None))
                step_order += 1

            # Step 2: Visit route
            steps.append((def_id, step_order, "visit", None, route_path, None))
            step_order += 1

            # Step 3+: Verify sections and elements
            for sec in sections:
                # 1. Verify section container is visible
                steps.append((def_id, step_order, "should_be_visible", sec["test_id"], None, None))
                step_order += 1
                
                # 2. Verify all elements in section
                for el in sec["elements"]:
                    if el["required"] == 1 and el["test_id"]:
                        steps.append((def_id, step_order, "should_be_visible", el["test_id"], None, None))
                        step_order += 1
                        
                    # If button/action required, perform interaction
                    if el["action_required"] == 1 and el["test_id"]:
                        steps.append((def_id, step_order, "click", el["test_id"], None, None))
                        step_order += 1

            # Step N-1: Validate no console error
            steps.append((def_id, step_order, "check_no_console_error", None, None, None))
            step_order += 1

            # Step N: Take screenshot
            steps.append((def_id, step_order, "screenshot", None, None, None))
            step_order += 1

            # Bulk insert steps
            c.executemany("""
                INSERT INTO screen_test_steps (test_definition_id, step_order, action, selector, value, expected)
                VALUES (?, ?, ?, ?, ?, ?)
            """, steps)
            steps_inserted += len(steps)

        except sqlite3.IntegrityError as e:
            # Handle unique constraint errors for duplicate test codes
            print(f"Skipping duplicate test code: {test_code} ({e})")

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("GENERATOR EXECUTION COMPLETE!")
    print(f"  - Test Definitions Inserted: {definitions_inserted}")
    print(f"  - Test Steps Inserted: {steps_inserted}")
    print("==============================================================")

if __name__ == "__main__":
    main()
