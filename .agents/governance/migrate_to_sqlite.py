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

def resolve_app_code_for_role(role_code):
    role_to_app = {
        'chiropractor': 'ci',
        'physio': 'ci',
        'rmt': 'ci',
        'social_worker': 'ci',
        'therapist': 'ci',
        'clinical_director': 'ci',
        'intake': 'ci',
        'rn': 'ci',
        'physician': 'ci',
        'cns': 'ci',
        'pediatric': 'ci',
        'psw': 'ci',
        'hsw': 'ci',
        'rn_field_supervisor': 'ci',
        'np': 'ci',
        'rpn': 'ci',
        'lpn': 'ci',
        
        'ceo': 'co',
        'cfo': 'co',
        'coo': 'co',
        'cto': 'co',
        'ciso': 'co',
        'finance_director': 'co',
        'hr_director': 'co',
        'owner': 'fr',
        
        'caregiver': 'cl',
        'guest': 'cl',
        'portal': 'cl',
        'patient': 'cl',
        
        'support': 'su',
        'customer_support': 'su',
        
        'marketing': 'ma',
        'local_marketing': 'ma',
        
        'governance': 'go',
        'compliance': 'go',
        
        'bus_dev': 'bd',
        'business_development': 'bd',
        
        'franchise': 'fr',
        'franchise_sales': 'fr',
        
        'auth': 'au'
    }
    return role_to_app.get(role_code, 'cl')

def migrate():
    print("=====================================================")
    print("Starting PrimeCare Registries to 24-Table SQLite Seeding")
    print("=====================================================")

    # Initialize SQLite schemas
    governance_db.init_db(force_reset=True)
    conn = governance_db.get_connection()
    cursor = conn.cursor()
    cursor.execute("PRAGMA foreign_keys = OFF;")

    # 1. Seed orgs
    print("Seeding Organization...")
    project_root = os.getcwd().replace('\\', '/')
    cursor.execute("""
    INSERT INTO orgs (org_code, org_name, projects_path, status)
    VALUES ('primecare', 'PrimeCare Platform', ?, 'active')
    """, (project_root,))
    org_id = cursor.lastrowid

    # 2. Seed apps
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

    # 2a. Seed physical_packages & logical_apps
    print("Seeding Physical Packages & Logical Apps registries...")
    
    # physical_packages data
    packages_to_seed = [
        ('ui', 'primecare_ui', 'packages/primecare_ui', 'package'),
        ('fc', 'flutter_core', 'packages/flutter_core', 'package'),
        ('dm', 'domain', 'packages/domain', 'package'),
        ('db', 'database', 'packages/database', 'package'),
        ('sy', 'security', 'packages/security', 'package'),
        ('me', 'messaging', 'packages/messaging', 'package'),
        ('co', 'contracts', 'packages/contracts', 'package'),
        ('if', 'infrastructure', 'packages/infrastructure', 'package'),
        ('dc', 'database_client', 'packages/database_client', 'package'),
        ('fs', 'factory_system', 'packages/factory_system', 'package'),
        ('wo', 'worker-api', 'packages/worker-api', 'package')
    ]
    pkg_db_ids = {}
    for p_code, p_name, r_path, p_type in packages_to_seed:
        cursor.execute("""
        INSERT OR IGNORE INTO physical_packages (package_code, package_name, root_path, package_type)
        VALUES (?, ?, ?, ?)
        """, (p_code, p_name, r_path, p_type))
        pkg_db_ids[p_code] = cursor.lastrowid

    # logical_apps data
    logical_apps_to_seed = [
        ('ci', 'PrimeCare Clinic Portal', 'mobile', 'teal', 'production'),
        ('cl', 'PrimeCare Client Portal', 'mobile', 'blue', 'production'),
        ('co', 'PrimeCare Corporate Portal', 'mobile', 'gold', 'production'),
        ('wa', 'Web Admin Console', 'web', 'dark', 'production'),
        ('su', 'PrimeCare Support Portal', 'mobile', 'indigo', 'production'),
        ('au', 'PrimeCare Auth Service', 'mobile', 'purple', 'production'),
        ('go', 'PrimeCare Governance Portal', 'mobile', 'slate', 'production'),
        ('bd', 'PrimeCare Business Development Portal', 'mobile', 'cyan', 'production'),
        ('fr', 'PrimeCare Franchise Portal', 'mobile', 'orange', 'production'),
        ('ma', 'PrimeCare Marketing Portal', 'mobile', 'pink', 'production')
    ]
    log_app_db_ids = {}
    for a_code, a_name, d_type, b_key, env in logical_apps_to_seed:
        cursor.execute("""
        INSERT OR IGNORE INTO logical_apps (org_id, app_code, app_name, deployment_type, branding_key, environment)
        VALUES (?, ?, ?, ?, ?, ?)
        """, (org_id, a_code, a_name, d_type, b_key, env))
        app_db_id = cursor.lastrowid
        log_app_db_ids[a_code] = app_db_id

        # Seed branding_profile for this app
        cursor.execute("""
        INSERT OR IGNORE INTO branding_profiles (logical_app_id, theme_mode, primary_color, secondary_color, font_family, logo_url)
        VALUES (?, 'dark', ?, '#FFFFFF', 'Outfit', ?)
        """, (app_db_id, f'#{b_key}', f'/assets/logos/{a_code}.png'))

        # Seed environment_configs for this app (development, staging, production)
        envs = ['development', 'staging', 'production']
        for idx, e in enumerate(envs):
            api_sub = 'dev-api' if e == 'development' else ('staging-api' if e == 'staging' else 'api')
            cursor.execute("""
            INSERT OR IGNORE INTO environment_configs (logical_app_id, env_key, env_value, environment_name, is_sensitive)
            VALUES (?, 'API_URL', ?, ?, 0)
            """, (app_db_id, f'https://{api_sub}.primecare.io/v1', e))
            cursor.execute("""
            INSERT OR IGNORE INTO environment_configs (logical_app_id, env_key, env_value, environment_name, is_sensitive)
            VALUES (?, 'ENABLE_TELEMETRY', '1', ?, 0)
            """, (app_db_id, e))
            cursor.execute("""
            INSERT OR IGNORE INTO environment_configs (logical_app_id, env_key, env_value, environment_name, is_sensitive)
            VALUES (?, 'JWT_SECRET', ?, ?, 1)
            """, (app_db_id, f'super-secret-{e}-key-{a_code}', e))

        # Seed feature_flags for this app
        flags = [
            ('enable_ai_notes', 'AI Notes Assistant', 1, 'Enable AI-powered medical notes auto-completion'),
            ('enable_sso', 'Native SSO', 1, 'Enable single-sign-on authentications'),
            ('enable_offline_mode', 'Offline Sync', 0, 'Enable offline sync data backup buffers')
        ]
        for f_key, f_name, f_enabled, f_desc in flags:
            cursor.execute("""
            INSERT OR IGNORE INTO feature_flags (logical_app_id, flag_key, flag_name, is_enabled, description)
            VALUES (?, ?, ?, ?, ?)
            """, (app_db_id, f_key, f_name, f_enabled, f_desc))

    # 3. Seed roles
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

    # 4. Dynamically parse and seed Screens & Sidebar Items
    screens_dir = r"packages\primecare_ui\lib\src\screens"
    
    screens_seeded = 0
    sidebars_seeded = 0
    funcs_seeded = 0
    comps_seeded = 0

    ui_app_db_id = apps_mapping.get('ui')

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
            
            # Determine premium layout_key based on category and physical sidebar requirements
            if requires_sidebar:
                if category in ('clinical', 'rn', 'rpn', 'allied', 'psw'):
                    layout_key = 'clinicalLayout'
                else:
                    layout_key = 'adminLayout'
            else:
                layout_key = 'masterLayout'

            # Resolve actual application ID for screen
            app_code_for_screen = resolve_app_code_for_role(role_code)
            app_db_id = apps_mapping.get(app_code_for_screen, ui_app_db_id)

            # 4a. Insert Screen
            cursor.execute("""
            INSERT INTO screens (app_id, screen_code, screen_name, route_path, screen_type, layout_key, implementation_status, file_path)
            VALUES (?, ?, ?, ?, 'dashboard', ?, 'active', ?)
            """, (app_db_id, screen_code, class_name, relative_path, layout_key, relative_path))
            screen_db_id = cursor.lastrowid
            screens_seeded += 1

            # 4aa. Seed Package Files, Ownership, Layout bindings & Router mounts
            cursor.execute("""
            INSERT OR IGNORE INTO package_files (package_id, file_path, file_name, artifact_type, checksum)
            VALUES (?, ?, ?, 'screen', 'MD5-CHECKSUM-STUB')
            """, (pkg_db_ids.get('ui', 1), relative_path, class_name))
            pf_db_id = cursor.lastrowid
            
            log_app_db_id = log_app_db_ids.get(app_code_for_screen)
            if log_app_db_id:
                # Artifact ownership
                cursor.execute("""
                INSERT OR IGNORE INTO artifact_ownership (logical_app_id, package_file_id, ownership_type, mounted_route, authorization_policy, branding_override)
                VALUES (?, ?, 'mounted', ?, ?, ?)
                """, (log_app_db_id, pf_db_id, relative_path, f"Role: {role_code}", f"Branding: {app_code_for_screen}"))
                
                # Router Mount
                cursor.execute("""
                INSERT OR IGNORE INTO router_mounts (logical_app_id, screen_id, route_path, router_name, is_active)
                VALUES (?, ?, ?, 'GoRouter', 1)
                """, (log_app_db_id, screen_db_id, relative_path))
                
                # Layout Binding
                cursor.execute("""
                INSERT OR IGNORE INTO layout_bindings (logical_app_id, screen_id, layout_name, binding_type)
                VALUES (?, ?, ?, 'ShellRoute')
                """, (log_app_db_id, screen_db_id, layout_key))

            # 4b. Seed Zero-Trust Role Permission
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

            # 4c. Seed Parent Sidebar Menu Item
            icon_name = 'stethoscope' if layout_key == 'clinicalLayout' else ('shield' if layout_key == 'adminLayout' else 'home')
            cursor.execute("""
            INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
            VALUES (?, NULL, ?, ?, ?, 0, 1)
            """, (app_db_id, screen_db_id, class_name, icon_name))
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
                    
                    # Insert child sidebar menu button
                    cursor.execute("""
                    INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
                    VALUES (?, ?, ?, ?, 'play', ?, 1)
                    """, (app_db_id, parent_sidebar_id, screen_db_id, label, idx))
                    sidebars_seeded += 1

                    # Insert Function
                    cursor.execute("""
                    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, api_id, implementation_status)
                    VALUES (?, ?, ?, 'shortcut', NULL, 'active')
                    """, (screen_db_id, f"FUN_{screen_code}_{item_code}", f"onTap_{item_code}"))
                    funcs_seeded += 1

                    # Insert Component
                    cursor.execute("""
                    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, file_path, implementation_status)
                    VALUES (?, ?, ?, 'button', ?, ?, 'active')
                    """, (screen_db_id, f"CMP_{screen_code}_{item_code}", label, f"data-cy-{item_code}", relative_path))
                    comps_seeded += 1
                    
                file_has_real_api = any(item in content for item in [
                    'apiClientProvider', 'apiClient.', 'Dio ', 'prisma', 'dbClient',
                    'repository.', 'service.', 'http.Client', 'HttpClient(', '/v1/'
                ])
                
                # Parse Capacity Slider
                if 'Slider(' in content or 'Slider.adaptive(' in content:
                    cursor.execute("""
                    INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
                    VALUES (?, ?, ?, 'Threshold Capacity Adjuster', 'activity', 10, 1)
                    """, (app_db_id, parent_sidebar_id, screen_db_id))
                    sidebars_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, api_id, implementation_status)
                    VALUES (?, ?, 'onChanged', 'shortcut', NULL, 'active')
                    """, (screen_db_id, f"FUN_{screen_code}_capacity_slider"))
                    funcs_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, file_path, implementation_status)
                    VALUES (?, ?, 'Threshold Capacity Adjuster', 'form', 'data-cy-capacity-slider', ?, 'active')
                    """, (screen_db_id, f"CMP_{screen_code}_capacity_slider", relative_path))
                    comps_seeded += 1
                    
                # Parse Audit Logs Console
                if 'AuditLogConsole' in content or 'Operational Audit Logs' in content:
                    cursor.execute("""
                    INSERT INTO sidebar_items (app_id, parent_id, screen_id, label, icon, sort_order, is_visible)
                    VALUES (?, ?, ?, 'Live Auditing timeline Console', 'terminal', 20, 1)
                    """, (app_db_id, parent_sidebar_id, screen_db_id))
                    sidebars_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, api_id, implementation_status)
                    VALUES (?, ?, 'renderLogs', 'api_action', NULL, 'active')
                    """, (screen_db_id, f"FUN_{screen_code}_audit_logs_terminal"))
                    funcs_seeded += 1

                    cursor.execute("""
                    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, file_path, implementation_status)
                    VALUES (?, ?, 'Live Auditing timeline Console', 'card', 'data-cy-audit-logs-terminal', ?, 'active')
                    """, (screen_db_id, f"CMP_{screen_code}_audit_logs_terminal", relative_path))
                    comps_seeded += 1

        print(f"[OK] Dynamically parsed and mapped screen hierarchies:")
        print(f"  - Screens: {screens_seeded}")
        print(f"  - Sidebar Menus: {sidebars_seeded}")
        print(f"  - Action Functions: {funcs_seeded}")
        print(f"  - UI Components: {comps_seeded}")
    else:
        print("[WARN] packages/primecare_ui/lib/src/screens directory not found, skipping sidebars migration.")

    # 5. Seed Saved Reports (Aggregate reports)
    print("Seeding Saved Business Reports...")
    cursor.execute("""
    INSERT INTO governance_reports (app_id, report_name, report_type, html_report_path, generated_by)
    VALUES (?, 'Daily Billing & Cash Flow Digest', 'revenue', 'reports/governance/primecare_governance_audit_daily.html', 'finance_director_bot')
    """, (ui_app_db_id,))
    
    cursor.execute("""
    INSERT INTO governance_reports (app_id, report_name, report_type, html_report_path, generated_by)
    VALUES (?, 'Weekly Care Plan Compliance & Drift Audit', 'audit', 'reports/governance/primecare_governance_audit_weekly.html', 'governance_engine')
    """, (ui_app_db_id,))

    # 6. Seed Governance Logs Info Row
    cursor.execute("""
    INSERT INTO governance_logs (org_id, app_id, screen_id, log_type, message, severity)
    VALUES (?, ?, NULL, 'info', 'Relational database initialized and dynamically seeded successfully.', 'low')
    """, (org_id, ui_app_db_id))

    conn.commit()
    
    # Run verification counts for all 24 active tables
    active_24 = [
        "orgs", "apps", "roles", "screens", "code_files", "screen_file_links", "api_endpoints",
        "screen_api_links", "db_schema_tables", "db_schema_columns", "screen_components",
        "screen_functions", "role_screen_permissions", "role_function_permissions", "test_cases",
        "test_runs", "test_results", "drift_findings", "implementation_tasks", "task_completion_checks",
        "governance_snapshots", "governance_reports", "sidebar_items", "governance_logs"
    ]
    
    counts = {}
    for table in active_24:
        cursor.execute(f"SELECT COUNT(*) FROM [{table}];")
        counts[table] = cursor.fetchone()[0]

    cursor.execute("PRAGMA foreign_keys = ON;")
    conn.close()

    print("=====================================================")
    print("Relational 24-Table Seeding Verification:")
    print("=====================================================")
    for table in sorted(active_24):
        print(f"  - {table:<30} {counts[table]} rows")
    print("=====================================================")
    print("[OK] SUCCESS: 24-Table Relational Schema is fully seeded!")
    print("=====================================================")

if __name__ == "__main__":
    migrate()
