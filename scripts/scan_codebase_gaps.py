# scripts/scan_codebase_gaps.py
import os
import sys
import sqlite3
import json
import re

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def extract_elements(text):
    if not text:
        return []
    items = []
    for line in text.replace("\r", "").split("\n"):
        line = line.strip()
        if not line:
            continue
        # Skip headers
        if line.endswith(":") or "list" in line.lower() or "components" in line.lower() or "functions" in line.lower() or "api" in line.lower():
            continue
        # Strip list markers
        if line.startswith("-") or line.startswith("*"):
            line = line[1:].strip()
        # Clean inline items
        if line and line.lower() not in ["none", "n/a", "-", "null"]:
            items.append(line)
    return sorted(list(set(items)))

def main():
    print("==============================================================")
    print("PRIMECARE ENTERPRISE DRIFT SCANNER & CODE GAP ANALYZER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Query all screens with files
    cursor.execute("""
        SELECT * FROM screens 
        WHERE file_exists = 1;
    """)
    screens = cursor.fetchall()
    print(f"Loaded {len(screens)} physical screens for code analysis...\n")

    gap_count = 0
    clean_count = 0

    for idx, scr in enumerate(screens, 1):
        scr_id = scr['id']
        code = scr['screen_code']
        name = scr['screen_name']
        rel_path = scr['actual_file_path'] or scr['expected_file_path']
        abs_path = os.path.join(PROJECT_ROOT, rel_path)

        if not os.path.exists(abs_path):
            print(f"[{idx}/{len(screens)}] Screen {name} ({code}): File not found at {abs_path}. Skipping.")
            continue

        with open(abs_path, 'r', encoding='utf-8') as f:
            code_content = f.read()

        # 1. Parse Required Elements
        req_components = extract_elements(scr['component_list_text'])
        req_buttons = extract_elements(scr['button_list_text'])
        req_functions = extract_elements(scr['function_list_text'])
        req_apis = extract_elements(scr['api_call_list_text'])

        # Responsive requirements
        req_responsive = []
        if scr['supports_4k'] == 1: req_responsive.append("4k")
        if scr['supports_3k'] == 1: req_responsive.append("3k")
        if scr['supports_2k'] == 1: req_responsive.append("2k")
        if scr['supports_1k'] == 1: req_responsive.append("1k")
        if scr['supports_tablet'] == 1: req_responsive.append("tablet")
        if scr['supports_mobile'] == 1: req_responsive.append("mobile")

        # 2. Extract Actual Elements from Dart code
        actual_components = []
        for comp in req_components:
            if comp in code_content:
                actual_components.append(comp)
        gov_widgets = re.findall(r'\bGov[A-Za-z0-9]+\b', code_content)
        prime_widgets = re.findall(r'\bPrimeCare[A-Za-z0-9]+\b', code_content)
        actual_components = sorted(list(set(actual_components + gov_widgets + prime_widgets)))

        actual_buttons = []
        for btn in req_buttons:
            btn_clean = btn.replace(" ", "")
            if btn in code_content or btn.lower() in code_content.lower() or btn_clean in code_content:
                actual_buttons.append(btn)
        for btn_type in ["ElevatedButton", "TextButton", "OutlinedButton", "IconButton", "FloatingActionButton", "GovButton"]:
            if btn_type in code_content:
                actual_buttons.append(btn_type)
        actual_buttons = sorted(list(set(actual_buttons)))

        actual_functions = []
        for func in req_functions:
            if func in code_content:
                actual_functions.append(func)
        methods = re.findall(r'\b(?:void|Future<void>)\s+([A-Za-z0-9_]+)\(', code_content)
        actual_functions = sorted(list(set(actual_functions + methods)))

        actual_apis = []
        for api in req_apis:
            norm_api = api.split()[-1] if len(api.split()) > 1 else api
            norm_api_clean = norm_api.replace("/api", "")
            if norm_api_clean in code_content or norm_api in code_content or os.path.basename(norm_api_clean) in code_content:
                actual_apis.append(api)
        routes = re.findall(r'[\'"](/v1/[a-zA-Z0-9_/]+)[\'"]', code_content)
        actual_apis = sorted(list(set(actual_apis + routes)))

        # Actual responsive detection
        actual_responsive = []
        has_resp = any(k in code_content for k in ["Responsive", "LayoutBuilder", "MediaQuery", "context.isMobile", "context.isTablet"])
        has_flex = any(k in code_content for k in ["Expanded", "Flexible", "Wrap", "SingleChildScrollView", "ListView"])
        for r in req_responsive:
            if r in ["mobile", "tablet"]:
                if has_resp or has_flex:
                    actual_responsive.append(r)
            else:
                if has_flex or "Scaffold" in code_content:
                    actual_responsive.append(r)
        actual_responsive = sorted(list(set(actual_responsive)))

        # 3. Compute Gaps (missing = required - actual)
        missing_components = sorted(list(set(req_components) - set(actual_components)))
        missing_buttons = sorted(list(set(req_buttons) - set(actual_buttons)))
        missing_functions = sorted(list(set(req_functions) - set(actual_functions)))
        missing_apis = sorted(list(set(req_apis) - set(actual_apis)))
        missing_responsive = sorted(list(set(req_responsive) - set(actual_responsive)))

        has_gaps = len(missing_components) > 0 or len(missing_buttons) > 0 or len(missing_functions) > 0 or len(missing_apis) > 0 or len(missing_responsive) > 0

        # Create Gap Summary & Implementation Plan
        gaps_list = []
        plan_steps = []
        step_idx = 1

        if missing_components:
            gaps_list.append(f"Missing Components: {', '.join(missing_components)}")
            plan_steps.append(f"{step_idx}. Implement visual widgets and layout cards: {', '.join(missing_components)}")
            step_idx += 1
        if missing_buttons:
            gaps_list.append(f"Missing Buttons: {', '.join(missing_buttons)}")
            plan_steps.append(f"{step_idx}. Add interactive action buttons: {', '.join(missing_buttons)}")
            step_idx += 1
        if missing_functions:
            gaps_list.append(f"Missing Functions: {', '.join(missing_functions)}")
            plan_steps.append(f"{step_idx}. Code event handlers and state controller methods: {', '.join(missing_functions)}")
            step_idx += 1
        if missing_apis:
            gaps_list.append(f"Missing APIs: {', '.join(missing_apis)}")
            plan_steps.append(f"{step_idx}. Wire network fetches and integrate public API pathways: {', '.join(missing_apis)}")
            step_idx += 1
        if missing_responsive:
            gaps_list.append(f"Missing Responsive Layouts: {', '.join(missing_responsive)}")
            plan_steps.append(f"{step_idx}. Assert flexible widgets and multi-view adaptive structures for: {', '.join(missing_responsive)}")
            step_idx += 1

        code_gap_summary = "; ".join(gaps_list) if has_gaps else "None - physical implementation aligns 100% with registry requirements."
        
        impl_plan_text = "To achieve 100% database compliance:\n" + "\n".join(plan_steps) if has_gaps else "No implementation actions required. Screen is fully compliant."

        ready_val = 0 if has_gaps else 1

        if has_gaps:
            print(f"[{idx}/{len(screens)}] Screen: {name} ({code}) -> DRIFTS FOUND!")
            gap_count += 1
        else:
            print(f"[{idx}/{len(screens)}] Screen: {name} ({code}) -> 100% COMPLIANT")
            clean_count += 1

        # Reset false green flags before verification
        cursor.execute("""
            UPDATE screens 
            SET 
                required_components_json = ?,
                actual_components_json = ?,
                missing_components_json = ?,
                required_buttons_json = ?,
                actual_buttons_json = ?,
                missing_buttons_json = ?,
                required_functions_json = ?,
                actual_functions_json = ?,
                missing_functions_json = ?,
                required_apis_json = ?,
                actual_apis_json = ?,
                missing_apis_json = ?,
                required_responsive_json = ?,
                actual_responsive_json = ?,
                missing_responsive_json = ?,
                code_gap_summary = ?,
                implementation_plan_text = ?,
                ready_for_implementation = ?,
                
                implementation_depth_status = 'pending',
                runtime_clicked = 0,
                runtime_data_loaded = 0,
                runtime_api_success = 0,
                runtime_save_tested = 0,
                workflow_verified = 0
            WHERE id = ?;
        """, (
            json.dumps(req_components) if req_components else None,
            json.dumps(actual_components) if actual_components else None,
            json.dumps(missing_components) if missing_components else None,
            json.dumps(req_buttons) if req_buttons else None,
            json.dumps(actual_buttons) if actual_buttons else None,
            json.dumps(missing_buttons) if missing_buttons else None,
            json.dumps(req_functions) if req_functions else None,
            json.dumps(actual_functions) if actual_functions else None,
            json.dumps(missing_functions) if missing_functions else None,
            json.dumps(req_apis) if req_apis else None,
            json.dumps(actual_apis) if actual_apis else None,
            json.dumps(missing_apis) if missing_apis else None,
            json.dumps(req_responsive) if req_responsive else None,
            json.dumps(actual_responsive) if actual_responsive else None,
            json.dumps(missing_responsive) if missing_responsive else None,
            code_gap_summary,
            impl_plan_text,
            ready_val,
            scr_id
        ))

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("DRIFT SCAN & CODE GAP ANALYSIS SUMMARY:")
    print("==============================================================")
    print(f"  Compliant Screens: {clean_count}")
    print(f"  Gapped/Drifted Screens: {gap_count}")
    print(f"  Total Audited Screens: {len(screens)}")
    print("==============================================================")

if __name__ == '__main__':
    main()
