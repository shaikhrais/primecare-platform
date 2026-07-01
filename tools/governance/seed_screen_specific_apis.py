import os
import sqlite3
import json
import re

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def classify_api_need(screen_name, screen_code, route_path, app_name, role_name, req_str, elements_str, comps_str):
    all_text = f"{screen_name} {screen_code} {route_path} {app_name} {role_name} {req_str} {elements_str} {comps_str}".lower()
    
    # Category A: No API needed
    static_keywords = [
        "help", "about", "terms", "privacy", "policy", "doc", "documentation",
        "faq", "guide", "legal", "instruction", "manual", "copyright", "disclaimer",
        "static", "lorem", "sample"
    ]
    if any(k in all_text for k in static_keywords) and not any(k in all_text for k in ["dashboard", "list", "manage", "admin", "create", "edit", "submit", "form", "notes"]):
        return "no_api_required"
        
    # Category D: Full CRUD
    crud_keywords = [
        "crud", "admin registry", "user management", "inventory management",
        "risk register", "employee management", "system admin", "configuration manager",
        "superadmin", "database expansion", "audit logs control"
    ]
    if any(k in all_text for k in crud_keywords):
        return "full_crud_api"
        
    # Category C: Read + Write
    write_keywords = [
        "create", "add", "new", "edit", "update", "notes", "intake", "entry",
        "form", "submit", "request", "save", "input", "post", "apply", "register",
        "upload", "schedule appointment", "consent", "feedback", "post-notes"
    ]
    if any(k in all_text for k in write_keywords):
        return "read_write_api"
        
    # Category B: Read-only
    return "read_only_api"

def infer_resource_info(screen_code):
    parts = screen_code.split('_')
    filtered = [p for p in parts if p not in ['screen', 'dashboard', 'list', 'form', 'view', 'edit', 'create', 'update', 'delete', 'add', 'new', 'search', 'overview']]
    if not filtered:
        return "resource", "resource", "Resource"
    
    resource_path = "-".join(filtered)
    resource_underscore = "_".join(filtered)
    resource_name = " ".join(p.capitalize() for p in filtered)
    
    # Pluralize common resource names
    if resource_path in ["patient", "user", "client", "employee", "report", "caregiver", "note", "task", "member", "partner", "lead", "incident"]:
        resource_path += "s"
        resource_underscore += "s"
        resource_name += "s"
        
    return resource_path, resource_underscore, resource_name

def main():
    print("==============================================================")
    print("RUNNING SYSTEMATIC DETAILED SCREEN-SPECIFIC API SEEDER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Load all active screens with metadata
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, r.role_code, r.role_name, a.app_code, a.app_name
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN apps a ON s.app_id = a.id
        WHERE s.active = 1
        ORDER BY s.id ASC
    """)
    screens = c.fetchall()
    print(f"Loaded {len(screens)} screens to seed.")

    # Clear previous mappings and test definitions to avoid clashes/stale mappings
    c.execute("DELETE FROM screen_api_map")
    c.execute("DELETE FROM api_test_definitions")
    c.execute("DELETE FROM api_registry")
    c.execute("DELETE FROM api_test_results")
    print("Cleared existing api_registry, screen_api_map, api_test_definitions, and api_test_results for fresh data entry.")

    api_count = 0
    mapping_count = 0
    test_count = 0

    for s in screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        route_path = s["route_path"]
        role_code = s["role_code"] or "guest"
        role_name = s["role_name"] or "Guest"
        app_code = s["app_code"] or "common"
        app_name = s["app_name"] or "Common"

        # Fetch metadata
        c.execute("SELECT business_purpose, user_story, acceptance_criteria FROM screen_requirements WHERE screen_id = ?", (screen_id,))
        req = c.fetchone()
        req_str = f"{req['business_purpose']} {req['user_story']} {req['acceptance_criteria']}" if req else ""

        c.execute("SELECT element_key, label FROM screen_required_elements WHERE screen_id = ?", (screen_id,))
        elements = c.fetchall()
        elements_str = " ".join([f"{e['element_key']} {e['label']}" for e in elements])

        c.execute("SELECT component_id FROM screen_component_map WHERE screen_id = ?", (screen_id,))
        comps = c.fetchall()
        comps_str = " ".join([str(comp["component_id"]) for comp in comps])

        # Classify screen
        api_need = classify_api_need(screen_name, screen_code, route_path, app_name, role_name, req_str, elements_str, comps_str)
        if api_need == "no_api_required":
            continue

        resource_path, resource_underscore, resource_name = infer_resource_info(screen_code)

        # Define the set of APIs to generate based on classification
        apis_to_generate = []

        # Read-Only APIs (Category B)
        if api_need in ["read_only_api", "read_write_api", "full_crud_api"]:
            apis_to_generate.append({
                "api_code": f"api_v1_{resource_underscore}_list_get",
                "api_name": f"Load {resource_name} List Data",
                "method": "GET",
                "endpoint_path": f"/v1/{resource_path}",
                "request_schema": '{"type": "object", "properties": {}}',
                "response_schema": f'{{"type": "object", "properties": {{"status": {{"type": "string"}}, "data": {{"type": "array", "items": {{"type": "object", "properties": {{"id": {{"type": "string"}}, "name": {{"type": "string"}}, "status": {{"type": "string"}}}}}}}}}}}}',
                "usage": "load_list"
            })

        # Read/Write APIs (Category C)
        if api_need in ["read_write_api", "full_crud_api"]:
            apis_to_generate.append({
                "api_code": f"api_v1_{resource_underscore}_create_post",
                "api_name": f"Create New {resource_name} Record",
                "method": "POST",
                "endpoint_path": f"/v1/{resource_path}",
                "request_schema": '{"type": "object", "required": ["title", "notes"], "properties": {"title": {"type": "string"}, "notes": {"type": "string"}, "metadata": {"type": "object"}}}',
                "response_schema": '{"type": "object", "properties": {"status": {"type": "string"}, "id": {"type": "string"}, "message": {"type": "string"}}}',
                "usage": "create_record"
            })
            apis_to_generate.append({
                "api_code": f"api_v1_{resource_underscore}_update_patch",
                "api_name": f"Update Existing {resource_name} Record",
                "method": "PATCH",
                "endpoint_path": f"/v1/{resource_path}/:id",
                "request_schema": '{"type": "object", "properties": {"title": {"type": "string"}, "notes": {"type": "string"}}}',
                "response_schema": '{"type": "object", "properties": {"status": {"type": "string"}, "message": {"type": "string"}}}',
                "usage": "update_record"
            })

        # Full CRUD APIs (Category D)
        if api_need == "full_crud_api":
            apis_to_generate.append({
                "api_code": f"api_v1_{resource_underscore}_detail_get",
                "api_name": f"Load Single {resource_name} Details",
                "method": "GET",
                "endpoint_path": f"/v1/{resource_path}/:id",
                "request_schema": '{"type": "object", "properties": {}}',
                "response_schema": '{"type": "object", "properties": {"status": {"type": "string"}, "data": {"type": "object"}}}',
                "usage": "load_details"
            })
            apis_to_generate.append({
                "api_code": f"api_v1_{resource_underscore}_delete_delete",
                "api_name": f"Delete {resource_name} Record",
                "method": "DELETE",
                "endpoint_path": f"/v1/{resource_path}/:id",
                "request_schema": '{"type": "object", "properties": {}}',
                "response_schema": '{"type": "object", "properties": {"status": {"type": "string"}, "message": {"type": "string"}}}',
                "usage": "delete_record"
            })

        # Insert and Map
        for api in apis_to_generate:
            # Check if API code already exists to avoid duplicates (multiple screens can use the same API code)
            c.execute("SELECT id FROM api_registry WHERE api_code = ?", (api["api_code"],))
            api_row = c.fetchone()
            if not api_row:
                c.execute("""
                    INSERT INTO api_registry (api_code, api_name, method, endpoint_path, request_schema_json, response_schema_json, auth_required, role_required, status)
                    VALUES (?, ?, ?, ?, ?, ?, 1, ?, 'mocked')
                """, (api["api_code"], api["api_name"], api["method"], api["endpoint_path"], api["request_schema"], api["response_schema"], role_code))
                api_id = c.lastrowid
                api_count += 1
            else:
                api_id = api_row["id"]

            # Insert screen mapping
            c.execute("""
                INSERT INTO screen_api_map (screen_id, api_id, api_usage, required)
                VALUES (?, ?, ?, 1)
            """, (screen_id, api_id, api["usage"]))
            mapping_count += 1

            # Seed E2E API Test Definition
            test_code = f"test_{api['api_code']}"
            c.execute("SELECT id FROM api_test_definitions WHERE test_code = ?", (test_code,))
            if not c.fetchone():
                c.execute("""
                    INSERT INTO api_test_definitions (api_id, test_code, test_name, expected_status_code, expected_response_keys_json, enabled)
                    VALUES (?, ?, ?, 200, '["status"]', 1)
                """, (api_id, test_code, f"Verify {api['api_name']} returns success",))
                test_count += 1

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("API DATA SEEDING COMPLETE!")
    print(f"  - Total Unique APIs Seeded: {api_count}")
    print(f"  - Total Screen-API Mappings Created: {mapping_count}")
    print(f"  - Total API Test Definitions Seeded: {test_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
