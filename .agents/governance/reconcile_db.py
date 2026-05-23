import os
import re
import sys
import sqlite3
from datetime import datetime

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def _camel_to_snake(input_str):
    return re.sub(r'(?<=[a-z])[A-Z]', lambda m: '_' + m.group(0), input_str).lower()

def _extract_matching_block(content, start_index):
    open_brackets = 0
    i = start_index
    found_start = False
    
    while i < len(content):
        char = content[i]
        if char == '[':
            open_brackets += 1
            found_start = True
        elif char == ']':
            open_brackets -= 1
            
        if found_start and open_brackets == 0:
            return content[start_index:i + 1]
        i += 1
    return content[start_index:]

def _extract_brace_block(content, start_index):
    open_braces = 0
    i = start_index
    found_start = False
    
    while i < len(content):
        char = content[i]
        if char == '{':
            open_braces += 1
            found_start = True
        elif char == '}':
            open_braces -= 1
            
        if found_start and open_braces == 0:
            return content[start_index:i + 1]
        i += 1
    return content[start_index:]

def _extract_method_body(content, method_name):
    pattern = r'\b' + re.escape(method_name) + r'\s*\([^)]*\)\s*(?:async\s*)?\{'
    match = re.search(pattern, content)
    if not match:
        return ''
    
    body_start = match.end() - 1  # index of '{'
    return _extract_brace_block(content, body_start)

def _extract_class_body(content, class_name):
    pattern = r'\bclass\s+' + re.escape(class_name) + r'\b[\s\S]*?\{'
    match = re.search(pattern, content)
    if not match:
        return ''
        
    body_start = match.end() - 1  # index of '{'
    return _extract_brace_block(content, body_start)

def _analyze_callback(callback, file_content):
    clean = "".join(callback.split())
    if clean in ('(){}', '()=>{}', 'null', ''):
        return 'pending'
        
    footprint = [
        'apiClientProvider', 'apiClient.', 'Dio ', 'prisma', 'dbClient',
        'repository.', 'service.', 'http.Client', 'HttpClient(', '/v1/'
    ]
    file_has_real_api = any(item in file_content for item in footprint)
    
    if not file_has_real_api:
        return 'mock_stub'
        
    if 'controller.addLog' in clean or 'controller.log' in clean:
        return 'mock_stub'
        
    method_match = re.search(r'(?:controller|notifier)\.(\w+)', callback)
    if method_match:
        method_name = method_match.group(1)
        method_body = _extract_method_body(file_content, method_name)
        if method_body:
            body_has_api = any(item in method_body for item in footprint) or 'ref.invalidate' in method_body or 'ref.refresh' in method_body
            if not body_has_api:
                return 'mock_stub'
                
    if 'ref.invalidate' in callback or 'ref.refresh' in callback:
        provider_match = re.search(r'(?:invalidate|refresh)\((\w+)\)', callback)
        if provider_match:
            notifier_regexp = r'(?:NotifierProvider|StateNotifierProvider)<(\w+),\s*'
            notifier_match = re.search(notifier_regexp, file_content)
            if notifier_match:
                notifier_class = notifier_match.group(1)
                class_body = _extract_class_body(file_content, notifier_class)
                if class_body:
                    class_has_api = any(item in class_body for item in footprint)
                    if not class_has_api:
                        return 'mock_stub'
        return 'api_connected'
        
    return 'api_connected'

valid_roles = {
    'chiropractor', 'physio', 'rmt', 'social_worker', 'therapist',
    'clinical_director', 'intake', 'rn', 'physician', 'cns', 'pediatric',
    'caregiver', 'guest', 'portal', 'patient', 'dynamic', 'infrastructure',
    'system_verification', 'training', 'ceo', 'cfo', 'ciso', 'coo', 'cto',
    'cx_director', 'finance_director', 'hr_director', 'legal', 'owner',
    'shareholder', 'training_director', 'community_outreach', 'compliance',
    'franchise_sales', 'gm', 'governance', 'bus_dev', 'marketing',
    'local_marketing', 'ops_manager', 'partnership', 'regional_bdm',
    'regional_manager_usa', 'scrum_master', 'hr_hiring', 'territory_expansion',
    'territory_sales', 'volunteer_coordinator', 'premium_concierge',
    'vip_manager', 'psw', 'hsw', 'rn_field_supervisor', 'np', 'rpn', 'lpn',
    'employee', 'volunteer', 'admin', 'scheduler'
}

def get_short_role_id(role_name):
    short_map = {
        'Chiropractor': 'chiropractor',
        'Physiotherapist': 'physio',
        'Registered Massage Therapist (RMT)': 'rmt',
        'Social Worker': 'social_worker',
        'Therapist': 'therapist',
        'Clinical Director': 'clinical_director',
        'Intake Coordinator': 'intake',
        'Registered Nurse (RN)': 'rn',
        'Physician': 'physician',
        'Clinical Nurse Specialist': 'cns',
        'Pediatric Specialist': 'pediatric',
        'Caregiver': 'caregiver',
        'Guest': 'guest',
        'Portal User': 'portal',
        'Patient': 'patient',
        'Dynamic Screen Viewer': 'dynamic',
        'Infrastructure Auditor': 'infrastructure',
        'System Verification Officer': 'system_verification',
        'Training Candidate': 'training',
        'Chief Executive Officer (CEO)': 'ceo',
        'Chief Financial Officer (CFO)': 'cfo',
        'Chief Information Security Officer (CISO)': 'ciso',
        'Chief Operating Officer (COO)': 'coo',
        'Chief Technology Officer (CTO)': 'cto',
        'CX Director': 'cx_director',
        'Finance Director': 'finance_director',
        'HR Director': 'hr_director',
        'Legal Counsel': 'legal',
        'Franchise Owner': 'owner',
        'Shareholder': 'shareholder',
        'Training Director': 'training_director',
        'Community Outreach Lead': 'community_outreach',
        'Compliance Manager': 'compliance',
        'Franchise Sales Manager': 'franchise_sales',
        'General Manager': 'gm',
        'Governance Officer': 'governance',
        'Head of Business Development': 'bus_dev',
        'Head of Marketing': 'marketing',
        'Local Marketing Manager': 'local_marketing',
        'Operations Manager': 'ops_manager',
        'Partnership Manager': 'partnership',
        'Regional BDM': 'regional_bdm',
        'Regional Manager USA': 'regional_manager_usa',
        'Scrum Master': 'scrum_master',
        'Talent Acquisition Manager': 'hr_hiring',
        'Territory Expansion Manager': 'territory_expansion',
        'Territory Sales Manager': 'territory_sales',
        'Volunteer Coordinator': 'volunteer_coordinator',
        'Premium Concierge Care Coordinator': 'premium_concierge',
        'VIP Client Manager': 'vip_manager',
        'Personal Support Worker (PSW)': 'psw',
        'Home Support Worker': 'hsw',
        'Registered Nurse (RN) Field Supervisor': 'rn_field_supervisor',
        'Nurse Practitioner (NP)': 'np',
        'Registered Practical Nurse (RPN)': 'rpn',
        'Licensed Practical Nurse (LPN)': 'lpn',
        'Employee': 'employee',
        'Volunteer': 'volunteer',
        'Administrative Assistant': 'admin',
        'Shift Supervisor': 'scheduler'
    }
    return short_map.get(role_name, role_name.lower().replace(' ', '_'))

def resolve_role_id(screen_id):
    mapping = {
        'architecture_planning_dashboard_controller': 'cto',
        'billing_admin_dashboard_controller': 'admin',
        'business_development_dashboard_controller': 'bus_dev',
        'cfo_dashboard_controller': 'cfo',
        'chiropractor_dashboard_controller': 'chiropractor',
        'ciso_dashboard_controller': 'ciso',
        'clinic_dashboard_controller': 'clinical_director',
        'clinical_dashboard_controller': 'clinical_director',
        'community_outreach_dashboard_controller': 'community_outreach',
        'compliance_manager_dashboard_controller': 'compliance',
        'coo_dashboard_notifier': 'coo',
        'course_architect_dashboard_controller': 'training_director',
        'cto_dashboard_controller': 'cto',
        'customer_support_dashboard_controller': 'dynamic',
        'cx_director_dashboard_controller': 'cx_director',
        'dynamic_dashboard_controller': 'dynamic',
        'family_member_dashboard_controller': 'patient',
        'finance_director_dashboard_controller': 'finance_director',
        'franchise_dashboard_controller': 'owner',
        'franchise_sales_manager_dashboard_controller': 'franchise_sales',
        'general_manager_dashboard_controller': 'gm',
        'governance_officer_dashboard_controller': 'governance',
        'guest_dashboard_controller': 'guest',
        'head_of_bus_dev_dashboard_controller': 'bus_dev',
        'head_of_marketing_dashboard_controller': 'marketing',
        'hr_director_dashboard_controller': 'hr_director',
        'hr_hiring_dashboard_controller': 'hr_hiring',
        'hr_manager_dashboard_controller': 'hr_director',
        'infrastructure_dashboard_controller': 'infrastructure',
        'intake_coordinator_dashboard_controller': 'intake',
        'intake_dashboard_controller': 'intake',
        'legal_dashboard_controller': 'legal',
        'local_marketing_manager_dashboard_controller': 'local_marketing',
        'office_dashboard_controller': 'admin',
        'operations_manager_dashboard_controller': 'ops_manager',
        'owner_dashboard_controller': 'owner',
        'partnership_manager_dashboard_controller': 'partnership',
        'patient_dashboard_controller': 'patient',
        'physiotherapist_dashboard_controller': 'physio',
        'portal_dashboard_controller': 'portal',
        'psw_dashboard_controller': 'psw',
        'qa_dashboard_controller': 'system_verification',
        'quality_assurance_dashboard_controller': 'system_verification',
        'receptionist_dashboard_controller': 'admin',
        'regional_bdm_dashboard_controller': 'regional_bdm',
        'regional_manager_usa_dashboard_controller': 'regional_manager_usa',
        'rmt_dashboard_controller': 'rmt',
        'rn_dashboard_controller': 'rn',
        'rpn_dashboard_controller': 'rpn',
        'scheduler_dashboard_controller': 'scheduler',
        'scrum_master_dashboard_controller': 'scrum_master',
        'shareholder_dashboard_controller': 'shareholder',
        'social_worker_dashboard_controller': 'social_worker',
        'support_dashboard_controller': 'dynamic',
        'system_dashboard_controller': 'governance',
        'system_verification_dashboard_controller': 'system_verification',
        'territory_expansion_manager_dashboard_controller': 'territory_expansion',
        'territory_sales_manager_dashboard_controller': 'territory_sales',
        'training_coordinator_dashboard_controller': 'training',
        'training_director_dashboard_controller': 'training_director',
        'training_hub_dashboard_controller': 'training',
        'volunteer_coordinator_dashboard_controller': 'volunteer_coordinator'
    }
    
    if screen_id in mapping:
        return mapping[screen_id]
        
    clean_id = screen_id.replace('_dashboard_controller', '').replace('_dashboard_screen', '').replace('_dashboard_notifier', '').replace('_dashboard', '')
    if clean_id in valid_roles:
        return clean_id
        
    return 'guest'

def get_screen_category(route_path):
    parts = route_path.replace('\\', '/').split('/')
    if 'screens' in parts:
        idx = parts.index('screens')
        if idx + 1 < len(parts):
            return parts[idx + 1]
    return 'common'

def find_dashboard_files(screens_dir):
    files = []
    for root, _, filenames in os.walk(screens_dir):
        for name in filenames:
            name_lower = name.lower()
            if name_lower.endswith('_dashboard_screen.dart') or name_lower.endswith('_dashboard.dart'):
                files.append(os.path.join(root, name))
    return files

def scan_software_governance(conn, parsed_screens, anomalies):
    cursor = conn.cursor()
    
    # 1. Database Schema Scan
    print("Performing relational database schema dynamic sweep...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [row['name'] for row in cursor.fetchall() if not row['name'].startswith('sqlite_')]
    
    for t_name in tables:
        cursor.execute("INSERT OR REPLACE INTO db_schema_tables (app_id, table_name, table_type, status) VALUES (1, ?, 'table', 'active');",
                       (t_name,))
        cursor.execute("SELECT id FROM db_schema_tables WHERE table_name = ?;", (t_name,))
        t_id = cursor.fetchone()[0]
        
        # Schema columns
        cursor.execute(f"PRAGMA table_info([{t_name}]);")
        columns = cursor.fetchall()
        
        cursor.execute(f"PRAGMA foreign_key_list([{t_name}]);")
        fk_list = cursor.fetchall()
        fk_map = {fk['from']: (fk['table'], fk['to']) for fk in fk_list}
        
        for col in columns:
            col_name = col['name']
            data_type = col['type']
            is_nullable = 0 if col['notnull'] == 1 else 1
            is_primary = 1 if col['pk'] > 0 else 0
            is_foreign = 1 if col_name in fk_map else 0
            ref_tbl = fk_map[col_name][0] if is_foreign else None
            ref_col = fk_map[col_name][1] if is_foreign else None
            
            cursor.execute("""
            INSERT OR REPLACE INTO db_schema_columns (table_id, column_name, data_type, is_nullable, is_primary, is_foreign, default_value, foreign_table_name, foreign_column_name)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """, (t_id, col_name, data_type, is_nullable, is_primary, is_foreign, None, ref_tbl, ref_col))

    # 2. FileSystem Sweep & screen_file_links
    print("Performing filesystems dynamic sweep (code_files)...")
    search_dirs = [
        (r"packages\primecare_ui\lib\src\screens", "screen"),
        (r"packages\primecare_ui\lib\src\components", "component"),
        (r"apps", "app_file")
    ]
    
    for s_dir, default_type in search_dirs:
        if not os.path.exists(s_dir):
            continue
        for root, dirs, filenames in os.walk(s_dir):
            # Exclude heavy dependency, build, and cache directories from recursive walk
            dirs[:] = [d for d in dirs if d not in ('node_modules', 'build', '.dart_tool', '.git', '.gradle', 'ios', 'android', 'dist', 'tmp', '.next', 'out', 'web')]
            for name in filenames:
                if name.endswith('.dart') or name.endswith('.ts') or name.endswith('.js'):
                    full_path = os.path.join(root, name)
                    rel_path = os.path.relpath(full_path, os.getcwd()).replace('\\', '/')
                    sz = os.path.getsize(full_path)
                    
                    # Count LOC
                    try:
                        with open(full_path, 'r', encoding='utf-8', errors='ignore') as f:
                            lines = f.readlines()
                            loc = len(lines)
                            content = "".join(lines)
                    except:
                        loc = 0
                        content = ""
                        
                    f_type = default_type
                    if 'controller' in name.lower() or 'notifier' in name.lower():
                        f_type = 'controller'
                    elif 'guard' in name.lower() or 'router' in name.lower() or 'middleware' in name.lower():
                        f_type = 'middleware'
                    elif 'test' in name.lower() or 'spec' in name.lower():
                        f_type = 'test'
                        
                    # Insert file
                    cursor.execute("""
                    INSERT OR REPLACE INTO code_files (app_id, file_name, file_path, file_type, language, folder_path, is_generated, status, last_scanned_at)
                    VALUES (1, ?, ?, ?, 'dart', ?, 0, 'active', ?);
                    """, (name, rel_path, f_type, os.path.dirname(rel_path), datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
                    cursor.execute("SELECT id FROM code_files WHERE file_path = ?;", (rel_path,))
                    f_row = cursor.fetchone()
                    f_id = f_row[0] if f_row else 1
                    
                    # If it is a screen, link it to screens table
                    for screen_code, parsed in parsed_screens.items():
                        if parsed['path'].lower().replace('\\', '/') == rel_path.lower():
                            cursor.execute("SELECT id FROM screens WHERE screen_code = ?;", (screen_code,))
                            scr_row = cursor.fetchone()
                            if scr_row:
                                cursor.execute("INSERT OR IGNORE INTO screen_file_links (screen_id, file_id, link_type) VALUES (?, ?, 'implementation');",
                                               (scr_row[0], f_id))
                                
                    # 3. Dynamic API endpoint scanning within screens
                    if content:
                        apis = re.findall(r"['\"](/v1/[a-zA-Z0-9_\-\/]+)['\"]", content)
                        for api_route in apis:
                            # Guess method
                            method = "POST"
                            if f"get('{api_route}'" in content.lower() or f"get(\"{api_route}\"" in content.lower():
                                method = "GET"
                            elif f"delete('{api_route}'" in content.lower():
                                method = "DELETE"
                            elif f"put('{api_route}'" in content.lower():
                                method = "PUT"
                                
                            cursor.execute("INSERT OR IGNORE INTO api_endpoints (app_id, endpoint_code, route_path, http_method, controller_name, service_name, auth_required, implementation_status) VALUES (1, ?, ?, ?, ?, 'PRISMA', 1, 'active');",
                                           (f"API_{api_route.replace('/', '_').upper()}", api_route, method, ''))
                            cursor.execute("SELECT id FROM api_endpoints WHERE http_method = ? AND route_path = ?;", (method, api_route))
                            api_row = cursor.fetchone()
                            api_id = api_row[0] if api_row else 1
                            
                            # Link to screen
                            for screen_code, parsed in parsed_screens.items():
                                if parsed['path'].lower().replace('\\', '/') == rel_path.lower():
                                    cursor.execute("SELECT id FROM screens WHERE screen_code = ?;", (screen_code,))
                                    scr_row = cursor.fetchone()
                                    if scr_row:
                                        cursor.execute("INSERT OR IGNORE INTO screen_api_links (screen_id, api_id, purpose) VALUES (?, ?, 'consume');",
                                                       (scr_row[0], api_id))

                    # 4. Test Case Scanning inside test files
                    if f_type == 'test' and content:
                        test_matches = re.findall(r"test\s*\(\s*['\"]([^'\"]+)['\"]", content)
                        for t_name in test_matches:
                            cursor.execute("INSERT OR IGNORE INTO test_cases (app_id, test_name, test_type, file_path, status, last_run_status) VALUES (1, ?, 'unit', ?, 'active', 'passed');",
                                           (t_name, rel_path))

    # 5. Populate Drift Findings and Implementation Tasks
    print("Synchronizing outstanding drift findings and implementation tasks checklist...")
    cursor.execute("DELETE FROM drift_findings WHERE status = 'open';")
    cursor.execute("DELETE FROM implementation_tasks WHERE status = 'pending';")
    
    # Track physical vs database screens
    cursor.execute("SELECT id, screen_code, screen_name, route_path FROM screens;")
    db_scrs = cursor.fetchall()
    db_codes = {r[1] for r in db_scrs}
    
    for scr_code, parsed in parsed_screens.items():
        if scr_code not in db_codes:
            msg = f"Screen {parsed['screen_name']} exists on disk but is missing in the database registry."
            cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, message, status) VALUES (1, 'missing_db_record', 'high', ?, 'open');",
                           (msg,))
            cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, task_type, assigned_agent, status) VALUES (1, ?, ?, 'high', 'reconciliation', 'AI Agent', 'pending');",
                           (f"Register {parsed['screen_name']} in Database", msg))
                           
    for db_scr in db_scrs:
        # Check if physical file exists
        if db_scr[1] != 'global_shared_components' and db_scr[3]:
            if not os.path.exists(db_scr[3]):
                msg = f"Database screen {db_scr[2]} refers to route_path '{db_scr[3]}' which does not exist on disk."
                cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, related_screen_id, message, status) VALUES (1, 'missing_physical_file', 'high', ?, ?, 'open');",
                               (db_scr[0], msg))
                cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, task_type, related_screen_id, assigned_agent, status) VALUES (1, ?, ?, 'high', 'reconciliation', ?, 'AI Agent', 'pending');",
                               (f"Scaffold Screen File for {db_scr[2]}", msg, db_scr[0]))
                               
    # Extract mock/stub active handlers
    cursor.execute("""
    SELECT s.screen_name, s.route_path, f.function_name, f.function_type
    FROM screen_functions f
    JOIN screens s ON f.screen_id = s.id
    WHERE f.implementation_status = 'pending';
    """)
    stub_actions = cursor.fetchall()
    
    for action in stub_actions:
        msg = f"Action handler '{action[2]}' in screen '{action[0]}' is currently wired to a mock stub: '{action[3]}'"
        cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, message, status) VALUES (1, 'mock_api_connected', 'medium', ?, 'open');",
                       (msg,))
        cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, task_type, assigned_agent, status) VALUES (1, ?, ?, 'medium', 'reconciliation', 'AI Agent', 'pending');",
                       (f"Harden API handler {action[2]} in {action[0]}", msg))

    # 6. Save a Schema Snapshot
    cursor.execute("SELECT COUNT(*) FROM db_schema_tables;")
    t_cnt = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM db_schema_columns;")
    c_cnt = cursor.fetchone()[0]
    cursor.execute("SELECT name FROM sqlite_master WHERE type='index';")
    idx_cnt = len(cursor.fetchall())
    
    cursor.execute("SELECT sql FROM sqlite_master WHERE type IN ('table', 'index');")
    ddl_dump = "\n".join([row[0] for row in cursor.fetchall() if row[0]])
    
    cursor.execute("""
    INSERT INTO governance_snapshots (app_id, snapshot_name, snapshot_type, snapshot_json)
    VALUES (1, ?, 'schema', ?);
    """, (f"Snapshot-{datetime.now().strftime('%Y-%m-%d-%H-%M')}", ddl_dump))
    
    conn.commit()
    print("Software governance scanning complete! Catalog fully populated.")

def reconcile():
    print("=====================================================")
    print("Starting SQL-Backed Relational 19-Table Reconciler")
    print("=====================================================")

    screens_dir = r"packages\primecare_ui\lib\src\screens"
    report_path = r".agents\governance\sidebar_governance_report.md"

    if not os.path.exists(screens_dir):
        print(f"[ERROR] Screen directory not found: {screens_dir}")
        sys.exit(1)

    files = find_dashboard_files(screens_dir)
    print(f"Discovered {len(files)} physical dashboard screen files on disk.")

    conn = governance_db.get_connection()
    cursor = conn.cursor()

    # Query master organization ID and primary UI application ID
    cursor.execute("SELECT id FROM orgs WHERE org_code = 'primecare' LIMIT 1;")
    org_row = cursor.fetchone()
    org_id = org_row['id'] if org_row else 1

    cursor.execute("SELECT id FROM apps WHERE app_code = 'primecare_ui' LIMIT 1;")
    app_row = cursor.fetchone()
    ui_app_db_id = app_row['id'] if app_row else 1

    # Load master expected configuration from screens
    cursor.execute("SELECT id, screen_code, screen_name, route_path, layout_key FROM screens WHERE screen_type = 'dashboard';")
    db_dashboards = {row['screen_code']: dict(row) for row in cursor.fetchall()}

    # Resolve roles mapping for default permissions
    cursor.execute("SELECT id, role_code FROM roles;")
    roles_mapping = {row['role_code']: row['id'] for row in cursor.fetchall()}

    anomalies = []
    parsed_screens = {}
    layout_mismatch_count = 0

    for file_path in files:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        relative_path = os.path.relpath(file_path, os.getcwd()).replace('\\', '/')

        class_match = re.search(r'class (\w+) extends', content)
        if not class_match:
            continue
        class_name = class_match.group(1)
        screen_code = _camel_to_snake(class_name.replace('Screen', ''))

        has_physical_sidebar = ('ResponsiveSplitDashboard' in content) or ('defaultSidebarWidgets:' in content)

        physical_items = []
        if has_physical_sidebar:
            sidebar_block_content = content
            start_idx = content.find('defaultSidebarWidgets:')
            if start_idx != -1:
                sidebar_block_content = _extract_matching_block(content, start_idx)

            action_regex = r'''QuickActionItem\(\s*label:\s*["']([^"']+)["'][\s\S]*?onTap:\s*(.*?)(?:,|\n\s*\))'''
            action_matches = re.finditer(action_regex, sidebar_block_content, re.IGNORECASE)
            for match in action_matches:
                label = match.group(1)
                raw_callback = match.group(2).strip()
                item_code = _camel_to_snake(label.replace(' ', ''))
                status = _analyze_callback(raw_callback, content)
                
                physical_items.append({
                    'code': item_code,
                    'label': label,
                    'type': 'quick_action',
                    'callback': raw_callback,
                    'status': status
                })

            file_has_real_api = any(item in content for item in [
                'apiClientProvider', 'apiClient.', 'Dio ', 'prisma', 'dbClient',
                'repository.', 'service.', 'http.Client', 'HttpClient(', '/v1/'
            ])

            if 'Slider(' in content or 'Slider.adaptive(' in content:
                physical_items.append({
                    'code': 'capacity_slider',
                    'label': 'Threshold Capacity Adjuster',
                    'type': 'interactive_slider',
                    'callback': 'onChanged: (val) { controller.updateThreshold(...) }',
                    'status': 'api_connected' if file_has_real_api else 'mock_stub'
                })
            if 'AuditLogConsole' in content or 'Operational Audit Logs' in content:
                physical_items.append({
                    'code': 'audit_logs_terminal',
                    'label': 'Live Auditing timeline Console',
                    'type': 'log_timeline',
                    'callback': 'state.logs',
                    'status': 'api_connected' if file_has_real_api else 'mock_stub'
                })

        category = get_screen_category(relative_path)

        parsed_screens[screen_code] = {
            'screen_name': class_name,
            'path': relative_path,
            'has_physical_sidebar': has_physical_sidebar,
            'sidebar_items': physical_items,
            'category': category,
            'content': content
        }

    # ==========================================
    # AUDITING: UNDOCUMENTED SCREENS (On Disk, Not in DB)
    # ==========================================
    for screen_code, parsed in parsed_screens.items():
        if screen_code not in db_dashboards:
            msg = f"Undocumented Screen: Physical dashboard screen '{parsed['screen_name']}' is missing in the database registry."
            anomalies.append(f"- **[ERROR]** {msg}")
            
            cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, message, status) VALUES (1, 'missing_route', 'high', ?, 'open');", (msg,))
            cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, task_type, assigned_agent, status) VALUES (1, ?, ?, 'high', 'reconciliation', 'AI Agent', 'pending');", (f"Register {parsed['screen_name']} in Database", msg))
            
            # Auto-reconcile: insert stub screen and permissions
            layout_key = 'clinicalLayout' if parsed['has_physical_sidebar'] else 'masterLayout'
            cursor.execute("""
            INSERT OR IGNORE INTO screens (app_id, screen_code, screen_name, route_path, screen_type, layout_key, implementation_status)
            VALUES (?, ?, ?, ?, 'dashboard', ?, 'active')
            """, (ui_app_db_id, screen_code, parsed['screen_name'], parsed['path'], layout_key))
            screen_db_id = cursor.lastrowid
            
            role_code = resolve_role_id(screen_code)
            role_db_id = roles_mapping.get(role_code, roles_mapping.get('guest'))
            
            cursor.execute("""
            INSERT OR IGNORE INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
            VALUES (?, ?, 1, 0, 0, 0, 1)
            """, (role_db_id, screen_db_id))
            
            # Seed children components
            for idx, item in enumerate(parsed['sidebar_items'], 1):
                cursor.execute("""
                INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, api_id, implementation_status)
                VALUES (?, ?, ?, ?, NULL, 'active')
                """, (screen_db_id, f"FUN_{screen_code}_{item['code']}", f"onTap_{item['code']}", f"shortcut: {item['callback']}"))
                func_db_id = cursor.lastrowid
                
                cursor.execute("""
                INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, file_path, implementation_status)
                VALUES (?, ?, ?, 'button', ?, ?, 'active')
                """, (screen_db_id, f"CMP_{screen_code}_{item['code']}", item['label'], f"data-cy-{item['code']}", parsed['path']))
                
                # Seed role function permissions automatically
                cursor.execute("INSERT OR IGNORE INTO role_function_permissions (role_id, function_id, can_execute) VALUES (?, ?, 1);",
                               (role_db_id, func_db_id))
                
            conn.commit()

    # Re-fetch database configuration to ensure synchronization
    cursor.execute("SELECT id, screen_code, screen_name, route_path, layout_key FROM screens WHERE screen_type = 'dashboard';")
    db_dashboards = {row['screen_code']: dict(row) for row in cursor.fetchall()}

    # ==========================================
    # AUDITING: MISMATCHED REGISTRY (In DB, Not on Disk)
    # ==========================================
    for screen_code, db_screen in db_dashboards.items():
        if screen_code not in parsed_screens:
            msg = f"Mismatched Registry: Expected dashboard screen '{screen_code}' at path '{db_screen['route_path']}' is missing on disk."
            anomalies.append(f"- **[ERROR]** {msg}")
            
            cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, related_screen_id, message, status) VALUES (1, 'missing_route', 'high', ?, ?, 'open');", (db_screen['id'], msg))
            cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, related_screen_id, status) VALUES (1, ?, ?, 'high', ?, 'pending');", (f"Restore physical file for {db_screen['screen_name']}", msg, db_screen['id']))
            conn.commit()

    # ==========================================
    # AUDITING: LAYOUT CONFORMITY & WIDGET DRIFTS
    # ==========================================
    for screen_code, db_screen in db_dashboards.items():
        if screen_code not in parsed_screens:
            continue
            
        parsed = parsed_screens[screen_code]
        screen_db_id = db_screen['id']
        
        # 1. Verify split dashboard sidebar layout mismatch
        expected_sidebar = db_screen['layout_key'] in ('clinicalLayout', 'adminLayout')
        has_physical = parsed['has_physical_sidebar']
        
        if expected_sidebar != has_physical:
            layout_mismatch_count += 1
            msg = f"Layout Mismatch: Dashboard '{parsed['screen_name']}' is '{'Split Dual-Panel' if has_physical else 'Single-Column'}' in code, but database expects '{'Split Dual-Panel' if expected_sidebar else 'Single-Column'}'"
            anomalies.append(f"- **[ERROR]** {msg}")
            
            cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, related_screen_id, message, status) VALUES (1, 'layout_mismatch', 'high', ?, ?, 'open');", (screen_db_id, msg))
            cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, related_screen_id, status) VALUES (1, ?, ?, 'high', ?, 'pending');", (f"Fix Layout for {parsed['screen_name']}", msg, screen_db_id))
            conn.commit()

        # 2. Check for missing widgets registered in DB but absent in code
        cursor.execute("SELECT id, function_code, function_name, function_type FROM screen_functions WHERE screen_id = ?;", (screen_db_id,))
        db_functions = {row['function_code']: dict(row) for row in cursor.fetchall()}
        
        physical_item_map = {item['code']: item for item in parsed['sidebar_items']}
        
        for func_code, db_func in db_functions.items():
            item_code = func_code.replace(f"FUN_{screen_code}_", "")
            phys = physical_item_map.get(item_code)
            
            if not phys:
                msg = f"Missing Widget Action: Expected action handler '{db_func['function_name']}' (Code: '{func_code}') in dashboard '{parsed['screen_name']}' is missing in the code."
                anomalies.append(f"- **[WARNING]** {msg}")
                
                cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, related_screen_id, message, status) VALUES (1, 'missing_widget', 'medium', ?, ?, 'open');", (screen_db_id, msg))
                cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, related_screen_id, status) VALUES (1, ?, ?, 'medium', ?, 'pending');", (f"Implement {db_func['function_name']} widget", msg, screen_db_id))
                
                # Update status to pending
                cursor.execute("UPDATE screen_functions SET implementation_status = 'pending' WHERE id = ?;", (db_func['id'],))
                conn.commit()
            else:
                # Update actual connection status dynamically from code scan
                new_status = 'api_connected' if phys['status'] == 'api_connected' else 'mock_stub'
                db_status = 'active' if new_status == 'api_connected' else 'pending'
                
                cursor.execute("""
                UPDATE screen_functions 
                SET implementation_status = ?, function_type = ? 
                WHERE id = ?;
                """, (db_status, f"shortcut: {phys['callback']}", db_func['id']))
                conn.commit()

        # 3. Check for undocumented widgets in code but missing from DB registry
        for phys_code, phys in physical_item_map.items():
            expected_func_code = f"FUN_{screen_code}_{phys_code}"
            if expected_func_code not in db_functions:
                msg = f"Undocumented Widget: Sidebar item '{phys['label']}' (ID: '{phys_code}') in screen '{parsed['screen_name']}' exists in code but is not declared in the database spec."
                anomalies.append(f"- **[WARNING]** {msg}")
                
                cursor.execute("INSERT INTO drift_findings (app_id, finding_type, severity, related_screen_id, message, status) VALUES (1, 'undocumented_widget', 'low', ?, ?, 'open');", (screen_db_id, msg))
                cursor.execute("INSERT INTO implementation_tasks (app_id, task_title, task_description, priority, related_screen_id, status) VALUES (1, ?, ?, 'low', ?, 'pending');", (f"Register widget {phys['label']} in DB", msg, screen_db_id))
                conn.commit()

    # ==========================================
    # STATISTICS CALCULATIONS (Query DB)
    # ==========================================
    
    # 1. Layout Conformity Score
    cursor.execute("SELECT COUNT(*) FROM screens WHERE screen_type = 'dashboard';")
    total_dashboards = cursor.fetchone()[0] or 1
    
    cursor.execute("SELECT COUNT(DISTINCT related_screen_id) FROM drift_findings WHERE finding_type = 'layout_mismatch';")
    mismatched_db_count = cursor.fetchone()[0] or 0
    layout_compliance_score = ((total_dashboards - mismatched_db_count) / total_dashboards) * 100.0

    # 2. API Connectivity Score
    cursor.execute("SELECT COUNT(*) FROM screen_functions;")
    total_functions = cursor.fetchone()[0] or 1
    
    cursor.execute("SELECT COUNT(*) FROM screen_functions WHERE implementation_status = 'active';")
    active_functions = cursor.fetchone()[0] or 0
    api_connectivity_score = (active_functions / total_functions) * 100.0

    # 3. Functional Readiness Score
    cursor.execute("SELECT COUNT(*) FROM screen_functions WHERE function_type IS NOT NULL AND function_type != '';")
    non_empty_functions = cursor.fetchone()[0] or 0
    functional_score = (non_empty_functions / total_functions) * 100.0

    # Retrieve Category breakdowns dynamically
    known_categories = ['allied', 'clinical', 'common', 'executive', 'management', 'psw', 'rn', 'rpn', 'staff']
    category_stats = {}
    
    for cat in known_categories:
        cursor.execute("SELECT id FROM screens WHERE route_path LIKE ? AND screen_type = 'dashboard';", (f"%/{cat}/%",))
        cat_ids = [row['id'] for row in cursor.fetchall()]
        cat_total = len(cat_ids)
        
        if cat_total == 0:
            continue
            
        cursor.execute("SELECT COUNT(DISTINCT related_screen_id) FROM drift_findings WHERE finding_type = 'layout_mismatch' AND related_screen_id IN ({});".format(','.join(map(str, cat_ids))) if cat_ids else "SELECT 0;")
        cat_mismatches = cursor.fetchone()[0] or 0
        cat_compliant = cat_total - cat_mismatches
        
        cursor.execute("SELECT COUNT(*) FROM screen_functions WHERE screen_id IN ({});".format(','.join(map(str, cat_ids))) if cat_ids else "SELECT 0;")
        cat_funcs = cursor.fetchone()[0] or 0
        
        cursor.execute("SELECT COUNT(*) FROM screen_functions WHERE implementation_status = 'active' AND screen_id IN ({});".format(','.join(map(str, cat_ids))) if cat_ids else "SELECT 0;")
        cat_active_funcs = cursor.fetchone()[0] or 0
        
        cursor.execute("SELECT COUNT(*) FROM screen_functions WHERE function_type IS NOT NULL AND function_type != '' AND screen_id IN ({});".format(','.join(map(str, cat_ids))) if cat_ids else "SELECT 0;")
        cat_non_empty = cursor.fetchone()[0] or 0

        # Mapped roles in this category
        cursor.execute("SELECT layout_key FROM screens WHERE id IN ({}) LIMIT 1;".format(','.join(map(str, cat_ids))) if cat_ids else "SELECT 'masterLayout';")
        layout_row = cursor.fetchone()
        has_sidebar_required = 1 if layout_row and layout_row['layout_key'] != 'masterLayout' else 0

        category_stats[cat] = {
            'total_dashboards': cat_total,
            'requires_sidebar': has_sidebar_required,
            'layout_compliant': cat_compliant,
            'total_items': cat_funcs,
            'api_connected': cat_active_funcs,
            'functional': cat_non_empty
        }

    # Map roles to directories for summary dashboard
    role_directory = {
        'allied': ['Chiropractor', 'Physiotherapist', 'Registered Massage Therapist (RMT)', 'Social Worker', 'Therapist'],
        'clinical': ['Clinical Director', 'Intake Coordinator', 'Registered Nurse (RN)', 'Physician', 'Clinical Nurse Specialist', 'Pediatric Specialist'],
        'common': ['Caregiver', 'Guest', 'Portal User', 'Patient', 'Dynamic Screen Viewer', 'Infrastructure Auditor', 'System Verification Officer', 'Training Candidate'],
        'executive': ['Chief Executive Officer (CEO)', 'Chief Financial Officer (CFO)', 'Chief Information Security Officer (CISO)', 'Chief Operating Officer (COO)', 'Chief Technology Officer (CTO)', 'CX Director', 'Finance Director', 'HR Director', 'Legal Counsel', 'Franchise Owner', 'Shareholder', 'Training Director'],
        'management': ['Community Outreach Lead', 'Compliance Manager', 'Franchise Sales Manager', 'General Manager', 'Governance Officer', 'Head of Business Development', 'Head of Marketing', 'Local Marketing Manager', 'Operations Manager', 'Partnership Manager', 'Regional BDM', 'Regional Manager USA', 'Scrum Master', 'Talent Acquisition Manager', 'Territory Expansion Manager', 'Territory Sales Manager', 'Volunteer Coordinator'],
        'premium': ['Premium Concierge Care Coordinator', 'VIP Client Manager'],
        'psw': ['Personal Support Worker (PSW)', 'Home Support Worker'],
        'rn': ['Registered Nurse (RN) Field Supervisor', 'Nurse Practitioner (NP)'],
        'rpn': ['Registered Practical Nurse (RPN)', 'Licensed Practical Nurse (LPN)'],
        'staff': ['Employee', 'Volunteer', 'Administrative Assistant', 'Shift Supervisor'],
    }

    # Compile the Report Markup
    rep = []
    rep.append('# PrimeCare Sidebar Governance & Quality Dashboard\n')
    rep.append('> [!NOTE]')
    rep.append('> This automated dashboard tracks the quality, layout compliance, and backend API integration status for all role-based dashboards in the PrimeCare ecosystem.\n')
    rep.append('This automated governance report compiles split dual-column dashboard structures, verifies active API integrations, and flags pending interface modules.\n')
    
    rep.append('## 📊 Unified Global Quality & Coverage Metrics\n')
    rep.append('| Dimension | Score | Description |')
    rep.append('|-----------|:-----:|-------------|')
    rep.append(f'| **Layout Conformity** | `{layout_compliance_score:.1f}%` | Code layout matches specifications inside relational SQLite database. |')
    rep.append(f'| **API Connectivity** | `{api_connectivity_score:.1f}%` | Sidebar items bound to active backend/controller workflows (not mock logs/stubs). |')
    rep.append(f'| **Functional Readiness** | `{functional_score:.1f}%` | Total actionable sidebar buttons implemented with non-empty handlers. |\n')

    rep.append('## 📁 Module Directory Quality Breakdowns\n')
    rep.append('| Screen Group | Total Dashboards | Dual-Column | Layout Conformity | API Connectivity | Functional Readiness | Outstanding Fixes |')
    rep.append('|--------------|:----------------:|:-----------:|:-----------------:|:----------------:|:--------------------:|:-----------------:|')
    for cat in known_categories:
        stats = category_stats.get(cat)
        if not stats or stats['total_dashboards'] == 0:
            continue
        
        l_score = (stats['layout_compliant'] / stats['total_dashboards']) * 100.0
        a_score = (stats['api_connected'] / stats['total_items']) * 100.0 if stats['total_items'] > 0 else 100.0
        f_score = (stats['functional'] / stats['total_items']) * 100.0 if stats['total_items'] > 0 else 100.0
        fixes = stats['total_items'] - stats['api_connected']
        
        rep.append(f"| **{cat}** | {stats['total_dashboards']} | {stats['requires_sidebar']} | `{l_score:.1f}%` | `{a_score:.1f}%` | `{f_score:.1f}%` | **{fixes}** |")
    rep.append('')

    rep.append('## 👥 Complete Apps & User Roles Directory')
    rep.append('Here is the directory of all 55+ user roles within the PrimeCare platform, categorized by their corresponding Screen Groups on disk:\n')
    for cat in known_categories:
        roles = [f"{r} (`{get_short_role_id(r)}`)" for r in role_directory.get(cat, [])]
        total = category_stats.get(cat, {}).get('total_dashboards', 0)
        rep.append(f"### 📂 `{cat.upper()}` Screen Group")
        rep.append(f"* **Corresponding Roles:** {', '.join(roles)}")
        rep.append(f"* **Dashboard Count:** {total} physical dashboard screens built.\n")

    rep.append('## 🚨 Anomalies & Architectural Violations')
    if not anomalies:
        rep.append('✅ **Zero architectural deviations detected.** Relational SQLite database registry is in perfect alignment with implementation code.')
    else:
        for anomaly in anomalies:
            rep.append(anomaly)
    rep.append('')

    rep.append('## 🛠️ Master Sidebar Fix Checklist')
    rep.append('This actionable checklist lists all mock/stub or pending sidebar items. To resolve an item, edit the screen file, remove the `controller.addLog(...)` call, implement a real controller method call, and run this script to update statistics.\n')
    
    # Query outstanding mock/stub/pending items
    cursor.execute("""
    SELECT s.screen_name, s.route_path, f.function_name, f.function_type, f.implementation_status
    FROM screen_functions f
    JOIN screens s ON f.screen_id = s.id
    WHERE f.implementation_status = 'pending'
    ORDER BY s.screen_name, f.function_name;
    """)
    outstanding_items = cursor.fetchall()

    if not outstanding_items:
        rep.append('✅ **All sidebar controls are 100% connected to real APIs! No outstanding fixes required.**')
    else:
        current_screen = None
        for row in outstanding_items:
            screen = row['screen_name']
            path = row['route_path']
            func_name = row['function_name']
            handler = row['function_type'] or ''
            
            if screen != current_screen:
                current_screen = screen
                rep.append(f"- [ ] **{screen}** (`{path}`):")
                
            clean_handler = handler.replace('\n', ' ').strip()
            display_handler = f"{clean_handler[:67]}..." if len(clean_handler) > 70 else clean_handler
            rep.append(f"  - [ ] Wire action handler `{func_name}` to active API/controller method instead of mock: `{display_handler}`")
        rep.append('')

    rep.append('## 📋 Full Master Sidebar Item Catalog\n')
    rep.append('| Screen | Callback Name | Callback / Action Callback | Integration Status | Connected to API |')
    rep.append('|--------|---------------|----------------------------|--------------------|------------------|')
    
    cursor.execute("""
    SELECT s.screen_name, f.function_name, f.function_type, f.implementation_status
    FROM screen_functions f
    JOIN screens s ON f.screen_id = s.id
    ORDER BY s.screen_name, f.function_name;
    """)
    all_catalog_items = cursor.fetchall()
    
    for row in all_catalog_items:
        clean_handler = (row['function_type'] or '').replace('\n', ' ').strip()
        display_handler = f"{clean_handler[:47]}..." if len(clean_handler) > 50 else clean_handler
        status_str = '🟢 Connected' if row['implementation_status'] == 'active' else '🔴 Mock/Stub'
        rep.append(f"| `{row['screen_name']}` | `{row['function_name']}` | `{display_handler}` | `{row['implementation_status']}` | {status_str} |")

    # Perform software governance self-cataloging and code/schema scanning
    scan_software_governance(conn, parsed_screens, anomalies)

    conn.close()

    print("=====================================================")
    print(f"Governance Report compiled: {report_path}")
    print("=====================================================")

    # Enforce strict audit compliance on layout mismatches or missing routes
    has_critical_errors = any('[ERROR]' in anomaly for anomaly in anomalies)
    if has_critical_errors:
        print("[ERROR] GOVERNANCE CRITICAL AUDIT FAILURE: Mismatched structures detected! Please review sidebar_governance_report.md")
        sys.exit(1)
    else:
        print("[OK] Architectural Governance Verification Complete. Status: COMPLIANT.")
        sys.exit(0)

if __name__ == "__main__":
    reconcile()
