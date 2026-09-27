import os
import json
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DESCRIPTIONS_DIR = os.path.join(PROJECT_ROOT, "tools", "governance", "screen_descriptions")

def safe_parse_json(json_str):
    if not json_str:
        return []
    try:
        data = json.loads(json_str)
        if isinstance(data, list):
            return data
        elif isinstance(data, dict):
            return [f"{k}: {v}" for k, v in data.items()]
        return [str(data)]
    except Exception:
        return [str(json_str)]

def main():
    print("==============================================================")
    # 1. Connect to SQLite DB
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Query all screens
    screens = cur.execute("""
        SELECT screen_code, screen_name, required_components_json, required_functions_json,
               required_buttons_json, required_apis_json, data_cy_required_json
        FROM screens
    """).fetchall()

    print(f"Loaded {len(screens)} screens from governance database.")

    # Make sure output directory exists
    os.makedirs(DESCRIPTIONS_DIR, exist_ok=True)

    renamed_count = 0
    needs_created_count = 0

    for screen in screens:
        screen_code = screen["screen_code"]
        screen_name = screen["screen_name"]

        if not screen_code:
            continue

        # 2. Rename Description file: check for old formats (-<code_code>.txt or <screen_code>.txt)
        old_processed_name = f"-{screen_code}.txt"
        old_unprocessed_name = f"{screen_code}.txt"
        new_desc_name = f"{screen_code}_description.txt"

        old_processed_path = os.path.join(DESCRIPTIONS_DIR, old_processed_name)
        old_unprocessed_path = os.path.join(DESCRIPTIONS_DIR, old_unprocessed_name)
        new_desc_path = os.path.join(DESCRIPTIONS_DIR, new_desc_name)

        if os.path.exists(old_processed_path):
            os.replace(old_processed_path, new_desc_path)
            renamed_count += 1
        elif os.path.exists(old_unprocessed_path):
            os.replace(old_unprocessed_path, new_desc_path)
            renamed_count += 1

        # 3. Create Needs Components file: <screen_code>_needs_components.txt
        needs_name = f"{screen_code}_needs_components.txt"
        needs_path = os.path.join(DESCRIPTIONS_DIR, needs_name)

        components = safe_parse_json(screen["required_components_json"])
        functions = safe_parse_json(screen["required_functions_json"])
        buttons = safe_parse_json(screen["required_buttons_json"])
        apis = safe_parse_json(screen["required_apis_json"])
        data_cy = safe_parse_json(screen["data_cy_required_json"])

        content_lines = [
            f"Screen Code: {screen_code}",
            f"Screen Name: {screen_name}",
            "",
            "Required Components:",
        ]
        if components:
            content_lines.extend(f"- {c}" for c in components)
        else:
            content_lines.append("- [None specified]")

        content_lines.append("")
        content_lines.append("Required Functions/Handlers:")
        if functions:
            content_lines.extend(f"- {f}" for f in functions)
        else:
            content_lines.append("- [None specified]")

        content_lines.append("")
        content_lines.append("Required Buttons:")
        if buttons:
            content_lines.extend(f"- {b}" for b in buttons)
        else:
            content_lines.append("- [None specified]")

        content_lines.append("")
        content_lines.append("Required APIs:")
        if apis:
            content_lines.extend(f"- {a}" for a in apis)
        else:
            content_lines.append("- [None specified]")

        content_lines.append("")
        content_lines.append("Required Semantic Keys (data-cy):")
        if data_cy:
            content_lines.extend(f"- {k}" for k in data_cy)
        else:
            content_lines.append("- [None specified]")

        # Write needs components file
        with open(needs_path, "w", encoding="utf-8") as f:
            f.write("\n".join(content_lines) + "\n")
        needs_created_count += 1

    # Cleanup any leftover files starting with '-' in directory that might not match DB
    for filename in os.listdir(DESCRIPTIONS_DIR):
        if filename.startswith("-") and filename.endswith(".txt"):
            code = filename[1:-4]
            old_path = os.path.join(DESCRIPTIONS_DIR, filename)
            new_path = os.path.join(DESCRIPTIONS_DIR, f"{code}_description.txt")
            if not os.path.exists(new_path):
                os.replace(old_path, new_path)
                renamed_count += 1

    conn.close()
    print("==============================================================")
    print(f"Renamed/Updated description files: {renamed_count}")
    print(f"Created/Updated needs components files: {needs_created_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
