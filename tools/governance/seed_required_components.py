import os
import re
import json
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def guess_component_type(name):
    name_lower = name.lower()
    if "button" in name_lower or "btn" in name_lower:
        return "button"
    elif "field" in name_lower or "input" in name_lower or "text" in name_lower:
        return "field"
    elif "chart" in name_lower or "graph" in name_lower or "plot" in name_lower:
        return "chart"
    elif "list" in name_lower or "view" in name_lower or "scroll" in name_lower:
        return "list"
    elif "loading" in name_lower or "progress" in name_lower or "spinner" in name_lower:
        return "loading"
    elif "error" in name_lower or "fail" in name_lower:
        return "error"
    elif "success" in name_lower or "ok" in name_lower:
        return "success"
    elif "modal" in name_lower or "dialog" in name_lower or "popup" in name_lower:
        return "modal"
    elif "table" in name_lower or "grid" in name_lower:
        return "table"
    elif "card" in name_lower or "panel" in name_lower or "tile" in name_lower:
        return "card"
    return "custom"

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: COMPONENT SEED & IMPLEMENTATION CHECKER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Get all screens with paths and requirements
    screens = cur.execute("""
        SELECT id, app_id, screen_code, screen_name, actual_file_path, expected_file_path, required_components_json
        FROM screens
    """).fetchall()

    print(f"Loaded {len(screens)} screens to scan components.")

    inserted_count = 0
    implemented_count = 0
    planned_count = 0

    for idx, screen in enumerate(screens, 1):
        screen_id = screen["id"]
        app_id = screen["app_id"]
        screen_code = screen["screen_code"]
        screen_name = screen["screen_name"]
        req_components_json = screen["required_components_json"]

        if not req_components_json:
            continue

        try:
            req_components = json.loads(req_components_json)
        except Exception:
            continue

        if not isinstance(req_components, list) or not req_components:
            continue

        # Load file content if available
        file_path = None
        for path_field in ["actual_file_path", "expected_file_path"]:
            if screen[path_field]:
                potential_path = os.path.join(PROJECT_ROOT, screen[path_field])
                if os.path.exists(potential_path):
                    file_path = potential_path
                    break

        code_content = ""
        if file_path:
            try:
                with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                    code_content = f.read()
            except Exception as e:
                print(f"  Error reading file {file_path}: {e}")

        for comp in req_components:
            # Clean up component code
            comp_clean = re.sub(r'[^a-zA-Z0-9_]', '', comp)
            comp_code = f"{screen_code}_{comp_clean.lower()}"
            comp_type = guess_component_type(comp)

            # Check if component is in code
            is_implemented = False
            if code_content:
                # 1. Look for getters declaration in screen classes
                # get requiredComponents => const [... 'EmailInputField' ...]
                # 2. Or physically typed in class file
                if re.search(rf"\b{comp}\b", code_content):
                    is_implemented = True

            status = "implemented" if is_implemented else "planned"
            if is_implemented:
                implemented_count += 1
            else:
                planned_count += 1

            expected_behavior = f"The {comp} widget must render and be functional on the {screen_name}."

            try:
                # Insert or replace to update the component status dynamically
                cur.execute("""
                    INSERT INTO ui_components (
                        app_id, screen_id, component_code, component_name, component_type,
                        expected_behavior, is_interactive, is_required, component_status
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ON CONFLICT(screen_id, component_code) DO UPDATE SET
                        component_status = excluded.component_status,
                        component_type = excluded.component_type,
                        expected_behavior = excluded.expected_behavior;
                """, (
                    app_id,
                    screen_id,
                    comp_code,
                    comp,
                    comp_type,
                    expected_behavior,
                    1 if comp_type in ("button", "field", "modal") else 0,
                    1,
                    status
                ))
                inserted_count += 1
            except Exception as e:
                print(f"  Error inserting component '{comp}' for screen '{screen_code}': {e}")

    conn.commit()
    conn.close()

    print("==============================================================")
    print(f"Total components populated/updated in database: {inserted_count}")
    print(f"  - Implemented components: {implemented_count}")
    print(f"  - Planned (missing from code) components: {planned_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
