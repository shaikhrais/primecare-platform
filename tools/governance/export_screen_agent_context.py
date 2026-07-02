import sqlite3
import json
import os
import sys

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
OUTPUT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\screen_agent_context"

def export_context(screen_code):
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    # 1. Fetch screen info
    cur.execute("SELECT * FROM screens WHERE screen_code = ? AND active = 1;", (screen_code,))
    screen_row = cur.fetchone()
    if not screen_row:
        print(f"Error: Screen '{screen_code}' not found or is inactive in database.")
        conn.close()
        return False
        
    screen_data = dict(screen_row)
    screen_id = screen_data['id']
    app_id = screen_data['app_id']
    role_id = screen_data['role_id']

    # 2. Fetch App info
    cur.execute("SELECT * FROM apps WHERE id = ?;", (app_id,))
    app_row = cur.fetchone()
    app_data = dict(app_row) if app_row else {}

    # 3. Fetch Role info
    cur.execute("SELECT * FROM roles WHERE id = ?;", (role_id,))
    role_row = cur.fetchone()
    role_data = dict(role_row) if role_row else {}

    # 4. Fetch Requirements
    cur.execute("SELECT * FROM screen_requirements WHERE screen_id = ?;", (screen_id,))
    req_rows = cur.fetchall()
    requirements = [dict(r) for r in req_rows]

    # 5. Fetch Implementation Blueprint
    cur.execute("SELECT * FROM screen_implementation_blueprints WHERE screen_id = ?;", (screen_id,))
    bp_row = cur.fetchone()
    blueprint = dict(bp_row) if bp_row else {}

    # 6. Fetch Sections and their Functional Descriptions
    sections = []
    cur.execute("SELECT * FROM screen_sections WHERE screen_id = ? ORDER BY section_order ASC;", (screen_id,))
    sec_rows = cur.fetchall()
    for s_row in sec_rows:
        sec = dict(s_row)
        sec_id = sec['id']
        
        # Fetch description
        cur.execute("SELECT * FROM section_function_descriptions WHERE section_id = ?;", (sec_id,))
        desc_row = cur.fetchone()
        sec['description'] = dict(desc_row) if desc_row else {}
        
        # Fetch elements for this section
        elements = []
        cur.execute("SELECT * FROM screen_section_elements WHERE section_id = ? ORDER BY element_order ASC;", (sec_id,))
        el_rows = cur.fetchall()
        for e_row in el_rows:
            el = dict(e_row)
            el_id = el['id']
            
            # Fetch element description
            cur.execute("SELECT * FROM element_function_descriptions WHERE element_id = ?;", (el_id,))
            el_desc_row = cur.fetchone()
            el['description'] = dict(el_desc_row) if el_desc_row else {}
            
            # Fetch button action definition if applicable
            cur.execute("SELECT * FROM button_action_definitions WHERE element_id = ?;", (el_id,))
            btn_row = cur.fetchone()
            el['button_action'] = dict(btn_row) if btn_row else {}
            
            elements.append(el)
            
        sec['elements'] = elements
        sections.append(sec)

    # 7. Fetch APIs and their Usage Blueprints
    apis = []
    cur.execute("""
        SELECT m.api_id, r.api_code, r.api_name, r.endpoint_path, r.method
        FROM screen_api_map m
        JOIN api_registry r ON m.api_id = r.id
        WHERE m.screen_id = ?;
    """, (screen_id,))
    api_rows = cur.fetchall()
    for a_row in api_rows:
        api = dict(a_row)
        api_id = api['api_id']
        
        # Fetch API blueprint
        cur.execute("SELECT * FROM api_usage_blueprints WHERE api_id = ?;", (api_id,))
        ab_row = cur.fetchone()
        api['blueprint'] = dict(ab_row) if ab_row else {}
        apis.append(api)

    # 8. Fetch Implementation Tasks
    cur.execute("SELECT * FROM screen_implementation_tasks WHERE screen_id = ? ORDER BY task_order ASC;", (screen_id,))
    task_rows = cur.fetchall()
    tasks = [dict(t) for t in task_rows]

    # 9. Fetch E2E Cypress Tests & Steps
    tests = []
    cur.execute("SELECT * FROM screen_test_definitions WHERE screen_id = ? AND enabled = 1;", (screen_id,))
    test_rows = cur.fetchall()
    for t_row in test_rows:
        test = dict(t_row)
        t_def_id = test['id']
        
        # Fetch steps
        cur.execute("SELECT * FROM screen_test_steps WHERE test_definition_id = ? ORDER BY step_order ASC;", (t_def_id,))
        step_rows = cur.fetchall()
        test['steps'] = [dict(step) for step in step_rows]
        tests.append(test)

    # Compile the final context JSON structure
    context = {
        "screen_code": screen_code,
        "app": app_data,
        "role": role_data,
        "screen": screen_data,
        "requirements": requirements,
        "blueprint": blueprint,
        "sections": sections,
        "apis": apis,
        "implementation_tasks": tasks,
        "tests": tests
    }

    # Save to JSON
    output_path = os.path.join(OUTPUT_DIR, f"{screen_code}.json")
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(context, f, indent=2)
        
    print(f"Successfully exported AI Agent context for screen '{screen_code}' to:")
    print(f"  {output_path}")
    conn.close()
    return True

if __name__ == "__main__":
    if len(sys.argv) > 1:
        export_context(sys.argv[1])
    else:
        # Default to psw_dashboard for verification
        export_context("psw_dashboard")
