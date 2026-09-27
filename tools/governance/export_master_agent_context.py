import sqlite3
import json
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
OUTPUT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\agent_context"

def make_dirs():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    os.makedirs(os.path.join(OUTPUT_DIR, "apps"), exist_ok=True)
    os.makedirs(os.path.join(OUTPUT_DIR, "roles"), exist_ok=True)
    os.makedirs(os.path.join(OUTPUT_DIR, "screens"), exist_ok=True)

def main():
    make_dirs()
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # 1. Fetch apps, roles, screens
    cur.execute("SELECT * FROM apps;")
    apps = [dict(row) for row in cur.fetchall()]

    cur.execute("SELECT * FROM roles;")
    roles = [dict(row) for row in cur.fetchall()]

    cur.execute("SELECT * FROM screens;")
    screens = [dict(row) for row in cur.fetchall()]

    # Index lookups
    apps_by_id = {app['id']: app for app in apps}
    roles_by_id = {role['id']: role for role in roles}

    # Fetch mapping counts or maps
    cur.execute("SELECT * FROM role_screen_map;")
    rsm_list = [dict(row) for row in cur.fetchall()]

    cur.execute("SELECT * FROM api_registry;")
    apis = [dict(row) for row in cur.fetchall()]

    # Save Master JSON Context
    master_context = {
        "apps_count": len(apps),
        "roles_count": len(roles),
        "screens_count": len(screens),
        "apis_count": len(apis),
        "apps": apps,
        "roles": roles,
        "screens_summary": [
            {
                "id": s["id"],
                "screen_code": s["screen_code"],
                "screen_name": s["screen_name"],
                "route_path": s["route_path"],
                "app_code": apps_by_id.get(s["app_id"], {}).get("app_code", ""),
                "role_code": roles_by_id.get(s["role_id"], {}).get("role_code", "")
            }
            for s in screens
        ]
    }

    with open(os.path.join(OUTPUT_DIR, "master_platform_context.json"), "w", encoding="utf-8") as f:
        json.dump(master_context, f, indent=2)

    # Save Master MD Context
    with open(os.path.join(OUTPUT_DIR, "master_platform_context.md"), "w", encoding="utf-8") as f:
        f.write("# Master Platform Governance Context\n\n")
        f.write(f"- **Apps Count:** {len(apps)}\n")
        f.write(f"- **Roles Count:** {len(roles)}\n")
        f.write(f"- **Screens Count:** {len(screens)}\n")
        f.write(f"- **APIs Count:** {len(apis)}\n\n")
        f.write("## Registered Apps\n")
        for app in apps:
            f.write(f"- **{app['app_name']}** ({app['app_code']})\n")
        f.write("\n## Registered Roles\n")
        for role in roles:
            f.write(f"- **{role['role_name']}** ({role['role_code']})\n")

    # Export App Contexts
    for app in apps:
        app_code = app["app_code"]
        app_screens = [s for s in screens if s["app_id"] == app["id"]]
        app_ctx = {
            "app": app,
            "screens_count": len(app_screens),
            "screens": app_screens
        }
        with open(os.path.join(OUTPUT_DIR, "apps", f"{app_code}_context.json"), "w", encoding="utf-8") as f:
            json.dump(app_ctx, f, indent=2)

        with open(os.path.join(OUTPUT_DIR, "apps", f"{app_code}_context.md"), "w", encoding="utf-8") as f:
            f.write(f"# App Context: {app['app_name']} ({app_code})\n\n")
            f.write(f"- **Description:** {app.get('description', '')}\n")
            f.write(f"- **Screens Count:** {len(app_screens)}\n\n")
            f.write("## Screens:\n")
            for s in app_screens:
                f.write(f"- **{s['screen_name']}** ({s['screen_code']}) - Route: `{s['route_path']}`\n")

    # Export Role Contexts
    for role in roles:
        role_code = role["role_code"]
        role_screen_ids = [rsm["screen_id"] for rsm in rsm_list if rsm["role_id"] == role["id"]]
        role_screens = [s for s in screens if s["id"] in role_screen_ids]
        role_ctx = {
            "role": role,
            "screens_count": len(role_screens),
            "screens": role_screens
        }
        with open(os.path.join(OUTPUT_DIR, "roles", f"{role_code}_context.json"), "w", encoding="utf-8") as f:
            json.dump(role_ctx, f, indent=2)

        with open(os.path.join(OUTPUT_DIR, "roles", f"{role_code}_context.md"), "w", encoding="utf-8") as f:
            f.write(f"# Role Context: {role['role_name']} ({role_code})\n\n")
            f.write(f"- **Role Code:** `{role_code}`\n")
            f.write(f"- **Screens Count:** {len(role_screens)}\n\n")
            f.write("## Authorized Screens:\n")
            for s in role_screens:
                f.write(f"- **{s['screen_name']}** ({s['screen_code']}) - Route: `{s['route_path']}`\n")

    # Export Screen Contexts (Batch optimize query to avoid 948 separate DB roundtrips if possible, but let's query carefully)
    print("Exporting 948 screen contexts...")
    
    # Pre-fetch all sections
    cur.execute("SELECT * FROM screen_sections;")
    all_sections = [dict(row) for row in cur.fetchall()]
    sections_by_screen = {}
    for sec in all_sections:
        sections_by_screen.setdefault(sec['screen_id'], []).append(sec)

    # Pre-fetch all elements
    cur.execute("SELECT * FROM screen_section_elements;")
    all_elements = [dict(row) for row in cur.fetchall()]
    elements_by_section = {}
    for el in all_elements:
        elements_by_section.setdefault(el['section_id'], []).append(el)

    # Pre-fetch all button action definitions
    cur.execute("SELECT * FROM button_action_definitions;")
    all_buttons = [dict(row) for row in cur.fetchall()]
    buttons_by_element = {b['element_id']: b for b in all_buttons}

    # Pre-fetch test definitions
    cur.execute("SELECT * FROM screen_test_definitions;")
    all_tests = [dict(row) for row in cur.fetchall()]
    tests_by_screen = {}
    for test in all_tests:
        tests_by_screen.setdefault(test['screen_id'], []).append(test)

    # Pre-fetch test steps
    cur.execute("SELECT * FROM screen_test_steps;")
    all_steps = [dict(row) for row in cur.fetchall()]
    steps_by_test = {}
    for step in all_steps:
        steps_by_test.setdefault(step['test_definition_id'], []).append(step)

    # Pre-fetch screen requirements
    cur.execute("SELECT * FROM screen_requirements;")
    all_reqs = [dict(row) for row in cur.fetchall()]
    reqs_by_screen = {}
    for req in all_reqs:
        reqs_by_screen.setdefault(req['screen_id'], []).append(req)

    # Pre-fetch screen blueprints
    cur.execute("SELECT * FROM screen_implementation_blueprints;")
    all_bps = [dict(row) for row in cur.fetchall()]
    bps_by_screen = {bp['screen_id']: bp for bp in all_bps}

    # Pre-fetch API screen mappings
    cur.execute("SELECT * FROM screen_api_map;")
    api_mappings = [dict(row) for row in cur.fetchall()]
    apis_by_screen = {}
    for mapping in api_mappings:
        apis_by_screen.setdefault(mapping['screen_id'], []).append(mapping['api_id'])

    api_registry_by_id = {api['id']: api for api in apis}

    for s in screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        
        # Assemble sections and elements
        sections = []
        for sec in sections_by_screen.get(screen_id, []):
            sec_copy = sec.copy()
            elements = []
            for el in elements_by_section.get(sec['id'], []):
                el_copy = el.copy()
                el_copy['button_action'] = buttons_by_element.get(el['id'], {})
                elements.append(el_copy)
            sec_copy['elements'] = elements
            sections.append(sec_copy)

        # Assemble APIs
        screen_apis = []
        for api_id in apis_by_screen.get(screen_id, []):
            if api_id in api_registry_by_id:
                screen_apis.append(api_registry_by_id[api_id])

        # Assemble Tests
        tests = []
        for test in tests_by_screen.get(screen_id, []):
            test_copy = test.copy()
            test_copy['steps'] = steps_by_test.get(test['id'], [])
            tests.append(test_copy)

        # Final screen context
        screen_ctx = {
            "screen_code": screen_code,
            "app": apps_by_id.get(s["app_id"], {}),
            "role": roles_by_id.get(s["role_id"], {}),
            "screen": s,
            "requirements": reqs_by_screen.get(screen_id, []),
            "blueprint": bps_by_screen.get(screen_id, {}),
            "sections": sections,
            "apis": screen_apis,
            "tests": tests
        }

        # Write JSON
        with open(os.path.join(OUTPUT_DIR, "screens", f"{screen_code}_context.json"), "w", encoding="utf-8") as f:
            json.dump(screen_ctx, f, indent=2)

        # Write Markdown
        with open(os.path.join(OUTPUT_DIR, "screens", f"{screen_code}_context.md"), "w", encoding="utf-8") as f:
            f.write(f"# Screen Context: {s['screen_name']} ({screen_code})\n\n")
            f.write(f"- **Route Path:** `{s['route_path']}`\n")
            f.write(f"- **App Group:** `{apps_by_id.get(s['app_id'], {}).get('app_name', '')}`\n")
            f.write(f"- **Role Group:** `{roles_by_id.get(s['role_id'], {}).get('role_name', '')}`\n\n")
            f.write("## Sections & Elements:\n")
            for sec in sections:
                f.write(f"### Section: {sec['section_name']} (`{sec['section_code']}`)\n")
                for el in sec['elements']:
                    f.write(f"- Element: **{el['label']}** ({el['element_type']}) - Test ID: `{el['test_id']}`\n")

    conn.close()
    print("Master Agent Context Export Complete!")

if __name__ == "__main__":
    main()
