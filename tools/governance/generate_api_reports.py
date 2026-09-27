import os
import sqlite3
import json

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("GENERATING GOVERNANCE API REPORTS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. API_REGISTRY_REPORT.md
    print("Generating API_REGISTRY_REPORT.md...")
    c.execute("SELECT * FROM api_registry ORDER BY id ASC")
    apis = c.fetchall()
    
    with open(os.path.join(PROJECT_ROOT, "API_REGISTRY_REPORT.md"), "w", encoding="utf-8") as f:
        f.write("# API Registry Report\n\n")
        f.write(f"Total registered APIs: **{len(apis)}**\n\n")
        f.write("| ID | API Code | API Name | Method | Endpoint Path | Status | Auth Required | Role Required |\n")
        f.write("|---|---|---|---|---|---|---|---|\n")
        for api in apis:
            f.write(f"| {api['id']} | `{api['api_code']}` | {api['api_name']} | **{api['method']}** | `{api['endpoint_path']}` | `{api['status']}` | {bool(api['auth_required'])} | `{api['role_required']}` |\n")

    # 2. SCREEN_API_MAP_REPORT.md
    print("Generating SCREEN_API_MAP_REPORT.md...")
    c.execute("""
        SELECT sam.id, sam.screen_id, s.screen_code, s.screen_name, sam.api_id, a.api_code, sam.api_usage, sam.required
        FROM screen_api_map sam
        JOIN screens s ON sam.screen_id = s.id
        JOIN api_registry a ON sam.api_id = a.id
        ORDER BY sam.id ASC
    """)
    mappings = c.fetchall()
    
    with open(os.path.join(PROJECT_ROOT, "SCREEN_API_MAP_REPORT.md"), "w", encoding="utf-8") as f:
        f.write("# Screen API Map Report\n\n")
        f.write(f"Total screen-to-API mappings: **{len(mappings)}**\n\n")
        f.write("| ID | Screen Name | Screen Code | API Name / Code | Usage | Required |\n")
        f.write("|---|---|---|---|---|---|\n")
        for m in mappings:
            f.write(f"| {m['id']} | {m['screen_name']} | `{m['screen_code']}` | `{m['api_code']}` | `{m['api_usage']}` | {bool(m['required'])} |\n")

    # 3. MISSING_API_DATA_ENTRY_REPORT.md
    print("Generating MISSING_API_DATA_ENTRY_REPORT.md...")
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name
        FROM screens s
        LEFT JOIN screen_api_map sam ON s.id = sam.screen_id
        WHERE sam.screen_id IS NULL
    """)
    missing = c.fetchall()
    
    with open(os.path.join(PROJECT_ROOT, "MISSING_API_DATA_ENTRY_REPORT.md"), "w", encoding="utf-8") as f:
        f.write("# Missing API Data Entry Report\n\n")
        f.write(f"Total screens missing API entries: **{len(missing)}**\n\n")
        if missing:
            f.write("| Screen ID | Screen Name | Screen Code |\n")
            f.write("|---|---|---|\n")
            for m in missing:
                f.write(f"| {m['id']} | {m['screen_name']} | `{m['screen_code']}` |\n")
        else:
            f.write("🎉 **All screens have valid API connections and mappings mapped in the database.**\n")

    # 4. API_TEST_GENERATION_REPORT.md
    print("Generating API_TEST_GENERATION_REPORT.md...")
    c.execute("""
        SELECT td.id, td.test_code, td.test_name, td.expected_status_code, a.api_code, a.method, a.endpoint_path
        FROM api_test_definitions td
        JOIN api_registry a ON td.api_id = a.id
        ORDER BY td.id ASC
    """)
    test_defs = c.fetchall()
    
    with open(os.path.join(PROJECT_ROOT, "API_TEST_GENERATION_REPORT.md"), "w", encoding="utf-8") as f:
        f.write("# API Test Generation Report\n\n")
        f.write(f"Total E2E API tests generated from DB: **{len(test_defs)}**\n\n")
        f.write("| Test ID | Test Code | Test Name | Target API | Method | Endpoint Path | Exp. Status |\n")
        f.write("|---|---|---|---|---|---|---|\n")
        for td in test_defs:
            f.write(f"| {td['id']} | `{td['test_code']}` | {td['test_name']} | `{td['api_code']}` | **{td['method']}** | `{td['endpoint_path']}` | {td['expected_status_code']} |\n")

    # 5. API_FAILURE_REPORT.md
    print("Generating API_FAILURE_REPORT.md...")
    c.execute("""
        SELECT tr.id, tr.api_id, a.api_code, tr.run_id, tr.status, tr.status_code, tr.error_message, tr.response_time_ms, tr.created_at
        FROM api_test_results tr
        JOIN api_registry a ON tr.api_id = a.id
        WHERE tr.status = 'failed'
        ORDER BY tr.id DESC
    """)
    failures = c.fetchall()
    
    with open(os.path.join(PROJECT_ROOT, "API_FAILURE_REPORT.md"), "w", encoding="utf-8") as f:
        f.write("# API Failure Report\n\n")
        f.write(f"Total recorded API test failures: **{len(failures)}**\n\n")
        if failures:
            f.write("| Failure ID | API Code | Run ID | Status Code | Error Message | Time (ms) | Created At |\n")
            f.write("|---|---|---|---|---|---|---|\n")
            for fl in failures:
                f.write(f"| {fl['id']} | `{fl['api_code']}` | `{fl['run_id']}` | {fl['status_code']} | `{fl['error_message']}` | {fl['response_time_ms']} | {fl['created_at']} |\n")
        else:
            f.write("🎉 **No API test failures recorded in the database.**\n")

    # 6. SCREEN_API_DEPENDENCY_REPORT.md
    print("Generating SCREEN_API_DEPENDENCY_REPORT.md...")
    c.execute("""
        SELECT s.id AS screen_id, s.screen_code, s.screen_name, r.role_name, a.app_name, 
               (SELECT COUNT(*) FROM screen_api_map WHERE screen_id = s.id) as apis_count,
               (SELECT COUNT(*) FROM screen_api_map sam JOIN api_registry ar ON sam.api_id = ar.id WHERE sam.screen_id = s.id AND ar.status = 'mocked') as mocked_count,
               (SELECT COUNT(*) FROM screen_api_map sam JOIN api_registry ar ON sam.api_id = ar.id WHERE sam.screen_id = s.id AND ar.status = 'tested') as tested_count
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN apps a ON s.app_id = a.id
        ORDER BY s.id ASC
    """)
    dependencies = c.fetchall()
    
    with open(os.path.join(PROJECT_ROOT, "SCREEN_API_DEPENDENCY_REPORT.md"), "w", encoding="utf-8") as f:
        f.write("# Screen API Dependency Report\n\n")
        f.write(f"Total governed screens: **{len(dependencies)}**\n\n")
        f.write("| Screen ID | Screen Name | Screen Code | Role | App | Mapped APIs | Mocked | Tested |\n")
        f.write("|---|---|---|---|---|---|---|---|\n")
        for dep in dependencies:
            f.write(f"| {dep['screen_id']} | {dep['screen_name']} | `{dep['screen_code']}` | {dep['role_name']} | {dep['app_name']} | {dep['apis_count']} | {dep['mocked_count']} | {dep['tested_count']} |\n")

    conn.close()
    print("API REPORTS GENERATION COMPLETE!")
    print("==============================================================")

if __name__ == "__main__":
    main()
