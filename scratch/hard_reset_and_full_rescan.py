import sqlite3
import os
import re
import json

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
report_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\786668ab-d7bb-4d60-8e35-f21f2837e67a\hard_reset_audit_report.md"
report_meta_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\786668ab-d7bb-4d60-8e35-f21f2837e67a\hard_reset_audit_report.md.metadata.json"

stage_percentages = {
    0: 0,
    1: 10,
    2: 20,
    3: 30,
    4: 40,
    5: 50,
    6: 60,
    7: 70,
    8: 80,
    9: 90,
    10: 95,
    11: 100
}

stage_names = {
    0: 'FILE_EXISTS',
    1: 'ROUTE_CONNECTED',
    2: 'HTML_STRUCTURE',
    3: 'REAL_UI_ELEMENTS',
    4: 'COMPONENTS_WIRED',
    5: 'BUSINESS_LOGIC',
    6: 'API_CONNECTED',
    7: 'DB_CONNECTED',
    8: 'VALIDATION_IMPLEMENTED',
    9: 'USER_INTERACTIONS',
    10: 'QA_TEST_PASSED',
    11: 'PRODUCTION_READY'
}

def clean_prime_header(content):
    """Strip out the PRIME header comment block so we don't match placeholders inside it."""
    return re.sub(r'/\*\s*\n\s*PRIME:SCREEN.*?\*/\s*\n?', '', content, flags=re.DOTALL)

def detect_placeholders(content):
    cleaned = clean_prime_header(content)
    
    # 1. Coming Soon (case-insensitive)
    if re.search(r'(?i)coming\s+soon', cleaned):
        return True, 'Coming Soon text'
        
    # 2. Placeholder text or widgets
    if re.search(r'(?i)["\']placeholder["\']|Text\(\s*["\']placeholder["\']', cleaned):
        return True, 'Placeholder text/widget'
        
    # 3. TODO comments
    if re.search(r'//\s*TODO|/\*\s*TODO|TODO:', cleaned):
        return True, 'TODO comment'
        
    # 4. Mock Data
    if re.search(r'(?i)mock\s+data', cleaned):
        return True, 'Mock Data'
        
    # 5. Sample Data
    if re.search(r'(?i)sample\s+data', cleaned):
        return True, 'Sample Data'
        
    # 6. Lorem Ipsum
    if re.search(r'(?i)lorem\s+ipsum', cleaned):
        return True, 'Lorem Ipsum'
        
    # 7. return null from build method
    if re.search(r'Widget\s+build\(.*?\)\s*\{\s*return\s+null\s*;', cleaned, re.DOTALL):
        return True, 'return null in build'
        
    # 8. Empty Containers/SizedBox returning from build
    if re.search(r'Widget\s+build\(.*?\)\s*\{\s*return\s+(Container|SizedBox)\(\)\s*;', cleaned, re.DOTALL):
        return True, 'Empty Container/SizedBox in build'
        
    return False, ''

def determine_stage(content, has_route, has_test_file):
    cleaned = clean_prime_header(content)
    
    # Stage 0: File exists (already guaranteed if we are reading it)
    stage = 0
    
    # Stage 1: Route connected
    if has_route:
        stage = 1
        
    # Stage 2: HTML structure (Scaffold, AppBar, Padding, Column, Row, ListView, Container)
    structure_words = ['Scaffold', 'AppBar', 'Padding', 'Column', 'Row', 'ListView', 'Container', 'Center', 'Stack']
    if any(w in cleaned for w in structure_words):
        stage = 2
        
    # Stage 3: Real UI elements (GovMetricCard, MetricCard, Card, ElevatedButton, TextFormField, Text, Icon, etc.)
    ui_words = ['Card', 'GovMetricCard', 'MetricCard', 'ElevatedButton', 'TextFormField', 'Text(', 'Icon(', 'IconButton(', 'TextField(']
    if any(w in cleaned for w in ui_words):
        stage = 3
        
    # Stage 4: Components wired (ConsumerWidget, ConsumerStatefulWidget, ref.watch, ref.read)
    if 'ConsumerWidget' in cleaned or 'ConsumerState' in cleaned or 'ref.watch' in cleaned or 'ref.read' in cleaned:
        stage = 4
        
    # Stage 5: Business logic (controllers, StateNotifierProvider, view model references)
    if 'Provider' in cleaned or 'controller' in cleaned.lower() or 'notifier' in cleaned.lower() or 'viewmodel' in cleaned.lower():
        stage = 5
        
    # Stage 6: API connected (apiClientProvider, api.get, api.post, http.Client, dio.get)
    if 'apiClientProvider' in cleaned or 'api.get' in cleaned or 'api.post' in cleaned or 'http.get' in cleaned:
        stage = 6
        
    # Stage 7: Database connected (drift, sqlite, db., repository, save, insert)
    if 'db.' in cleaned or 'sqlite' in cleaned.lower() or 'drift' in cleaned.lower() or 'repository' in cleaned.lower():
        stage = 7
        
    # Stage 8: Validation implemented (validator, FormState, GlobalKey<FormState>)
    if 'validator:' in cleaned or 'FormState' in cleaned or 'GlobalKey' in cleaned:
        stage = 8
        
    # Stage 9: User interactions working (onPressed, onTap, onChanged calling controller/notifier methods)
    if ('onPressed:' in cleaned or 'onTap:' in cleaned or 'onChanged:' in cleaned) and stage >= 8:
        stage = 9
        
    # Stage 10: QA test passed (has Cypress test file or custom passed meta)
    if has_test_file and stage >= 9:
        stage = 10
        
    # Stage 11: Production ready
    if stage == 10 and 'FINAL_FURNISHED' in content:
        stage = 11
        
    return stage

def update_file_prime_tags(file_path, screen_code, stage, progress, blocker, next_action):
    header = f"""/* 
PRIME:SCREEN={screen_code}
PRIME:DESIGN={'DESIGN_APPROVED' if stage >= 3 else 'DESIGN_STARTED' if stage >= 2 else 'DESIGN_NOT_STARTED'}
PRIME:HTML={'HTML_RESPONSIVE_DONE' if stage >= 4 else 'HTML_LAYOUT_DONE' if stage >= 2 else 'HTML_EMPTY'}
PRIME:COMP={'COMP_FINAL' if stage >= 9 else 'COMP_REUSABLE' if stage >= 4 else 'COMP_MISSING'}
PRIME:LOGIC={'LOGIC_CLEAN' if stage >= 9 else 'LOGIC_WORKING' if stage >= 5 else 'LOGIC_NONE'}
PRIME:API={'API_ERROR_HANDLED' if stage >= 6 else 'API_CONNECTED' if stage >= 5 else 'API_NONE'}
PRIME:DB={'DB_FULLY_CONNECTED' if stage >= 7 else 'DB_QUERY_READY' if stage >= 6 else 'DB_NONE'}
PRIME:VALIDATION={'VALIDATION_FULL' if stage >= 8 else 'VALIDATION_BASIC' if stage >= 7 else 'VALIDATION_NONE'}
PRIME:QA={'QA_PASSED' if stage >= 10 else 'QA_NOT_STARTED'}
PRIME:FINAL={'FINAL_FURNISHED' if stage >= 11 else 'FINAL_NOT_READY'}
PRIME:PROGRESS={progress}
PRIME:BLOCKER={blocker or ''}
PRIME:NEXT_ACTION={next_action or ''}
*/
"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    if "PRIME:SCREEN" in content:
        new_content = re.sub(r'/\*\s*\n\s*PRIME:SCREEN.*?\*/\s*\n?', header, content, flags=re.DOTALL)
    else:
        new_content = header + content

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)

def main():
    print("PHASE 1: HARD RESET")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    cursor.execute("""
        UPDATE screens
        SET progress_percent = 0,
            design_stage = 'DESIGN_NOT_STARTED',
            html_stage = 'HTML_EMPTY',
            component_stage = 'COMP_NOT_STARTED',
            logic_stage = 'LOGIC_NONE',
            api_stage = 'API_NONE',
            db_stage = 'DB_NONE',
            validation_stage = 'VALIDATION_NONE',
            qa_stage = 'QA_NOT_STARTED',
            final_stage = 'FINAL_NOT_READY',
            blocker = NULL,
            next_action = NULL
    """)
    conn.commit()
    print("All screens reset successfully to Stage 0.")
    
    print("\nPHASE 2 & 3: FULL RESCAN & PLACEHOLDER DETECTION")
    cursor.execute("SELECT id, screen_code, screen_name, route_path, actual_file_path, allowed_roles_text FROM screens")
    screens = cursor.fetchall()
    
    audit_results = []
    
    for s in screens:
        screen_id, code, name, route_path, file_path, roles = s
        if not file_path:
            continue
            
        full_path = os.path.join(project_root, file_path.replace("/", os.sep))
        
        # Verify Stage 0: File Exists
        if not os.path.exists(full_path):
            audit_results.append({
                'id': screen_id, 'code': code, 'route': route_path, 'file_path': file_path,
                'stage': 0, 'progress': 0, 'placeholder': 'No (File Missing)',
                'api': 'no', 'db': 'no', 'prod': 'no'
            })
            continue
            
        with open(full_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Placeholder Detection
        has_placeholder, placeholder_type = detect_placeholders(content)
        
        # Check Route connection (Stage 1)
        has_route = bool(route_path and route_path.strip())
        
        # Check Cypress test file existence (Stage 10)
        has_test_file = False
        spec_path = f"cypress/e2e/{code}_spec.js"
        if os.path.exists(os.path.join(project_root, spec_path)):
            has_test_file = True
            
        # Determine current stage based on actual code scanning
        stage = determine_stage(content, has_route, has_test_file)
        
        # Capping logic if placeholder detected
        blocker = ""
        next_action = ""
        if has_placeholder:
            stage = min(stage, 2)
            blocker = f"Placeholder detected: {placeholder_type}"
            next_action = "Remediate placeholder elements with real visual widgets"
            
        progress = stage_percentages[stage]
        
        # Metadata values for update
        design = 'DESIGN_APPROVED' if stage >= 3 else 'DESIGN_STARTED' if stage >= 2 else 'DESIGN_NOT_STARTED'
        html = 'HTML_RESPONSIVE_DONE' if stage >= 4 else 'HTML_LAYOUT_DONE' if stage >= 2 else 'HTML_EMPTY'
        comp = 'COMP_FINAL' if stage >= 9 else 'COMP_REUSABLE' if stage >= 4 else 'COMP_MISSING'
        logic = 'LOGIC_CLEAN' if stage >= 9 else 'LOGIC_WORKING' if stage >= 5 else 'LOGIC_NONE'
        api = 'API_ERROR_HANDLED' if stage >= 6 else 'API_CONNECTED' if stage >= 5 else 'API_NONE'
        db = 'DB_FULLY_CONNECTED' if stage >= 7 else 'DB_QUERY_READY' if stage >= 6 else 'DB_NONE'
        val = 'VALIDATION_FULL' if stage >= 8 else 'VALIDATION_BASIC' if stage >= 7 else 'VALIDATION_NONE'
        qa = 'QA_PASSED' if stage >= 10 else 'QA_NOT_STARTED'
        final = 'FINAL_FURNISHED' if stage >= 11 else 'FINAL_NOT_READY'
        
        # PHASE 4: UPDATE DATABASE
        cursor.execute("""
            UPDATE screens
            SET design_stage = ?,
                html_stage = ?,
                component_stage = ?,
                logic_stage = ?,
                api_stage = ?,
                db_stage = ?,
                validation_stage = ?,
                qa_stage = ?,
                final_stage = ?,
                progress_percent = ?,
                blocker = ?,
                next_action = ?
            WHERE id = ?
        """, (design, html, comp, logic, api, db, val, qa, final, progress, blocker, next_action, screen_id))
        
        # Also update file header
        update_file_prime_tags(full_path, code, stage, progress, blocker, next_action)
        
        audit_results.append({
            'id': screen_id, 'code': code, 'route': route_path, 'file_path': file_path,
            'stage': stage, 'progress': progress, 'placeholder': 'Yes' if has_placeholder else 'No',
            'api': 'yes' if stage >= 6 else 'no', 'db': 'yes' if stage >= 7 else 'no', 'prod': 'yes' if stage >= 11 else 'no'
        })
        
    conn.commit()
    conn.close()
    print("Database and screen file headers updated with real rescan metrics.")
    
    print("\nPHASE 5: AUDIT REPORT GENERATION")
    total_screens = len(audit_results)
    real_ui_count = sum(1 for a in audit_results if a['stage'] >= 3)
    placeholder_count = sum(1 for a in audit_results if a['placeholder'] == 'Yes')
    broken_empty_count = sum(1 for a in audit_results if a['stage'] < 2)
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write('# Clean Slate Codebase Audit Report\n\n')
        f.write('## Summary Metrics\n')
        f.write(f'- **Total Screens**: {total_screens}\n')
        f.write(f'- **Total Real UI Screens (Stage 3+)**: {real_ui_count}\n')
        f.write(f'- **Total Screens with Placeholders**: {placeholder_count}\n')
        f.write(f'- **Total Broken/Empty Screens (Stage < 2)**: {broken_empty_count}\n')
        f.write(f"- **Average Progress**: {sum(a['progress'] for a in audit_results)/total_screens:.2f}%\n\n")
        
        f.write('## Screen Audit Details\n\n')
        f.write('| Route Path | Component File | Current Stage | Progress Percent | Placeholder Detected | API Connected | DB Connected | Production Ready |\n')
        f.write('| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n')
        for a in audit_results:
            f.write(f"| `{a['route'] or ''}` | [{a['file_path']}](file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/{a['file_path']}) | Stage {a['stage']} ({stage_names[a['stage']].replace('_', ' ')}) | {a['progress']}% | {a['placeholder']} | {a['api']} | {a['db']} | {a['prod']} |\n")

    # Save meta
    meta = {
        'artifactType': 'ARTIFACT_TYPE_WALKTHROUGH',
        'summary': f"Clean slate codebase audit report covering {total_screens} registered screens.",
        'updatedAt': '2026-06-24T18:04:32.000Z'
    }
    with open(report_meta_path, 'w', encoding='utf-8') as f:
        json.dump(meta, f, indent=2)
        
    print("Report generated successfully at hard_reset_audit_report.md.")

if __name__ == '__main__':
    main()
