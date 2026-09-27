import os
import sqlite3

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def write_report(filename, title, headers, rows):
    path = os.path.join(PROJECT_ROOT, filename)
    with open(path, "w", encoding="utf-8") as f:
        f.write(f"# {title}\n\n")
        f.write("| " + " | ".join(headers) + " |\n")
        f.write("| " + " | ".join(["---"] * len(headers)) + " |\n")
        for row in rows:
            f.write("| " + " | ".join(str(val) if val is not None else "" for val in row) + " |\n")
    print(f"Generated report: {filename} at {path}")

def main():
    print("==============================================================")
    print("GENERATING GOVERNANCE QUALITY REPORTS FROM GOVERNANCE DB")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. EMPTY SCREEN REPORT
    c.execute("""
        SELECT 
            COALESCE(r.role_code, 'guest') as role,
            s.id as screen_id,
            s.screen_name,
            s.route_path as route,
            COALESCE(std.sidebar_label, s.screen_name) as expected_sidebar_label,
            'N/A' as actual_sidebar_links_found,
            COALESCE(str.screenshot_path, 'None') as screenshot_path,
            si.description as failure_reason,
            s.actual_file_path as source_file,
            'runtime_verified=' || s.runtime_verified || ', cypress_verified=' || s.cypress_verified || ', production_ready=' || s.production_ready as db_record_status
        FROM screen_issues si
        JOIN screens s ON si.screen_id = s.id
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN screen_test_results str ON si.test_result_id = str.id
        LEFT JOIN screen_test_definitions std ON std.screen_id = s.id
        WHERE si.issue_type IN ('empty_screen', 'placeholder_only')
    """)
    empty_rows = [list(row) for row in c.fetchall()]
    empty_headers = ["Role", "Screen ID", "Screen Name", "Route", "Expected Sidebar Label", "Actual Sidebar Links Found", "Screenshot Path", "Failure Reason", "Source File", "DB Record Status"]
    write_report("EMPTY_SCREEN_REPORT.md", "Empty Screen Audit Report", empty_headers, empty_rows)

    # 2. MISSING SIDEBAR LINK REPORT
    c.execute("""
        SELECT 
            COALESCE(r.role_code, 'guest') as role,
            s.id as screen_id,
            s.screen_name,
            s.route_path as route,
            COALESCE(std.sidebar_label, s.screen_name) as expected_sidebar_label,
            'Missing' as actual_sidebar_links_found,
            COALESCE(str.screenshot_path, 'None') as screenshot_path,
            si.description as failure_reason,
            s.actual_file_path as source_file,
            'runtime_verified=' || s.runtime_verified || ', cypress_verified=' || s.cypress_verified || ', production_ready=' || s.production_ready as db_record_status
        FROM screen_issues si
        JOIN screens s ON si.screen_id = s.id
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN screen_test_results str ON si.test_result_id = str.id
        LEFT JOIN screen_test_definitions std ON std.screen_id = s.id
        WHERE si.issue_type = 'missing_sidebar_link'
    """)
    sidebar_rows = [list(row) for row in c.fetchall()]
    sidebar_headers = ["Role", "Screen ID", "Screen Name", "Route", "Expected Sidebar Label", "Actual Sidebar Links Found", "Screenshot Path", "Failure Reason", "Source File", "DB Record Status"]
    write_report("MISSING_SIDEBAR_LINK_REPORT.md", "Missing Sidebar Link Audit Report", sidebar_headers, sidebar_rows)

    # 3. ROLE WITH ZERO SIDEBAR LINKS REPORT
    c.execute("""
        SELECT 
            COALESCE(r.role_code, 'guest') as role,
            'N/A' as screen_id,
            'N/A' as screen_name,
            'N/A' as route,
            'N/A' as expected_sidebar_label,
            '0' as actual_sidebar_links_found,
            COALESCE(str.screenshot_path, 'None') as screenshot_path,
            si.description as failure_reason,
            'N/A' as source_file,
            'N/A' as db_record_status
        FROM screen_issues si
        LEFT JOIN screen_test_results str ON si.test_result_id = str.id
        LEFT JOIN screen_test_definitions std ON str.test_definition_id = std.id
        LEFT JOIN roles r ON std.role_id = r.id
        WHERE si.issue_type = 'missing_sidebar_link' AND si.description LIKE '%zero links%'
    """)
    zero_sidebar_rows = [list(row) for row in c.fetchall()]
    write_report("ROLE_WITH_ZERO_SIDEBAR_LINKS_REPORT.md", "Roles With Zero Sidebar Links Report", sidebar_headers, zero_sidebar_rows)

    # 4. SCREENSHOT FAILURE INDEX
    c.execute("""
        SELECT 
            COALESCE(r.role_code, 'guest') as role,
            s.id as screen_id,
            s.screen_name,
            s.route_path as route,
            COALESCE(std.sidebar_label, s.screen_name) as expected_sidebar_label,
            'N/A' as actual_sidebar_links_found,
            COALESCE(str.screenshot_path, 'None') as screenshot_path,
            str.error_message as failure_reason,
            s.actual_file_path as source_file,
            'runtime_verified=' || s.runtime_verified || ', cypress_verified=' || s.cypress_verified || ', production_ready=' || s.production_ready as db_record_status
        FROM screen_test_results str
        JOIN screens s ON str.screen_id = s.id
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN screen_test_definitions std ON std.screen_id = s.id
        WHERE str.status = 'failed' AND str.screenshot_path IS NOT NULL
    """)
    screenshot_rows = [list(row) for row in c.fetchall()]
    write_report("SCREENSHOT_FAILURE_INDEX.md", "Screenshot Failure Index Report", sidebar_headers, screenshot_rows)

    conn.close()
    print("==============================================================")
    print("ALL REPORTS GENERATED SUCCESSFULLY!")
    print("==============================================================")

if __name__ == "__main__":
    main()
