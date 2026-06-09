import os
import re
import json
import sqlite3
import argparse

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def parse_getter_string(content, getter_name):
    """Parses a String getter override (e.g. String get getter_name => 'value';)"""
    pattern = rf"get\s+{getter_name}\s+=>\s+['\"](.*?)['\"];"
    match = re.search(pattern, content)
    if match:
        return match.group(1).strip()
    
    # Fallback to multi-line getter block
    pattern_block = rf"String\s+get\s+{getter_name}\s*\{{\s*return\s+['\"](.*?)['\"];\s*\}}"
    match_block = re.search(pattern_block, content, re.DOTALL)
    if match_block:
        return match_block.group(1).strip()
    
    return None

def parse_getter_list(content, getter_name):
    """Parses a List<String> getter override (e.g. List<String> get getter_name => const [...];)"""
    pattern = rf"get\s+{getter_name}\s+=>\s+(?:const\s+)?\[(.*?)\];"
    match = re.search(pattern, content, re.DOTALL)
    if match:
        raw_list = match.group(1)
        # Extract individual string literals
        items = re.findall(r"['\"](.*?)['\"]", raw_list)
        return [i.strip() for i in items]
    
    # Fallback to block format
    pattern_block = rf"get\s+{getter_name}\s*\{{\s*return\s+(?:const\s+)?\[(.*?)\];\s*\}}"
    match_block = re.search(pattern_block, content, re.DOTALL)
    if match_block:
        raw_list = match_block.group(1)
        items = re.findall(r"['\"](.*?)['\"]", raw_list)
        return [i.strip() for i in items]
        
    return None

def main():
    parser = argparse.ArgumentParser(description="PrimeCare Screen Governance Verification Utility")
    parser.add_argument("--screen", help="Verify only a specific screen code")
    parser.add_argument("--update-db", action="store_true", default=True, help="Update verification results in SQLite database")
    args = parser.parse_args()

    print("==============================================================")
    print("PRIMECARE GOVERNANCE: COMPLIANCE & CHECKLIST VERIFIER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    query = "SELECT id, screen_code, screen_name, actual_file_path, required_components_json, required_functions_json FROM screens"
    params = []
    if args.screen:
        query += " WHERE screen_code = ?"
        params.append(args.screen)

    db_screens = cur.execute(query, params).fetchall()
    print(f"Loaded {len(db_screens)} candidate screens for compliance verification.")

    verified_count = 0
    drifted_count = 0

    for s in db_screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        actual_path = s["actual_file_path"]

        if not actual_path:
            continue

        full_path = os.path.join(PROJECT_ROOT, actual_path)
        if not os.path.exists(full_path):
            continue

        # Load required specification
        try:
            req_components = json.loads(s["required_components_json"]) if s["required_components_json"] else []
        except Exception:
            req_components = []

        try:
            req_functions = json.loads(s["required_functions_json"]) if s["required_functions_json"] else []
        except Exception:
            req_functions = []

        print(f"\nScanning: '{screen_code}' ({actual_path})")
        print(f"  Expected Components: {req_components}")
        print(f"  Expected Functions: {req_functions}")

        try:
            with open(full_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
        except Exception as e:
            print(f"  Error reading file: {e}")
            continue

        # 1. Parse Governance Getter Overrides
        declared_description = parse_getter_string(content, "screenDescription")
        declared_components = parse_getter_list(content, "requiredComponents")
        declared_functions = parse_getter_list(content, "requiredFunctions")

        # 2. Perform Code Scanning Fallback if Getters are Empty
        actual_components = []
        actual_functions = []

        # Find which expected components are implemented in the code
        for comp in req_components:
            # Check if declared explicitly in requiredComponents getter
            if declared_components is not None and comp in declared_components:
                actual_components.append(comp)
            # Or if it is physically typed in the code
            elif re.search(rf"\b{comp}\b", content):
                actual_components.append(comp)

        # Find which expected functions/handlers are implemented
        for func in req_functions:
            # Check if declared explicitly in requiredFunctions getter
            if declared_functions is not None and func in declared_functions:
                actual_functions.append(func)
            # Or if it is defined/called in code (e.g. controller.toggleCheckIn, void toggleCheckIn, onPressed: toggleCheckIn)
            elif re.search(rf"\b{func}\b", content):
                actual_functions.append(func)

        missing_components = [c for c in req_components if c not in actual_components]
        missing_functions = [f for f in req_functions if f not in actual_functions]

        # Determine alignment status
        is_aligned = len(missing_components) == 0 and len(missing_functions) == 0
        status = "aligned" if is_aligned else "drift_detected"

        print(f"  Status: {status.upper()}")
        print(f"  Declared Description: {declared_description or '[None]'}")
        print(f"  Actual Components Found: {actual_components}")
        print(f"  Missing Components: {missing_components}")
        print(f"  Actual Functions Found: {actual_functions}")
        print(f"  Missing Functions: {missing_functions}")

        if is_aligned:
            verified_count += 1
        else:
            drifted_count += 1

        # 3. Update database
        if args.update_db:
            try:
                cur.execute("""
                    UPDATE screens
                    SET component_governance_status = ?,
                        actual_components_json = ?,
                        missing_components_json = ?,
                        actual_functions_json = ?,
                        missing_functions_json = ?,
                        component_scan_at = CURRENT_TIMESTAMP
                    WHERE id = ?;
                """, (
                    status,
                    json.dumps(actual_components),
                    json.dumps(missing_components),
                    json.dumps(actual_functions),
                    json.dumps(missing_functions),
                    screen_id
                ))
            except Exception as e:
                print(f"  Database update failed: {e}")

    if args.update_db:
        conn.commit()
    conn.close()

    print("\n==============================================================")
    print("GOVERNANCE VERIFICATION SUMMARY")
    print("==============================================================")
    print(f"Fully Aligned Screens: {verified_count}")
    print(f"Drift Detected Screens: {drifted_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
