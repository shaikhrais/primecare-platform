import os
import sqlite3
import json
from pathlib import Path

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
OUTPUT_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "generated", "screen-tests.json")

def main():
    print("==============================================================")
    print("EXPORTING SCREEN TESTS FROM GOVERNANCE DB TO CYPRESS FIXTURE")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Fetch all enabled test definitions
    c.execute("""
        SELECT td.*, s.screen_code, s.screen_name, s.route_path AS scr_route_path,
               r.role_name, r.role_code
        FROM screen_test_definitions td
        JOIN screens s ON td.screen_id = s.id
        LEFT JOIN roles r ON td.role_id = r.id
        WHERE td.enabled = 1
        ORDER BY td.priority ASC, td.id ASC
    """)
    definitions = [dict(row) for row in c.fetchall()]
    print(f"Found {len(definitions)} enabled test definitions.")

    tests = []

    for td in definitions:
        def_id = td["id"]
        screen_id = td["screen_id"]

        # 1. Fetch steps
        c.execute("""
            SELECT action, selector, value, expected, timeout_ms, required
            FROM screen_test_steps
            WHERE test_definition_id = ?
            ORDER BY step_order ASC
        """, (def_id,))
        steps_rows = c.fetchall()
        steps = []
        for r in steps_rows:
            step = {
                "action": r["action"],
                "selector": r["selector"] or "",
                "value": r["value"] or "",
                "expected": r["expected"] or "",
                "timeout_ms": r["timeout_ms"] or 10000,
                "required": bool(r["required"])
            }
            steps.append(step)

        # 2. Parse required elements directly from JSON column in screen_test_definitions
        required_elements = []
        if td["required_elements_json"]:
            try:
                required_elements = json.loads(td["required_elements_json"])
            except Exception as e:
                print(f"Warning: Failed to parse required_elements_json for def_id {def_id}: {e}")

        # 3. Parse forbidden text directly from JSON column
        forbidden_text = []
        if td["forbidden_text_json"]:
            try:
                forbidden_text = json.loads(td["forbidden_text_json"])
            except Exception as e:
                print(f"Warning: Failed to parse forbidden_text_json for def_id {def_id}: {e}")

        # 4. Parse acceptance criteria directly from JSON column
        acceptance_criteria = []
        if td["acceptance_criteria_json"]:
            try:
                acceptance_criteria = json.loads(td["acceptance_criteria_json"])
            except Exception as e:
                print(f"Warning: Failed to parse acceptance_criteria_json for def_id {def_id}: {e}")

        # 4.5. Fetch mapped APIs for the screen
        c.execute("""
            SELECT ar.api_code, ar.endpoint_path, ar.method, ar.status
            FROM screen_api_map sam
            JOIN api_registry ar ON sam.api_id = ar.id
            WHERE sam.screen_id = ?
        """, (screen_id,))
        apis = [dict(row) for row in c.fetchall()]

        # 5. Construct the test payload
        test_obj = {
            "test_definition_id": def_id,
            "screen_id": screen_id,
            "screen_code": td["screen_code"],
            "screen_name": td["screen_name"],
            "role": td["role_code"] or "guest",
            "route_path": td["route_path"] or td["scr_route_path"],
            "test_code": td["test_code"],
            "requires_auth": bool(td["requires_auth"]),
            "sidebar_label": td["sidebar_label"] or td["screen_name"],
            "expected_title": td["expected_title"] or td["screen_name"],
            "required_elements": required_elements,
            "forbidden_text": forbidden_text,
            "acceptance_criteria": acceptance_criteria,
            "apis": apis,
            "steps": steps
        }
        tests.append(test_obj)

    # Make output directory if not exists
    Path(os.path.dirname(OUTPUT_PATH)).mkdir(parents=True, exist_ok=True)

    # Write out the fixture file
    with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
        json.dump({"tests": tests}, f, indent=2)

    conn.close()

    print(f"Successfully exported {len(tests)} tests to:")
    print(f"  {OUTPUT_PATH}")
    print("==============================================================")

if __name__ == "__main__":
    main()
