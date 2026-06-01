import sqlite3
import os
import re
import json
from datetime import datetime

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
CYPRESS_DIR = os.path.join(PROJECT_ROOT, "cypress", "e2e", "04_roles")

def initialize_tracker_table():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS screen_e2e_compliance_tracker (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            screen_code TEXT UNIQUE,
            screen_name TEXT,
            role_code TEXT,
            route_path TEXT,
            expected_file_path TEXT,
            actual_file_path TEXT,
            required_selectors TEXT,
            actual_selectors TEXT,
            missing_selectors TEXT,
            status TEXT,
            suggested_action TEXT,
            last_audited_at TEXT
        );
    """)
    conn.commit()
    conn.close()
    print("Initialized screen_e2e_compliance_tracker table.")

def find_override_path(screen_code, class_name, package_file_path):
    """
    Check if the screen is overridden in the apps/primecare_clinic workspace
    """
    if not package_file_path:
        return None
        
    filename = os.path.basename(package_file_path)
    
    # Common override locations in primecare_clinic:
    search_dirs = [
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "shared", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "rn", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "psw", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "physician", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "generated_screens")
    ]
    
    for d in search_dirs:
        # Check standard basename
        path = os.path.join(d, filename)
        if os.path.exists(path):
            return os.path.relpath(path, PROJECT_ROOT).replace("\\", "/")
            
        # Check if there is a slightly renamed file
        if os.path.isdir(d):
            for f in os.listdir(d):
                if f.endswith(".dart") and (screen_code in f or class_name.lower().replace("screen", "") in f.lower()):
                    return os.path.relpath(os.path.join(d, f), PROJECT_ROOT).replace("\\", "/")
                    
    return None

def main():
    initialize_tracker_table()
    
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Find all role spec files in cypress/e2e/04_roles
    if not os.path.exists(CYPRESS_DIR):
        print(f"Cypress roles directory not found: {CYPRESS_DIR}")
        return
        
    spec_files = [f for f in os.listdir(CYPRESS_DIR) if f.startswith("role_") and f.endswith(".cy.js")]
    print(f"Found {len(spec_files)} clinical role E2E specs.")
    
    all_found_screens = []
    
    for spec_file in spec_files:
        role_code = spec_file.replace("role_", "").replace("_all_screens.cy.js", "")
        spec_path = os.path.join(CYPRESS_DIR, spec_file)
        
        with open(spec_path, "r", encoding="utf-8") as f:
            content = f.read()
            
        # Parse visits and screen details:
        # cy.task("log", "... Navigating to /route (ScreenClassName)...");
        # cy.visitWithSemantics("/route");
        # cy.getCy("selector").should("be.visible");
        
        visits = re.findall(r'cy\.visitWithSemantics\("([^"]+)"\);', content)
        for route in visits:
            # Clean route parameter enable-semantics
            clean_route = route.split("?")[0]
            
            # Find screen in screens table by route_path
            cursor.execute("""
                SELECT id, screen_code, screen_name, route_path, actual_file_path, expected_file_path, class_exists, data_cy_required_json
                FROM screens
                WHERE route_path = ? OR route_path = ? OR route_path LIKE ?;
            """, (clean_route, clean_route + "/", clean_route.replace("/offices", "%")))
            
            screen_rows = cursor.fetchall()
            if not screen_rows:
                # Try fallback matching clean_route
                cursor.execute("""
                    SELECT id, screen_code, screen_name, route_path, actual_file_path, expected_file_path, class_exists, data_cy_required_json
                    FROM screens
                    WHERE route_path LIKE ?;
                """, ("%" + clean_route + "%",))
                screen_rows = cursor.fetchall()
                
            if not screen_rows:
                # Log untracked screens
                print(f"Untracked route in E2E spec: {clean_route} for role {role_code}")
                continue
                
            for s_row in screen_rows:
                screen_code = s_row["screen_code"]
                screen_name = s_row["screen_name"]
                actual_file_path = s_row["actual_file_path"] or s_row["expected_file_path"]
                data_cy_req = s_row["data_cy_required_json"]
                
                # Check for overrides in apps/primecare_clinic
                class_name = screen_name.replace(" ", "") + "Screen"
                override_path = find_override_path(screen_code, class_name, actual_file_path)
                final_file_path = override_path if override_path else actual_file_path
                
                # Retrieve expected selectors from Cypress test spec for this route segment
                # Find all getCy statements between this visit and the next visit
                pattern = rf'cy\.visitWithSemantics\("{re.escape(route)}"\);(.*?)(?:cy\.visitWithSemantics|$)'
                segment_match = re.search(pattern, content, re.DOTALL)
                
                expected_selectors = []
                if segment_match:
                    segment = segment_match.group(1)
                    expected_selectors = re.findall(r'cy\.getCy\("([^"]+)"\)', segment)
                    
                # Fallback to data_cy_required_json if spec extraction yields nothing
                if not expected_selectors and data_cy_req:
                    try:
                        req_dict = json.loads(data_cy_req)
                        expected_selectors = list(req_dict.values())
                    except:
                        pass
                        
                # Ensure unique selectors
                expected_selectors = list(set(expected_selectors))
                if not expected_selectors:
                    # Generic fallback based on screen_code
                    prefix = screen_code.replace("_", "").lower()
                    expected_selectors = [f"{prefix}-screen", f"{prefix}-title", f"{prefix}-content"]
                    
                all_found_screens.append({
                    "screen_code": screen_code,
                    "screen_name": screen_name,
                    "role_code": role_code,
                    "route_path": clean_route,
                    "file_path": final_file_path,
                    "expected_file_path": s_row["expected_file_path"] or s_row["actual_file_path"],
                    "expected_selectors": expected_selectors
                })
                
    # Loop and inspect all physical files
    print(f"\n--- AUDITING {len(all_found_screens)} UNIQUE CLINICAL ROLE SCREENS ---")
    
    aligned_count = 0
    mismatched_count = 0
    stubs_count = 0
    missing_files_count = 0
    
    for scr in all_found_screens:
        file_path = scr["file_path"]
        screen_code = scr["screen_code"]
        expected_selectors = scr["expected_selectors"]
        
        full_path = os.path.join(PROJECT_ROOT, file_path) if file_path else ""
        
        if not file_path or not os.path.exists(full_path):
            # Try package fallback
            fallback_full_path = os.path.join(PROJECT_ROOT, scr["expected_file_path"]) if scr["expected_file_path"] else ""
            if fallback_full_path and os.path.exists(fallback_full_path):
                full_path = fallback_full_path
                file_path = scr["expected_file_path"]
            else:
                # File does not exist physically
                status = "missing_file"
                suggested = "Implement screen file from scratch."
                missing_files_count += 1
                
                cursor.execute("""
                    INSERT OR REPLACE INTO screen_e2e_compliance_tracker
                    (screen_code, screen_name, role_code, route_path, expected_file_path, actual_file_path, required_selectors, actual_selectors, missing_selectors, status, suggested_action, last_audited_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
                """, (screen_code, scr["screen_name"], scr["role_code"], scr["route_path"], scr["expected_file_path"], "", json.dumps(expected_selectors), "[]", json.dumps(expected_selectors), status, suggested, datetime.now().isoformat()))
                continue
                
        # Read the file content
        with open(full_path, "r", encoding="utf-8") as f:
            dart_code = f.read()
            
        # Check selectors in Dart code
        actual_selectors = []
        missing_selectors = []
        
        for sel in expected_selectors:
            # Match variations: "data-cy:selector", "selector", Key("selector"), etc.
            if sel in dart_code or f"data-cy:{sel}" in dart_code:
                actual_selectors.append(sel)
            else:
                missing_selectors.append(sel)
                
        # Classify screen status
        is_stub = "is now fully implemented" in dart_code or "check_circle_outline" in dart_code or len(dart_code) < 1500
        
        if is_stub:
            status = "stub_lacks_selectors"
            suggested = f"Replace this stub with a Governed layout and inject selectors: {expected_selectors}"
            stubs_count += 1
        elif not missing_selectors:
            status = "aligned"
            suggested = "None - fully aligned with E2E suite."
            aligned_count += 1
        else:
            # Check if there's a mismatch (role-specific selector present instead of generic, e.g. clinicaldirectordashboard vs clinicaldashboard)
            # Find any Cy or Semantics labels in the code
            found_cy_tags = re.findall(r"data-cy:([a-zA-Z0-9_\-]+)", dart_code)
            found_cy_tags += re.findall(r"Cy\(\s*id:\s*'([a-zA-Z0-9_\-]+)'", dart_code)
            found_cy_tags += re.findall(r"Key\(\s*'([a-zA-Z0-9_\-]+)'\s*\)", dart_code)
            found_cy_tags = list(set(found_cy_tags))
            
            print(f"DEBUG: Mismatched screen found - Code: {screen_code}, File: {file_path}, Expected: {expected_selectors}, Missing: {missing_selectors}")
            status = "mismatched"
            suggested = f"Update dashboard wrapper to support dual selectors: actual = {found_cy_tags}, expected = {expected_selectors}"
            mismatched_count += 1
            
        cursor.execute("""
            INSERT OR REPLACE INTO screen_e2e_compliance_tracker
            (screen_code, screen_name, role_code, route_path, expected_file_path, actual_file_path, required_selectors, actual_selectors, missing_selectors, status, suggested_action, last_audited_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """, (screen_code, scr["screen_name"], scr["role_code"], scr["route_path"], scr["expected_file_path"], file_path, json.dumps(expected_selectors), json.dumps(actual_selectors), json.dumps(missing_selectors), status, suggested, datetime.now().isoformat()))
        
    conn.commit()
    conn.close()
    
    print("\n==========================================================")
    print("AUDIT RESULT SUMMARY TABLE")
    print("==========================================================")
    print(f"  Aligned Screens:           {aligned_count}")
    print(f"  Mismatched Screens:        {mismatched_count}")
    print(f"  Stub Lacks Selectors:       {stubs_count}")
    print(f"  Missing Screen Files:      {missing_files_count}")
    print(f"  Total Checked:             {aligned_count + mismatched_count + stubs_count + missing_files_count}")
    print("==========================================================")
    print("All results successfully persisted to SQL database!")

if __name__ == '__main__':
    main()
