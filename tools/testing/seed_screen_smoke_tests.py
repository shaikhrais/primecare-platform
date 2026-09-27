import os
import sqlite3
import json
import re

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

def clean_sidebar_label(name):
    if name.endswith("Screen"):
        name = name[:-6]
    # Insert space before uppercase letters
    words = re.findall(r'[A-Z][a-z0-9]*', name)
    if not words:
        words = [name]
    # Capitalize acronyms
    acronyms = {
        "Rmt": "RMT", "Psw": "PSW", "Rn": "RN", "Cns": "CNS", "Lpn": "LPN", 
        "Np": "NP", "Hsw": "HSW", "Db": "DB", "Ui": "UI", "Qa": "QA", 
        "Hr": "HR", "Cme": "CME", "Cto": "CTO", "Cfo": "CFO", "Coo": "COO", 
        "Ceo": "CEO", "Mfa": "MFA", "Bdm": "BDM", "Cx": "CX", "Vip": "VIP"
    }
    clean_words = [acronyms.get(w, w) for w in words]
    return " ".join(clean_words)

def main():
    print("==============================================================")
    print("AUTOMATED SMOKE TEST SEEDER: DB-DRIVEN SCREEN-BY-SCREEN")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Clear previous test data to ensure clean seeding
    print("Clearing obsolete test definitions, steps, runs and results...")
    c.execute("DELETE FROM screen_test_steps")
    c.execute("DELETE FROM screen_test_definitions")
    c.execute("DELETE FROM screen_test_results")
    c.execute("DELETE FROM screen_test_runs")
    c.execute("DELETE FROM screen_issues WHERE issue_type = 'invalid_route'")
    conn.commit()

    # Fetch all screens
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, s.role_id, r.role_code
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
    """)
    screens = [dict(row) for row in c.fetchall()]
    total_screens = len(screens)
    print(f"Found {total_screens} screens to process.\n")

    definitions_seeded = 0
    steps_seeded = 0
    invalid_routes_count = 0

    for idx, s in enumerate(screens, 1):
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        route_path = s["route_path"]
        role_id = s["role_id"]
        role_code = s["role_code"] or "guest"

        # 1. Skip screens where route_path is null or invalid
        if not route_path or not route_path.startswith("/"):
            print(f"[{idx}/{total_screens}] Screen '{screen_code}' -> INVALID ROUTE ({route_path})")
            
            # Log as invalid_route issue in screen_issues
            c.execute("""
                INSERT INTO screen_issues (screen_id, issue_type, severity, description, fixed)
                VALUES (?, 'invalid_route', 'critical', 'Screen route_path is null or invalid', 0)
            """, (screen_id,))
            
            # Update screen verification status to 0
            c.execute("""
                UPDATE screens
                SET runtime_verified = 0, cypress_verified = 0, production_ready = 0
                WHERE id = ?
            """, (screen_id,))
            invalid_routes_count += 1
            continue

        # 2. Determine auth requirement
        requires_auth = 1
        public_keywords = ["login", "signup", "forgot_password", "reset_password", "mfa", "register"]
        if any(kw in screen_code.lower() for kw in public_keywords) or any(kw in route_path.lower() for kw in public_keywords):
            requires_auth = 0

        test_code = f"{screen_code}_runtime"
        test_name = f"{screen_name} Smoke Test"

        # 3. Clean sidebar label
        cleaned_label = clean_sidebar_label(screen_name)

        # 4. Fetch required elements for this screen
        c.execute("""
            SELECT element_key, test_id, element_type, required
            FROM screen_required_elements
            WHERE screen_id = ?
        """, (screen_id,))
        req_rows = c.fetchall()
        req_elements = []
        for row in req_rows:
            req_elements.append({
                "key": row["element_key"],
                "selector": row["test_id"],
                "type": row["element_type"],
                "required": bool(row["required"])
            })
        required_elements_json = json.dumps(req_elements)

        # 5. Fetch acceptance criteria for this screen
        c.execute("""
            SELECT acceptance_criteria
            FROM screen_requirements
            WHERE screen_id = ?
        """, (screen_id,))
        req_row = c.fetchone()
        criteria = []
        if req_row and req_row["acceptance_criteria"]:
            for line in req_row["acceptance_criteria"].split("\n"):
                line = line.strip(" -*")
                if line:
                    criteria.append(line)
        acceptance_criteria_json = json.dumps(criteria)

        # 6. Insert Smoke Test Definition with populated JSON fields and cleaned sidebar labels
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
            role_id,
            route_path,
            cleaned_label,
            cleaned_label,
            required_elements_json,
            json.dumps(DEFAULT_FORBIDDEN_TEXT),
            acceptance_criteria_json
        ))
        def_id = c.lastrowid
        definitions_seeded += 1

        # 7. Create the 11 Standard E2E Smoke Test Steps with cleaned label values
        steps = [
            (def_id, 1, "login_as_role", None, role_code, None),
            (def_id, 2, "verify_sidebar_exists", "app-sidebar", None, None),
            (def_id, 3, "verify_sidebar_link_exists", None, cleaned_label, None),
            (def_id, 4, "click_sidebar_link", None, cleaned_label, None),
            (def_id, 5, "check_url", None, route_path, None),
            (def_id, 6, "verify_topbar_exists", "app-topbar", None, None),
            (def_id, 7, "verify_main_content_exists", "app-content-slot", None, None),
            (def_id, 8, "verify_screen_not_empty", None, None, None),
            (def_id, 9, "verify_forbidden_text_absent", None, None, None),
            (def_id, 10, "verify_no_console_errors", None, None, None),
            (def_id, 11, "screenshot", None, None, None)
        ]

        c.executemany("""
            INSERT INTO screen_test_steps (test_definition_id, step_order, action, selector, value, expected)
            VALUES (?, ?, ?, ?, ?, ?)
        """, steps)
        steps_seeded += len(steps)

        print(f"[{idx}/{total_screens}] Screen '{screen_code}' -> Seeded successfully (11 steps, {len(req_elements)} elements, {len(criteria)} criteria)")

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("SMOKE TEST SEEDER COMPLETE!")
    print(f"  - Total Smoke Test Definitions Seeded: {definitions_seeded}")
    print(f"  - Total Smoke Test Steps Seeded: {steps_seeded}")
    print(f"  - Total Invalid Route Screens Flagged: {invalid_routes_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
