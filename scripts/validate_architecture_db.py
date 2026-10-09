import sqlite3
import os
from api_authority_integrity import assert_api_authority_integrity

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def write_report(filename, lines):
    filepath = os.path.join(PROJECT_ROOT, filename)
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write("\n".join(lines))
    print(f"Generated report: {filename}")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    # Never publish a compliant report from colliding or fabricated API metadata.
    assert_api_authority_integrity(conn)
    c = conn.cursor()

    # Load schemas/tables
    c.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [row['name'] for row in c.fetchall()]

    # 1. ROUTE_REGISTRY_REPORT.md
    c.execute("SELECT * FROM route_registry;")
    routes = c.fetchall()
    route_report = [
        "# Route Registry Report",
        "",
        f"Total Registered Routes: {len(routes)}",
        "",
        "| ID | Route Code | Route Path | Type | Auth Required | Active |",
        "|---|---|---|---|---|---|",
    ]
    for r in routes:
        route_report.append(f"| {r['id']} | `{r['route_code']}` | `{r['route_path']}` | {r['route_type']} | {r['auth_required']} | {r['active']} |")
    write_report("ROUTE_REGISTRY_REPORT.md", route_report)

    # 2. ROUTE_FILE_REGISTRY_REPORT.md
    c.execute("SELECT * FROM route_file_registry;")
    rf = c.fetchall()
    rf_report = [
        "# Route File Registry Report",
        "",
        f"Total Route Files: {len(rf)}",
        "",
        "| ID | File Name | Route Group | Purpose | Active |",
        "|---|---|---|---|---|",
    ]
    for row in rf:
        rf_report.append(f"| {row['id']} | `{row['file_name']}` | {row['route_group']} | {row['purpose']} | {row['active']} |")
    write_report("ROUTE_FILE_REGISTRY_REPORT.md", rf_report)

    # 3. API_ENDPOINT_REGISTRY_REPORT.md
    c.execute("SELECT * FROM api_endpoint_registry;")
    endpoints = c.fetchall()
    ep_report = [
        "# API Endpoint Registry Report",
        "",
        f"Total Endpoints: {len(endpoints)}",
        "",
        "| ID | Endpoint Code | Method | Path | Status |",
        "|---|---|---|---|---|",
    ]
    for ep in endpoints:
        ep_report.append(f"| {ep['id']} | `{ep['endpoint_code']}` | {ep['method']} | `{ep['endpoint_path']}` | {ep['status']} |")
    write_report("API_ENDPOINT_REGISTRY_REPORT.md", ep_report)

    # 4. API_FILE_REGISTRY_REPORT.md
    c.execute("SELECT * FROM api_file_registry;")
    apifiles = c.fetchall()
    af_report = [
        "# API File Registry Report",
        "",
        f"Total API Files: {len(apifiles)}",
        "",
        "| ID | File Name | Type | Purpose | Status |",
        "|---|---|---|---|---|",
    ]
    for af in apifiles:
        af_report.append(f"| {af['id']} | `{af['file_name']}` | {af['file_type']} | {af['purpose']} | {af['implementation_status']} |")
    write_report("API_FILE_REGISTRY_REPORT.md", af_report)

    # 5. PROJECT_FOLDER_REGISTRY_REPORT.md
    c.execute("SELECT * FROM project_folder_registry;")
    folders = c.fetchall()
    f_report = [
        "# Project Folder Registry Report",
        "",
        f"Total Registered Folders: {len(folders)}",
        "",
        "| ID | Folder Type | Folder Path | Purpose | Required |",
        "|---|---|---|---|---|",
    ]
    for row in folders:
        f_report.append(f"| {row['id']} | `{row['folder_type']}` | `{row['folder_path']}` | {row['purpose']} | {row['required']} |")
    write_report("PROJECT_FOLDER_REGISTRY_REPORT.md", f_report)

    # 6. PROJECT_FILE_REGISTRY_REPORT.md
    c.execute("SELECT * FROM project_file_registry;")
    files = c.fetchall()
    pfr_report = [
        "# Project File Registry Report",
        "",
        f"Total Registered Files: {len(files)}",
        "",
        "| ID | File Code | File Name | File Type | Status |",
        "|---|---|---|---|---|",
    ]
    for row in files:
        pfr_report.append(f"| {row['id']} | `{row['file_code']}` | `{row['file_name']}` | {row['file_type']} | {row['implementation_status']} |")
    write_report("PROJECT_FILE_REGISTRY_REPORT.md", pfr_report)

    # 7. FILE_DEPENDENCY_MAP_REPORT.md
    c.execute("SELECT * FROM project_file_dependencies;")
    deps = c.fetchall()
    fd_report = [
        "# File Dependency Map Report",
        "",
        f"Total Dependencies Mapped: {len(deps)}",
        "",
        "| ID | File ID | Depends On File ID | Dependency Type |",
        "|---|---|---|---|",
    ]
    for row in deps:
        fd_report.append(f"| {row['id']} | {row['file_id']} | {row['depends_on_file_id']} | {row['dependency_type']} |")
    write_report("FILE_DEPENDENCY_MAP_REPORT.md", fd_report)

    # 8. SCREEN_ENDPOINT_MAP_REPORT.md
    c.execute("SELECT * FROM screen_endpoint_map;")
    sem = c.fetchall()
    se_report = [
        "# Screen Endpoint Map Report",
        "",
        f"Total Mappings: {len(sem)}",
        "",
        "| ID | Screen ID | Endpoint ID | Section ID | Usage Type | Required |",
        "|---|---|---|---|---|---|",
    ]
    for row in sem:
        se_report.append(f"| {row['id']} | {row['screen_id']} | {row['endpoint_id']} | {row['section_id']} | {row['usage_type']} | {row['required']} |")
    write_report("SCREEN_ENDPOINT_MAP_REPORT.md", se_report)

    # 9. SIDEBAR_ROUTE_MAP_REPORT.md
    c.execute("SELECT * FROM sidebar_route_map;")
    srm = c.fetchall()
    sr_report = [
        "# Sidebar Route Map Report",
        "",
        f"Total Mappings: {len(srm)}",
        "",
        "| ID | Sidebar Item ID | Route ID | Role ID | Screen ID | Active |",
        "|---|---|---|---|---|---|",
    ]
    for row in srm:
        sr_report.append(f"| {row['id']} | {row['sidebar_item_id']} | {row['route_id']} | {row['role_id']} | {row['screen_id']} | {row['active']} |")
    write_report("SIDEBAR_ROUTE_MAP_REPORT.md", sr_report)

    # 10. TOPBAR_ACTION_MAP_REPORT.md
    c.execute("SELECT * FROM topbar_action_map;")
    tam = c.fetchall()
    ta_report = [
        "# Topbar Action Map Report",
        "",
        f"Total Mappings: {len(tam)}",
        "",
        "| ID | Topbar Item ID | Feature ID | API ID | Route ID | Action Type |",
        "|---|---|---|---|---|---|",
    ]
    for row in tam:
        ta_report.append(f"| {row['id']} | {row['topbar_item_id']} | {row['feature_id']} | {row['api_id']} | {row['route_id']} | {row['action_type']} |")
    write_report("TOPBAR_ACTION_MAP_REPORT.md", ta_report)

    # 11. MISSING_ARCHITECTURE_PARTS_REPORT.md
    # Validation Queries
    missing_report = [
        "# Missing Architecture Parts and Validation Report",
        "",
    ]

    # Rule 1: Roles with screens but no sidebar links
    c.execute("""
        SELECT DISTINCT role_id FROM screens 
        WHERE active = 1 AND id NOT IN (SELECT DISTINCT screen_id FROM sidebar_items);
    """)
    no_sidebar = c.fetchall()
    missing_report.append("## Roles / Screens with No Sidebar Links")
    if no_sidebar:
        missing_report.append("| Screen ID |")
        missing_report.append("|---|")
        for row in no_sidebar:
            missing_report.append(f"| {row['role_id']} |")
    else:
        missing_report.append("*None. All active role screens have corresponding sidebar entries.*")
    missing_report.append("")

    # Rule 2: Sidebar links with invalid routes (route_path not starting with '/' or not in screens)
    c.execute("""
        SELECT id, sidebar_label, route_path FROM sidebar_items
        WHERE route_path NOT LIKE '/%' OR route_path NOT IN (SELECT route_path FROM screens);
    """)
    invalid_routes = c.fetchall()
    missing_report.append("## Sidebar Links with Invalid Routes")
    if invalid_routes:
        missing_report.append("| ID | Sidebar Label | Route Path |")
        missing_report.append("|---|---|---|")
        for row in invalid_routes:
            missing_report.append(f"| {row['id']} | {row['sidebar_label']} | `{row['route_path']}` |")
    else:
        missing_report.append("*None. All sidebar items have valid paths matching registered screens.*")
    missing_report.append("")

    # Rule 3: Sidebar labels using raw class names
    c.execute("""
        SELECT id, sidebar_label FROM sidebar_items
        WHERE sidebar_label LIKE 'Psw%' OR sidebar_label LIKE 'Clinic%' OR sidebar_label LIKE 'Corporate%';
    """)
    raw_class_names = c.fetchall()
    missing_report.append("## Sidebar Labels Using Raw Class Names")
    if raw_class_names:
        missing_report.append("| ID | Sidebar Label |")
        missing_report.append("|---|---|")
        for row in raw_class_names:
            missing_report.append(f"| {row['id']} | {row['sidebar_label']} |")
    else:
        missing_report.append("*None. All sidebar labels are formatted as human-readable names.*")
    missing_report.append("")

    # Rule 4: Topbars missing logout or profile links
    c.execute("""
        SELECT DISTINCT app_id, role_id FROM topbar_items
        EXCEPT
        SELECT DISTINCT app_id, role_id FROM topbar_items WHERE item_code IN ('logout', 'profile_menu');
    """)
    missing_topbar_items = c.fetchall()
    missing_report.append("## Topbars Missing Logout or Profile Menu")
    if missing_topbar_items:
        missing_report.append("| App ID | Role ID |")
        missing_report.append("|---|---|")
        for row in missing_topbar_items:
            missing_report.append(f"| {row['app_id']} | {row['role_id']} |")
    else:
        missing_report.append("*None. All role/app topbars have logout and profile menu options.*")
    missing_report.append("")

    # Rule 5: Screens missing layout registry
    c.execute("""
        SELECT id, screen_name FROM screens
        WHERE id NOT IN (SELECT screen_id FROM screen_layout_registry);
    """)
    missing_layout = c.fetchall()
    missing_report.append("## Screens Missing Layout Registry")
    if missing_layout:
        missing_report.append("| Screen ID | Screen Name |")
        missing_report.append("|---|---|")
        for row in missing_layout:
            missing_report.append(f"| {row['id']} | {row['screen_name']} |")
    else:
        missing_report.append("*None. All screens have layout registrations.*")
    missing_report.append("")

    write_report("MISSING_ARCHITECTURE_PARTS_REPORT.md", missing_report)

    # 12. MISSING_APP_ARCHITECTURE_PARTS_REPORT.md
    target_tables = [
        ("Sidebar items", "sidebar_items"),
        ("Forms", "forms"),
        ("Form fields", "form_fields"),
        ("API request schemas", "api_request_schemas"),
        ("API response schemas", "api_response_schemas"),
        ("API permissions", "api_permissions"),
        ("API services", "api_services"),
        ("API controllers", "api_controllers"),
        ("Workflow definitions", "workflow_definitions"),
        ("Workflow steps", "workflow_steps"),
        ("Layout behavior profiles", "layout_behavior_profiles"),
        ("Manual verification checks", "manual_verification_checks"),
        ("Release gates", "release_gates"),
        ("Deployment records", "deployments"),
        ("Performance metrics", "performance_metrics"),
        ("Security findings", "security_findings"),
        ("User sessions", "user_sessions"),
        ("Runtime logs", "runtime_logs"),
        ("Health checks", "health_checks")
    ]
    
    app_report = [
        "# Missing App Architecture Parts Report",
        "",
        "This report audits the status of critical application components in the governance database.",
        "",
        "| App part | Row Count | Status |",
        "|---|---|---|",
    ]
    for label, table in target_tables:
        c.execute(f"SELECT COUNT(*) FROM {table};")
        cnt = c.fetchone()[0]
        status = "✅ Populated" if cnt > 0 else "❌ Empty / Missing"
        app_report.append(f"| {label} | **{cnt}** | {status} |")
        
    write_report("MISSING_APP_ARCHITECTURE_PARTS_REPORT.md", app_report)

    conn.close()

if __name__ == "__main__":
    main()
