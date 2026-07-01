import os
import sqlite3
import json

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
ARTIFACT_DIR = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1"
REPORT_PATH = os.path.join(PROJECT_ROOT, "SCREEN_COMPLETENESS_REPORT.md")

def main():
    print("==============================================================")
    print("RUNNING CORE SCREEN-CENTRIC COMPLETENESS AUDIT")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Fetch all screens with role and app details
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, s.actual_file_path, r.role_code, a.app_code
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN apps a ON s.app_id = a.id
        WHERE s.active = 1
        ORDER BY s.id ASC
    """)
    screens = c.fetchall()
    total_screens = len(screens)
    print(f"Loaded {total_screens} active screens from database.")

    # Counters
    passed_all = 0
    missing_req = 0
    missing_elements = 0
    missing_apis = 0
    missing_code = 0
    missing_route = 0
    missing_sidebar = 0
    untested_apis = 0
    missing_cypress = 0
    missing_screenshot = 0

    screen_stats = []

    for s in screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        route_path = s["route_path"]
        actual_path = s["actual_file_path"]
        role_code = s["role_code"] or "guest"
        app_code = s["app_code"] or "common"

        # Check 1: Requirement
        c.execute("SELECT COUNT(*) FROM screen_requirements WHERE screen_id = ?", (screen_id,))
        has_req = c.fetchone()[0] > 0
        if not has_req:
            missing_req += 1

        # Check 2: UI Elements
        c.execute("SELECT COUNT(*) FROM screen_required_elements WHERE screen_id = ?", (screen_id,))
        has_elements = c.fetchone()[0] > 0
        if not has_elements:
            missing_elements += 1

        # Check 3: API Mapping
        c.execute("SELECT COUNT(*) FROM screen_api_map WHERE screen_id = ?", (screen_id,))
        has_apis = c.fetchone()[0] > 0
        if not has_apis:
            missing_apis += 1

        # Check 4: Physical Code existence
        has_code = False
        if actual_path:
            full_code_path = os.path.join(PROJECT_ROOT, actual_path)
            has_code = os.path.exists(full_code_path)
        if not has_code:
            missing_code += 1

        # Check 5: Route defined
        has_route = bool(route_path and route_path.startswith('/'))
        if not has_route:
            missing_route += 1

        # Check 6: Sidebar label
        c.execute("SELECT sidebar_label FROM screen_requirements WHERE screen_id = ?", (screen_id,))
        sb_row = c.fetchone()
        has_sidebar = bool(sb_row and sb_row["sidebar_label"] and "placeholder" not in sb_row["sidebar_label"].lower())
        if not has_sidebar:
            missing_sidebar += 1

        # Check 7: API Data test status
        c.execute("""
            SELECT ar.status FROM screen_api_map sam
            JOIN api_registry ar ON sam.api_id = ar.id
            WHERE sam.screen_id = ?
        """, (screen_id,))
        api_statuses = [row[0] for row in c.fetchall()]
        api_data_ok = all(status in ['mocked', 'tested', 'implemented'] for status in api_statuses)
        if not api_data_ok:
            untested_apis += 1

        # Check 8: Cypress verification passes
        c.execute("SELECT COUNT(*) FROM screen_test_results WHERE screen_id = ? AND status = 'passed'", (screen_id,))
        cypress_passed = c.fetchone()[0] > 0
        if not cypress_passed:
            missing_cypress += 1

        # Check 9: Visual proof screenshot exists
        screenshot_exists = False
        full_screenshot_path = os.path.join(ARTIFACT_DIR, "screenshots", role_code, app_code, f"{screen_code}.png")
        if os.path.exists(full_screenshot_path):
            screenshot_exists = True
        else:
            c.execute("SELECT screenshot_path FROM screen_test_results WHERE screen_id = ? AND screenshot_path IS NOT NULL", (screen_id,))
            st_rows = c.fetchall()
            for r in st_rows:
                if r[0] and os.path.exists(os.path.join(PROJECT_ROOT, r[0])):
                    screenshot_exists = True
                    break
        if not screenshot_exists:
            missing_screenshot += 1

        # Check overall completeness
        is_complete = all([
            has_req, has_elements, has_apis, has_code, has_route, 
            has_sidebar, api_data_ok, cypress_passed, screenshot_exists
        ])

        if is_complete:
            passed_all += 1
            production_ready = 1
            cypress_verified = 1
        else:
            production_ready = 0
            cypress_verified = 1 if cypress_passed else 0

        # Update screen record flags
        c.execute("""
            UPDATE screens
            SET production_ready = ?,
                cypress_verified = ?
            WHERE id = ?
        """, (production_ready, cypress_verified, screen_id))

        # Re-log completeness issues
        c.execute("DELETE FROM screen_issues WHERE screen_id = ? AND issue_type = 'completeness_drift'", (screen_id,))
        
        failures = []
        if not has_req: failures.append("Missing requirement definition")
        if not has_elements: failures.append("Missing required UI elements")
        if not has_apis: failures.append("Missing API mappings")
        if not has_code: failures.append("Missing physical Flutter view file")
        if not has_route: failures.append("Missing or invalid route path")
        if not has_sidebar: failures.append("Missing or invalid sidebar label")
        if not api_data_ok: failures.append("Contains untested or planned APIs")
        if not cypress_passed: failures.append("No passing Cypress test results")
        if not screenshot_exists: failures.append("Missing screenshot visual proof")
        
        if failures:
            desc = "Screen completeness check failed: " + "; ".join(failures)
            c.execute("""
                INSERT INTO screen_issues (screen_id, issue_type, severity, description, fixed)
                VALUES (?, 'completeness_drift', 'high', ?, 0)
            """, (screen_id, desc))

        screen_stats.append({
            "id": screen_id,
            "code": screen_code,
            "name": screen_name,
            "is_complete": is_complete,
            "failures": failures
        })

    # Save changes
    conn.commit()

    # Generate SCREEN_COMPLETENESS_REPORT.md
    print("Generating SCREEN_COMPLETENESS_REPORT.md...")
    with open(REPORT_PATH, "w", encoding="utf-8") as f:
        f.write("# Screen-Centric Completeness Governance Report\n\n")
        f.write("This report evaluates every screen in the PrimeCare platform against 9 completeness criteria to establish the screen as the central parent object in the platform governance.\n\n")
        
        f.write("## Completeness Summary Metrics\n\n")
        f.write(f"- **Total Governed Screens**: {total_screens}\n")
        f.write(f"- **Fully Complete / Production Ready**: {passed_all} ({(passed_all/total_screens)*100:.2f}%)\n")
        f.write(f"- **Incomplete / Development Required**: {total_screens - passed_all} ({((total_screens-passed_all)/total_screens)*100:.2f}%)\n\n")

        f.write("### Criteria Deficit Breakdown\n\n")
        f.write("| Criterion Checked | Deficit Count | Compliance Rate |\n")
        f.write("|---|---|---|\n")
        f.write(f"| 1. Requirements Definition | {missing_req} | {((total_screens-missing_req)/total_screens)*100:.2f}% |\n")
        f.write(f"| 2. Required UI Elements | {missing_elements} | {((total_screens-missing_elements)/total_screens)*100:.2f}% |\n")
        f.write(f"| 3. Mapped APIs | {missing_apis} | {((total_screens-missing_apis)/total_screens)*100:.2f}% |\n")
        f.write(f"| 4. Physical Flutter View Code | {missing_code} | {((total_screens-missing_code)/total_screens)*100:.2f}% |\n")
        f.write(f"| 5. Router Mounting | {missing_route} | {((total_screens-missing_route)/total_screens)*100:.2f}% |\n")
        f.write(f"| 6. Sidebar Navigation Config | {missing_sidebar} | {((total_screens-missing_sidebar)/total_screens)*100:.2f}% |\n")
        f.write(f"| 7. API Data Return Status | {untested_apis} | {((total_screens-untested_apis)/total_screens)*100:.2f}% |\n")
        f.write(f"| 8. Passing Cypress E2E Tests | {missing_cypress} | {((total_screens-missing_cypress)/total_screens)*100:.2f}% |\n")
        f.write(f"| 9. Visual Screenshot Verification | {missing_screenshot} | {((total_screens-missing_screenshot)/total_screens)*100:.2f}% |\n\n")

        f.write("## Detailed Deficit Log\n\n")
        f.write("| Screen ID | Screen Code | Screen Name | Deficits / Blocking Issues |\n")
        f.write("|---|---|---|---|\n")
        for stat in screen_stats:
            if not stat["is_complete"]:
                failures_str = ", ".join(stat["failures"])
                f.write(f"| {stat['id']} | `{stat['code']}` | {stat['name']} | {failures_str} |\n")

    conn.close()
    print("COMPLETENESS AUDIT COMPLETE!")
    print(f"Generated report at: {REPORT_PATH}")
    print("==============================================================")

if __name__ == "__main__":
    main()
