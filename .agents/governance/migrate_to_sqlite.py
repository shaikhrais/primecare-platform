import sqlite3
import sys
import os
import json
import re

# Add local directory to path to import governance_db
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

def find_dashboard_files(screens_dir):
    files = []
    for root, _, filenames in os.walk(screens_dir):
        for name in filenames:
            name_lower = name.lower()
            if name_lower.endswith('_dashboard_screen.dart') or name_lower.endswith('_dashboard.dart'):
                files.append(os.path.join(root, name))
    return files

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

def get_short_app_id(app_id):
    mapping = {
        'primecare_ui': 'ui',
        'web-admin': 'wa',
        'primecare_auth': 'au',
        'primecare_business_development': 'bd',
        'primecare_client': 'cl',
        'primecare_clinic': 'ci',
        'primecare_corporate': 'co',
        'primecare_enterprise_blueprint': 'eb',
        'primecare_franchise': 'fr',
        'primecare_governance': 'go',
        'primecare_marketing': 'ma',
        'primecare_support': 'su',
        'worker-api': 'wo',
        'api_gateway': 'gw',
        'auth_api': 'at',
        'billing_api': 'bi',
        'client_api': 'ca',
        'compliance_api': 'cp',
        'franchise_reporting_api': 'fa',
        'governance_api': 'gv',
        'notes_api': 'no',
        'notification_api': 'nt',
        'provider_api': 'pr',
        'scheduling_api': 'sc',
        'verification_api': 've',
        'visit_api': 'vi',
        'contracts': 'cn',
        'database': 'db',
        'database_client': 'dc',
        'domain': 'dm',
        'factory_system': 'fs',
        'flutter_core': 'fc',
        'infrastructure': 'if',
        'messaging': 'me',
        'security': 'sy'
    }
    return mapping.get(app_id, app_id[:2].lower())

def get_app_platform(app_id, type_val):
    if app_id == 'web-admin':
        return 'admin'
    elif app_id == 'primecare_ui' or type_val == 'app':
        return 'mobile'
    elif type_val in ('service', 'package'):
        return 'worker'
    return 'web'

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

def migrate():
    print("=====================================================")
    print("Starting PrimeCare Registries to 12-Table SQLite Seeding")
    print("=====================================================")

    # Initialize SQLite schemas
    governance_db.init_db(force_reset=True)
    conn = governance_db.get_connection()
    cursor = conn.cursor()
    cursor.execute("PRAGMA foreign_keys = OFF;")

    # 1. Seed orgs
    print("Seeding Organization...")
    cursor.execute("""
    INSERT INTO orgs (org_code, org_name, status)
    VALUES ('primecare', 'PrimeCare Platform', 'active')
    """)
    org_id = cursor.lastrowid

    # 2. Seed offices
    print("Seeding Offices...")
    offices_list = [
        ('corp', 'PrimeCare Corporate HQ', 'corporate'),
        ('franchise', 'Franchise Partner Network', 'franchise'),
        ('clinic', 'Core Multi-Disciplinary Clinic', 'clinic'),
        ('support', 'Operations & Support Hub', 'support')
    ]
    for code, name, type_val in offices_list:
        cursor.execute("""
        INSERT INTO offices (org_id, office_code, office_name, office_type, status)
        VALUES (?, ?, ?, ?, 'active')
        """, (org_id, code, name, type_val))

    # 3. Discover and seed apps
    print("Seeding Apps...")
    core_apps = [
        ('primecare_ui', 'PrimeCare UI Client', 'package', 'Flutter role-based client app.'),
        ('web-admin', 'Web Admin Console', 'ui', 'Next.js administrative workspace.')
    ]
    
    apps_mapping = {}  # short_code -> DB ID
    
    for app_id, name, type_val, desc in core_apps:
        short_app_id = get_short_app_id(app_id)
        platform = get_app_platform(app_id, type_val)
        cursor.execute("""
        INSERT INTO apps (org_id, app_code, app_name, platform, status)
        VALUES (?, ?, ?, ?, 'active')
        """, (org_id, short_app_id, name, platform))
        apps_mapping[short_app_id] = cursor.lastrowid

    # Discover additional UI Apps in apps/
    apps_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "..", "apps")
    if os.path.exists(apps_dir):
        for entry in os.listdir(apps_dir):
            entry_path = os.path.join(apps_dir, entry)
            if os.path.isdir(entry_path):
                app_id = entry
                short_app_id = get_short_app_id(app_id)
                name = entry.replace('_', ' ').replace('-', ' ').title()
                type_val = 'service' if app_id == 'worker-api' else 'app'
                platform = get_app_platform(app_id, type_val)
                cursor.execute("""
                INSERT OR IGNORE INTO apps (org_id, app_code, app_name, platform, status)
                VALUES (?, ?, ?, ?, 'active')
                """, (org_id, short_app_id, name, platform))
                if short_app_id not in apps_mapping:
                    apps_mapping[short_app_id] = cursor.lastrowid

    # Discover shared packages in packages/
    packages_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "..", "packages")
    if os.path.exists(packages_dir):
        for entry in os.listdir(packages_dir):
            entry_path = os.path.join(packages_dir, entry)
            if os.path.isdir(entry_path):
                app_id = entry
                short_app_id = get_short_app_id(app_id)
                name = entry.replace('_', ' ').replace('-', ' ').title()
                type_val = 'service' if app_id == 'worker-api' else 'package'
                platform = get_app_platform(app_id, type_val)
                cursor.execute("""
                INSERT OR IGNORE INTO apps (org_id, app_code, app_name, platform, status)
                VALUES (?, ?, ?, ?, 'active')
                """, (org_id, short_app_id, name, platform))
                if short_app_id not in apps_mapping:
                    apps_mapping[short_app_id] = cursor.lastrowid

    # Discover API services in services/
    services_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "..", "services")
    if os.path.exists(services_dir):
        for entry in os.listdir(services_dir):
            entry_path = os.path.join(services_dir, entry)
            if os.path.isdir(entry_path):
                app_id = entry
                short_app_id = get_short_app_id(app_id)
                name = entry.replace('_', ' ').replace('-', ' ').title()
                if "Api" not in name:
                    name = f"{name} API"
                platform = 'worker'
                cursor.execute("""
                INSERT OR IGNORE INTO apps (org_id, app_code, app_name, platform, status)
                VALUES (?, ?, ?, ?, 'active')
                """, (org_id, short_app_id, name, platform))
                if short_app_id not in apps_mapping:
                    apps_mapping[short_app_id] = cursor.lastrowid

    # 4. Seed roles
    print("Seeding Roles...")
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

    # Category to role level
    level_map = {
        'common': 1,
        'staff': 2,
        'psw': 2,
        'allied': 2,
        'rpn': 2,
        'rn': 3,
        'clinical': 3,
        'management': 3,
        'premium': 3,
        'executive': 4
    }

    roles_mapping = {}  # role_code -> DB ID

    for cat, roles_list in role_directory.items():
        role_lvl = level_map.get(cat, 1)
        for role_name in roles_list:
            role_code = get_short_role_id(role_name)
            cursor.execute("""
            INSERT INTO roles (org_id, role_code, role_name, role_level, status)
            VALUES (?, ?, ?, ?, 'active')
            """, (org_id, role_code, role_name, role_lvl))
            roles_mapping[role_code] = cursor.lastrowid

    # 5. Seed App Role Access (app_roles)
    print("Seeding App Roles Matrix...")
    ui_app_db_id = apps_mapping.get('ui')
    wa_app_db_id = apps_mapping.get('wa')
    
    for role_code, role_db_id in roles_mapping.items():
        # Allow access to UI Client App
        if ui_app_db_id:
            cursor.execute("""
            INSERT INTO app_roles (app_id, role_id, can_access)
            VALUES (?, ?, 1)
            """, (ui_app_db_id, role_db_id))
        # Allow access to Web Admin App for executive/management/clinical/staff groups
        if wa_app_db_id:
            can_admin = 1 if role_code in ('ceo', 'cto', 'cfo', 'coo', 'ciso', 'governance', 'admin', 'compliance', 'ops_manager', 'regional_manager_usa') else 0
            cursor.execute("""
            INSERT INTO app_roles (app_id, role_id, can_access)
            VALUES (?, ?, ?)
            """, (wa_app_db_id, role_db_id, can_admin))

    # 6. Dynamically parse and seed Screens & Sidebar Items
    screens_dir = r"packages\primecare_ui\lib\src\screens"
    
    screens_seeded = 0
    sidebars_seeded = 0
    funcs_seeded = 0
    comps_seeded = 0
    links_seeded = 0

    if os.path.exists(screens_dir):
        print(f"Dynamically parsing sidebar dashboards from disk: {screens_dir}...")
        files = find_dashboard_files(screens_dir)
        print(f"Discovered {len(files)} physical dashboard screen files on disk during seeding.")
        
        for file_path in files:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Windows/Linux normalization
            relative_path = os.path.relpath(file_path, os.getcwd()).replace('\\', '/')
            
            # Extract class name
            class_match = re.search(r'class (\w+) extends', content)
            if not class_match:
                continue
            class_name = class_match.group(1)
            screen_code = _camel_to_snake(class_name.replace('Screen', ''))
            
            requires_sidebar = 1 if ('ResponsiveSplitDashboard' in content) or ('defaultSidebarWidgets:' in content) else 0
            
            # Extract category from file path
            parts = relative_path.split('/')
            category = parts[5] if len(parts) >= 6 else "common"
            role_code = resolve_role_id(screen_code)
            role_db_id = roles_mapping.get(role_code, roles_mapping.get('guest'))
            
            # Determine premium layout_key based on category
            layout_key = 'masterLayout'
            if category in ('clinical', 'rn', 'rpn', 'allied', 'psw'):
                layout_key = 'clinicalLayout'
            elif category in ('executive', 'management'):
                layout_key = 'adminLayout'

            # 6a. Insert Screen
            cursor.execute("""
            INSERT INTO screens (app_id, screen_code, screen_name, route_path, screen_type, layout_key, status)
            VALUES (?, ?, ?, ?, 'dashboard', ?, 'active')
            """, (ui_app_db_id, screen_code, class_name, relative_path, layout_key))
            screen_db_id = cursor.lastrowid
            screens_seeded += 1

            # 6b. Seed Zero-Trust Role Route Permission
            cursor.execute("""
            INSERT INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
            VALUES (?, ?, 1, 1, 1, 1, 1)
            """, (role_db_id, screen_db_id))
            
            # Give Super Admin, CEO and CTO view permissions to all screens (Governance best practices)
            for super_role in ('ceo', 'cto', 'admin'):
                super_role_db_id = roles_mapping.get(super_role)
                if super_role_db_id and super_role_db_id != role_db_id:
                    cursor.execute("""
                    INSERT OR IGNORE INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
                    VALUES (?, ?, 1, 0, 0, 0, 1)
                    """, (super_role_db_id, screen_db_id))

            # 6c. Seed Parent Sidebar Menu Item
            icon_name = 'stethoscope' if layout_key == 'clinicalLayout' else ('shield' if layout_key == 'adminLayout' else 'home')
            cursor.execute("""
            INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
            VALUES (?, NULL, ?, ?, ?, 0, 1)
            """, (ui_app_db_id, screen_db_id, f"navigation.items.{screen_code}", icon_name))
            parent_sidebar_id = cursor.lastrowid
            sidebars_seeded += 1
            
            # If dashboard requires sidebar, parse sidebar sub-items
            if requires_sidebar:
                sidebar_block_content = content
                start_idx = content.find('defaultSidebarWidgets:')
                if start_idx != -1:
                    sidebar_block_content = _extract_matching_block(content, start_idx)
                
                # Parse QuickActionItems
                action_regex = r'''QuickActionItem\(\s*label:\s*["']([^"']+)["'][\s\S]*?onTap:\s*(.*?)(?:,|\n\s*\))'''
                action_matches = re.finditer(action_regex, sidebar_block_content, re.IGNORECASE)
                for idx, match in enumerate(action_matches, 1):
                    label = match.group(1)
                    raw_callback = match.group(2).strip()
                    item_code = _camel_to_snake(label.replace(' ', ''))
                    status_val = _analyze_callback(raw_callback, content)
                    
                    # Insert child sidebar menu button
                    cursor.execute("""
                    INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
                    VALUES (?, ?, ?, ?, 'play', ?, 1)
                    """, (ui_app_db_id, parent_sidebar_id, screen_db_id, label, idx))
                    sidebars_seeded += 1

                    # Insert Function
                    cursor.execute("""
                    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, description, status)
                    VALUES (?, ?, ?, 'shortcut', ?, 'active')
                    """, (screen_db_id, f"FUN_{screen_code}_{item_code}", f"onTap_{item_code}", raw_callback))
                    func_db_id = cursor.lastrowid
                    funcs_seeded += 1

                    # Insert Component
                    cursor.execute("""
                    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, sort_order, is_required)
                    VALUES (?, ?, ?, 'button', ?, ?, 0)
                    """, (screen_db_id, f"CMP_{screen_code}_{item_code}", label, f"data-cy-{item_code}", idx))
                    comp_db_id = cursor.lastrowid
                    comps_seeded += 1

                    # Link Function and Component
                    cursor.execute("""
                    INSERT INTO function_components (function_id, component_id)
                    VALUES (?, ?)
                    """, (func_db_id, comp_db_id))
                    links_seeded += 1
                    
                file_has_real_api = any(item in content for item in [
                    'apiClientProvider', 'apiClient.', 'Dio ', 'prisma', 'dbClient',
                    'repository.', 'service.', 'http.Client', 'HttpClient(', '/v1/'
                ])
                
                # Parse Capacity Slider
                if 'Slider(' in content or 'Slider.adaptive(' in content:
                    status_str = 'api_connected' if file_has_real_api else 'mock_stub'
                    
                    cursor.execute("""
                    INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
                    VALUES (?, ?, ?, 'Threshold Capacity Adjuster', 'activity', 10, 1)
                    """, (ui_app_db_id, parent_sidebar_id, screen_db_id))
                    sidebars_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, description, status)
                    VALUES (?, ?, 'onChanged', 'shortcut', 'onChanged: (val) { controller.updateThreshold(...) }', 'active')
                    """, (screen_db_id, f"FUN_{screen_code}_capacity_slider"))
                    func_db_id = cursor.lastrowid
                    funcs_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, sort_order, is_required)
                    VALUES (?, ?, 'Threshold Capacity Adjuster', 'form', 'data-cy-capacity-slider', 10, 1)
                    """, (screen_db_id, f"CMP_{screen_code}_capacity_slider"))
                    comp_db_id = cursor.lastrowid
                    comps_seeded += 1

                    cursor.execute("""
                    INSERT INTO function_components (function_id, component_id)
                    VALUES (?, ?)
                    """, (func_db_id, comp_db_id))
                    links_seeded += 1
                    
                # Parse Audit Logs Console
                if 'AuditLogConsole' in content or 'Operational Audit Logs' in content:
                    status_str = 'api_connected' if file_has_real_api else 'mock_stub'
                    
                    cursor.execute("""
                    INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
                    VALUES (?, ?, ?, 'Live Auditing timeline Console', 'terminal', 20, 1)
                    """, (ui_app_db_id, parent_sidebar_id, screen_db_id))
                    sidebars_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, description, status)
                    VALUES (?, ?, 'renderLogs', 'api_action', 'state.logs', 'active')
                    """, (screen_db_id, f"FUN_{screen_code}_audit_logs"))
                    func_db_id = cursor.lastrowid
                    funcs_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, sort_order, is_required)
                    VALUES (?, ?, 'Live Auditing timeline Console', 'card', 'data-cy-audit-logs', 20, 0)
                    """, (screen_db_id, f"CMP_{screen_code}_audit_logs"))
                    comp_db_id = cursor.lastrowid
                    comps_seeded += 1

                    cursor.execute("""
                    INSERT INTO function_components (function_id, component_id)
                    VALUES (?, ?)
                    """, (func_db_id, comp_db_id))
                    links_seeded += 1

        print(f"[OK] Dynamically parsed and mapped screen hierarchies:")
        print(f"  - Screens: {screens_seeded}")
        print(f"  - Sidebar Menus: {sidebars_seeded}")
        print(f"  - Action Functions: {funcs_seeded}")
        print(f"  - UI Components: {comps_seeded}")
        print(f"  - Function Component Links: {links_seeded}")
    else:
        print("[WARN] packages/primecare_ui/lib/src/screens directory not found, skipping sidebars migration.")

    # 7. Seed Data Entries (Data Governance Memory)
    print("Seeding Data Entries Governance Memory...")
    cursor.execute("SELECT id, screen_code FROM screens WHERE screen_code LIKE '%psw_dashboard%' LIMIT 1;")
    psw_screen = cursor.fetchone()
    psw_screen_id = psw_screen['id'] if psw_screen else 1

    cursor.execute("SELECT id, screen_code FROM screens WHERE screen_code LIKE '%chiropractor_dashboard%' LIMIT 1;")
    chiro_screen = cursor.fetchone()
    chiro_screen_id = chiro_screen['id'] if chiro_screen else 1

    cursor.execute("SELECT id, screen_code FROM screens WHERE screen_code LIKE '%finance_director_dashboard%' LIMIT 1;")
    finance_screen = cursor.fetchone()
    finance_screen_id = finance_screen['id'] if finance_screen else 1

    cursor.execute("SELECT id, role_code FROM roles WHERE role_code = 'psw' LIMIT 1;")
    psw_role = cursor.fetchone()
    psw_role_id = psw_role['id'] if psw_role else None

    cursor.execute("SELECT id, role_code FROM roles WHERE role_code = 'chiropractor' LIMIT 1;")
    chiro_role = cursor.fetchone()
    chiro_role_id = chiro_role['id'] if chiro_role else None

    cursor.execute("SELECT id, role_code FROM roles WHERE role_code = 'finance_director' LIMIT 1;")
    finance_role = cursor.fetchone()
    finance_role_id = finance_role['id'] if finance_role else None

    # Insert Data Entry 1: Visit Note
    cursor.execute("""
    INSERT INTO data_entries (org_id, app_id, screen_id, role_id, user_id, entry_type, record_ref, status, data_json)
    VALUES (?, ?, ?, ?, 'user_psw_john', 'visit_note', 'REC-VN-98213', 'submitted', 
    '{"client_id": "CL-8871", "client_name": "Mildred Adams", "visit_date": "2026-05-21", "care_provided": ["bathing", "meal_prep", "mobility_assistance"], "notes": "Client was in good spirits."}')
    """, (org_id, ui_app_db_id, psw_screen_id, psw_role_id))

    # Insert Data Entry 2: Intake assessment
    cursor.execute("""
    INSERT INTO data_entries (org_id, app_id, screen_id, role_id, user_id, entry_type, record_ref, status, data_json)
    VALUES (?, ?, ?, ?, 'user_chiro_dr_sarah', 'client_intake', 'REC-IN-55412', 'approved', 
    '{"client_name": "Robert Henderson", "dob": "1964-11-12", "primary_complaint": "Lower back stiffness", "session_type": "Chiro Initial Assessment"}')
    """, (org_id, ui_app_db_id, chiro_screen_id, chiro_role_id))

    # Insert Data Entry 3: Invoice/Booking Draft
    cursor.execute("""
    INSERT INTO data_entries (org_id, app_id, screen_id, role_id, user_id, entry_type, record_ref, status, data_json)
    VALUES (?, ?, ?, ?, 'user_patient_robert', 'booking', 'REC-BK-33921', 'draft', 
    '{"service_id": "SRV-CHIRO", "requested_date": "2026-05-25T10:00:00", "notes": "Prefer morning slot."}')
    """, (org_id, ui_app_db_id, chiro_screen_id, chiro_role_id))


    # 8. Seed Audit Transactions (Action history)
    print("Seeding Audit Transactions Ledger...")
    # Transaction 1: User Login
    cursor.execute("""
    INSERT INTO transactions (org_id, app_id, screen_id, user_id, role_id, transaction_type, entity_type, entity_id, note)
    VALUES (?, ?, ?, 'user_psw_john', ?, 'login', 'user', 'user_psw_john', 'Successful login from mobile app (iOS)')
    """, (org_id, ui_app_db_id, psw_screen_id, psw_role_id))

    # Transaction 2: Visit note submission
    cursor.execute("""
    INSERT INTO transactions (org_id, app_id, screen_id, user_id, role_id, transaction_type, entity_type, entity_id, before_json, after_json, note)
    VALUES (?, ?, ?, 'user_psw_john', ?, 'create', 'note', 'REC-VN-98213', NULL, '{"client_id": "CL-8871", "status": "submitted"}', 'Visit note created and sent for clinical review')
    """, (org_id, ui_app_db_id, psw_screen_id, psw_role_id))

    # Transaction 3: Approve clinical intake
    cursor.execute("""
    INSERT INTO transactions (org_id, app_id, screen_id, user_id, role_id, transaction_type, entity_type, entity_id, before_json, after_json, note)
    VALUES (?, ?, ?, 'user_director_clinical', ?, 'approve', 'client', 'REC-IN-55412', '{"status": "pending_approval"}', '{"status": "approved"}', 'Clinical assessment approved by Clinical Director.')
    """, (org_id, ui_app_db_id, chiro_screen_id, chiro_role_id))


    # 9. Seed Saved Reports (Aggregate reports)
    print("Seeding Saved Business Reports...")
    # Report 1: Daily Revenue Summary
    cursor.execute("""
    INSERT INTO saved_reports (org_id, app_id, report_name, report_type, filters_json, result_json, created_by)
    VALUES (?, ?, 'Daily Billing & Cash Flow Digest', 'revenue', '{"date": "2026-05-21", "currency": "CAD"}', 
    '{"total_invoices": 18, "total_value": 2450.00, "paid_invoices": 12, "pending_invoices": 6}', 'finance_director_bot')
    """, (org_id, ui_app_db_id))

    # Report 2: Weekly Clinical Audit
    cursor.execute("""
    INSERT INTO saved_reports (org_id, app_id, report_name, report_type, filters_json, result_json, created_by)
    VALUES (?, ?, 'Weekly Care Plan Compliance & Drift Audit', 'audit', '{"week_start": "2026-05-14", "week_end": "2026-05-21"}', 
    '{"screens_scanned": 62, "layout_conformity": 100.0, "drifts_detected": 0}', 'governance_engine')
    """, (org_id, ui_app_db_id))


    # 10. Seed Governance Logs Info Row
    cursor.execute("""
    INSERT INTO governance_logs (org_id, app_id, screen_id, log_type, message, severity)
    VALUES (?, ?, NULL, 'info', 'Relational database initialized and dynamically seeded successfully.', 'low')
    """, (org_id, ui_app_db_id))

    conn.commit()
    
    # Run verification counts for all 15 tables
    cursor.execute("SELECT COUNT(*) FROM orgs;")
    o_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM offices;")
    of_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM apps;")
    app_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM roles;")
    role_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM app_roles;")
    ar_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM screens;")
    s_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM sidebar_items;")
    sb_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM role_screen_permissions;")
    rsp_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM screen_functions;")
    sf_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM screen_components;")
    sc_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM function_components;")
    fc_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM governance_logs;")
    gl_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM data_entries;")
    de_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM transactions;")
    tx_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM saved_reports;")
    sr_count = cursor.fetchone()[0]

    cursor.execute("PRAGMA foreign_keys = ON;")
    conn.close()

    print("=====================================================")
    print("Relational 15-Table Seeding Verification:")
    print(f"  - Orgs:                       {o_count}")
    print(f"  - Offices:                    {of_count}")
    print(f"  - Apps:                       {app_count}")
    print(f"  - Roles:                      {role_count}")
    print(f"  - App Roles:                  {ar_count}")
    print(f"  - Screens:                    {s_count}")
    print(f"  - Sidebar Items:              {sb_count}")
    print(f"  - Role Screen Permissions:    {rsp_count}")
    print(f"  - Screen Functions:           {sf_count}")
    print(f"  - Screen Components:          {sc_count}")
    print(f"  - Function Component Links:   {fc_count}")
    print(f"  - Governance Logs:            {gl_count}")
    print(f"  - Data Entries:               {de_count}")
    print(f"  - Transactions:               {tx_count}")
    print(f"  - Saved Reports:              {sr_count}")
    print("=====================================================")
    print("[OK] SUCCESS: 15-Table Relational Schema is fully seeded!")
    print("=====================================================")

if __name__ == "__main__":
    migrate()
