import sqlite3
import re
import os
import json
from datetime import datetime

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
DOCS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\docs\roles"

ROLE_SYNONYMS = {
    'rmt': 'rmt',
    'cfo': 'cfo',
    'ceo': 'ceo',
    'ciso': 'ciso',
    'coo': 'coo',
    'cto': 'cto',
    'psw': 'psw',
    'hsw': 'hsw',
    'rn': 'rn',
    'rpn': 'rpn',
    'lpn': 'lpn',
    'np': 'np',
    'physician': 'physician',
    'cns': 'cns',
    'pediatric': 'pediatric',
    'therapist': 'therapist',
    'chiropractor': 'chiropractor',
    'physio': 'physio',
    'physiotherapist': 'physio',
    'social_worker': 'social_worker',
    'social-worker': 'social_worker',
    'clinical_director': 'clinical_director',
    'clinical-director': 'clinical_director',
    'intake': 'intake',
    'intake_coordinator': 'intake',
    'intake-coordinator': 'intake',
    'scheduler': 'scheduler',
    'scheduler_coordinator': 'scheduler',
    'scheduler-coordinator': 'scheduler',
    'billing_admin': 'billing_admin',
    'billing-admin': 'billing_admin',
    'hr_hiring': 'hr_hiring',
    'hr-hiring': 'hr_hiring',
    'hr_manager': 'hr_hiring',
    'hr-manager': 'hr_hiring',
    'hr_director': 'hr_director',
    'hr-director': 'hr_director',
    'general_manager': 'gm',
    'general-manager': 'gm',
    'gm': 'gm',
    'operations_manager': 'ops_manager',
    'operations-manager': 'ops_manager',
    'ops_manager': 'ops_manager',
    'ops-manager': 'ops_manager',
    'franchise_owner': 'owner',
    'franchise-owner': 'owner',
    'owner': 'owner',
    'shareholder': 'shareholder',
    'legal': 'legal',
    'compliance': 'compliance',
    'compliance_manager': 'compliance',
    'compliance-manager': 'compliance',
    'quality_assurance': 'qa_specialist',
    'quality-assurance': 'qa_specialist',
    'qa_specialist': 'qa_specialist',
    'qa-specialist': 'qa_specialist',
    'qa': 'qa_specialist',
    'family': 'family',
    'family_member': 'family',
    'family-member': 'family',
    'patient': 'patient',
    'client': 'patient',
    'portal': 'portal',
    'guest': 'guest',
    'employee': 'employee',
    'volunteer': 'volunteer',
    'volunteer_coordinator': 'volunteer_coordinator',
    'volunteer-coordinator': 'volunteer_coordinator',
    'scrum_master': 'scrum_master',
    'scrum-master': 'scrum_master',
    'training_coordinator': 'training_coordinator',
    'training-coordinator': 'training_coordinator',
    'training_director': 'training_director',
    'training-director': 'training_director',
    'training': 'training',
    'training-hub': 'training',
    'dynamic': 'dynamic',
    'infrastructure': 'infrastructure',
    'system_verification': 'system_verification',
    'system-verification': 'system_verification',
    'vip_manager': 'vip_manager',
    'vip-manager': 'vip_manager',
    'premium_concierge': 'premium_concierge',
    'premium-concierge': 'premium_concierge',
    'regional_bdm': 'regional_bdm',
    'regional-bdm': 'regional_bdm',
    'regional_manager': 'regional_manager_usa',
    'regional-manager': 'regional_manager_usa',
    'regional_manager_usa': 'regional_manager_usa',
    'regional-manager-usa': 'regional_manager_usa',
    'regional_manager_ontario': 'regional_manager_usa',
    'regional-manager-ontario': 'regional_manager_usa',
    'partnership_manager': 'partnership',
    'partnership-manager': 'partnership',
    'partnership': 'partnership',
    'territory_expansion_manager': 'territory_expansion',
    'territory-expansion-manager': 'territory_expansion',
    'territory_expansion': 'territory_expansion',
    'territory-expansion': 'territory_expansion',
    'territory_sales_manager': 'territory_sales',
    'territory-sales-manager': 'territory_sales',
    'territory_sales': 'territory_sales',
    'territory-sales': 'territory_sales',
    'local_marketing_manager': 'local_marketing',
    'local-marketing-manager': 'local_marketing',
    'local_marketing': 'local_marketing',
    'local-marketing': 'local_marketing',
    'community_outreach': 'community_outreach',
    'community-outreach': 'community_outreach',
    'head_of_bus_dev': 'bus_dev',
    'head-of-bus-dev': 'bus_dev',
    'bus_dev': 'bus_dev',
    'bus-dev': 'bus_dev',
    'head_of_marketing': 'marketing',
    'head-of-marketing': 'marketing',
    'marketing_manager': 'marketing',
    'marketing-manager': 'marketing',
    'marketing': 'marketing',
    'cx_director': 'cx_director',
    'cx-director': 'cx_director',
    'finance_director': 'finance_director',
    'finance-director': 'finance_director',
    'it_admin': 'infrastructure',
    'it-admin': 'infrastructure',
    'admin': 'admin',
    'rn_field_supervisor': 'rn_field_supervisor',
    'rn-field-supervisor': 'rn_field_supervisor',
    'caregiver': 'caregiver',
}

ROLE_NAMES = {
    'chiropractor': 'Chiropractor',
    'physio': 'Physiotherapist',
    'rmt': 'Registered Massage Therapist (RMT)',
    'social_worker': 'Social Worker',
    'therapist': 'Therapist',
    'clinical_director': 'Clinical Director',
    'intake': 'Intake Coordinator',
    'rn': 'Registered Nurse (RN)',
    'physician': 'Physician',
    'cns': 'Clinical Nurse Specialist',
    'pediatric': 'Pediatric Specialist',
    'caregiver': 'Caregiver',
    'guest': 'Guest',
    'portal': 'Portal User',
    'patient': 'Patient',
    'dynamic': 'Dynamic Screen Viewer',
    'infrastructure': 'Infrastructure Auditor',
    'system_verification': 'System Verification Officer',
    'training': 'Training Candidate',
    'ceo': 'Chief Executive Officer (CEO)',
    'cfo': 'Chief Financial Officer (CFO)',
    'ciso': 'Chief Information Security Officer (CISO)',
    'coo': 'Chief Operating Officer (COO)',
    'cto': 'Chief Technology Officer (CTO)',
    'cx_director': 'CX Director',
    'finance_director': 'Finance Director',
    'hr_director': 'HR Director',
    'legal': 'Legal Counsel',
    'owner': 'Franchise Owner',
    'shareholder': 'Shareholder',
    'training_director': 'Training Director',
    'community_outreach': 'Community Outreach Lead',
    'compliance': 'Compliance Manager',
    'franchise_sales': 'Franchise Sales Manager',
    'gm': 'General Manager',
    'governance': 'Governance Officer',
    'bus_dev': 'Head of Business Development',
    'marketing': 'Head of Marketing',
    'local_marketing': 'Local Marketing Manager',
    'ops_manager': 'Operations Manager',
    'partnership': 'Partnership Manager',
    'regional_bdm': 'Regional BDM',
    'regional_manager_usa': 'Regional Manager USA',
    'scrum_master': 'Scrum Master',
    'hr_hiring': 'Talent Acquisition Manager',
    'territory_expansion': 'Territory Expansion Manager',
    'territory_sales': 'Territory Sales Manager',
    'volunteer_coordinator': 'Volunteer Coordinator',
    'premium_concierge': 'Premium Concierge Care Coordinator',
    'vip_manager': 'VIP Client Manager',
    'psw': 'Personal Support Worker (PSW)',
    'hsw': 'Home Support Worker',
    'rn_field_supervisor': 'Registered Nurse (RN) Field Supervisor',
    'np': 'Nurse Practitioner (NP)',
    'rpn': 'Registered Practical Nurse (RPN)',
    'lpn': 'Licensed Practical Nurse (LPN)',
    'employee': 'Employee',
    'volunteer': 'Volunteer',
    'admin': 'Administrative Assistant',
    'scheduler': 'Shift Supervisor',
    'customer_support': 'Customer Support',
    'training_coordinator': 'Training Coordinator',
    'qa_specialist': 'QA Specialist',
    'family': 'Family Member',
    'billing_admin': 'Billing Administrator',
    'public_health_officer': 'Public Health Coordinator',
    'researcher': 'Clinical Researcher',
    'telehealth_provider': 'Telehealth Provider',
}

def extract_role_details(route, screen_name):
    # Try offices pattern first
    m = re.search(r'/offices/([^/]+)/roles/([^/]+)', route)
    if m:
        category = m.group(1)
        rkey = m.group(2).lower()
        role_key = ROLE_SYNONYMS.get(rkey, rkey)
        return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Try roles pattern: /roles/([^/]+)
    m2 = re.search(r'/roles/([^/]+)', route)
    if m2:
        rkey = m2.group(1).lower()
        role_key = ROLE_SYNONYMS.get(rkey, rkey)
        category = 'corporate' if role_key in ['cfo', 'ceo', 'coo', 'cto', 'ciso'] else 'common'
        return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Try matching segments from route path
    tokens = re.split(r'[/_-]', route.lower())
    for syn_key in sorted(ROLE_SYNONYMS.keys(), key=len, reverse=True):
        syn_tokens = re.split(r'[_]', syn_key)
        for i in range(len(tokens) - len(syn_tokens) + 1):
            if tokens[i:i+len(syn_tokens)] == syn_tokens:
                role_key = ROLE_SYNONYMS[syn_key]
                category = tokens[1] if len(tokens) > 1 else 'common'
                return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Check screen name as fallback
    screen_tokens = re.findall(r'[A-Z]?[a-z]+|[A-Z]+(?=[A-Z][a-z]|\b)', screen_name)
    screen_tokens = [t.lower() for t in screen_tokens]
    for syn_key in sorted(ROLE_SYNONYMS.keys(), key=len, reverse=True):
        syn_tokens = re.split(r'[_]', syn_key)
        for i in range(len(screen_tokens) - len(syn_tokens) + 1):
            if screen_tokens[i:i+len(syn_tokens)] == syn_tokens:
                role_key = ROLE_SYNONYMS[syn_key]
                category = 'common'
                return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Domain fallbacks for telehealth, research, public health
    for domain in ['public_health', 'research', 'telehealth', 'pharmacy', 'analytics', 'marketing', 'admin']:
        domain_tokens = domain.split('_')
        for i in range(len(tokens) - len(domain_tokens) + 1):
            if tokens[i:i+len(domain_tokens)] == domain_tokens:
                role_key = f"{domain}_officer" if domain in ['public_health', 'compliance'] else (f"{domain}er" if domain == 'research' else f"{domain}_provider")
                role_name = ROLE_NAMES.get(role_key, f"{domain.replace('_', ' ').title()} Coordinator")
                return role_key, role_name, domain

    # Fallbacks for specific common unmatched routes
    if 'forgot-password' in route or 'login' in route or 'mfa' in route or 'reset-password' in route:
        return 'guest', 'Guest', 'common'
    if 'site-readiness' in route:
        return 'ops_manager', 'Operations Manager', 'franchise'
    if 'app-notification' in route or 'gamification-profile' in route:
        return 'portal', 'Portal User', 'client'
    if 'screen-audit' in route or 'screen-not-implemented' in route or 'shared-stubs' in route or 'progress-dashboard' in route or 'role-coverage' in route or 'file-verification' in route:
        return 'governance', 'Governance Officer', 'management'
    if 'architecture-planning' in route:
        return 'governance', 'Governance Officer', 'management'
    if 'business-development' in route:
        return 'bus_dev', 'Head of Business Development', 'executive'
    if 'course-architect' in route:
        return 'training_director', 'Training Director', 'executive'
    if 'office-dashboard' in route:
        return 'ops_manager', 'Operations Manager', 'franchise'
    if 'support-dashboard' in route:
        return 'customer_support', 'Customer Support', 'common'
    if 'system-dashboard' in route or 'api-health' in route:
        return 'cto', 'Chief Technology Officer (CTO)', 'executive'
    if 'franchise-dashboard' in route:
        return 'owner', 'Franchise Owner', 'executive'
    if 'portal-dashboard' in route:
        return 'portal', 'Portal User', 'client'
    if 'infrastructure-dashboard' in route:
        return 'infrastructure', 'Infrastructure Auditor', 'common'
    if 'financial-dashboard' in route:
        return 'cfo', 'Chief Financial Officer (CFO)', 'executive'
    if 'campaign-dashboard' in route:
        return 'marketing', 'Head of Marketing', 'marketing'
    if 'clinical-dashboard' in route:
        return 'clinical_director', 'Clinical Director', 'clinical'
        
    return 'guest', 'Guest', 'common'

def run_migration_and_classification():
    print("Connecting to SQLite governance database...")
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    
    # 1. Run migration - Add columns to screens if missing
    c.execute("PRAGMA table_info(screens)")
    existing_cols = [row['name'] for row in c.fetchall()]
    
    columns_to_add = [
        ("role_key", "TEXT"),
        ("role_name", "TEXT"),
        ("role_category", "TEXT"),
        ("role_screen_order", "INTEGER DEFAULT 0"),
        ("role_completion_percent", "INTEGER DEFAULT 0"),
        ("role_doc_path", "TEXT")
    ]
    
    for col_name, col_type in columns_to_add:
        if col_name not in existing_cols:
            c.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type}")
            print(f"Added column {col_name} to screens table.")
            
    # Create role_screen_audit table
    c.execute("""
        CREATE TABLE IF NOT EXISTS role_screen_audit (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            role_key TEXT,
            role_name TEXT,
            role_category TEXT,
            total_screens INTEGER,
            production_ready_count INTEGER,
            incomplete_count INTEGER,
            false_progress_count INTEGER,
            zero_interaction_count INTEGER,
            average_progress REAL,
            average_interactive_objects REAL,
            screens_needing_review INTEGER,
            markdown_doc_path TEXT,
            last_generated_at TEXT
        )
    """)
    print("Created table role_screen_audit (if not exists).")
    conn.commit()
    
    # 2. Classify every screen and update the database
    c.execute("SELECT id, route_path, screen_name, progress_percent, total_interactive_objects FROM screens")
    screens = c.fetchall()
    
    print(f"Classifying {len(screens)} screens...")
    
    role_counters = {}
    
    for s in screens:
        screen_id = s['id']
        route = s['route_path'] or ''
        name = s['screen_name'] or ''
        progress = s['progress_percent'] or 0
        
        role_key, role_name, category = extract_role_details(route, name)
        
        doc_path = f"docs/roles/{role_key}_screens.md"
        
        c.execute("""
            UPDATE screens
            SET role_key = ?,
                role_name = ?,
                role_category = ?,
                role_doc_path = ?
            WHERE id = ?
        """, (role_key, role_name, category, doc_path, screen_id))
        
        if role_key not in role_counters:
            role_counters[role_key] = []
        role_counters[role_key].append(screen_id)
        
    conn.commit()
    print("Screens classification updated in database successfully.")
    
    # 3. Calculate completion percentages per role and update screens table
    for rkey, sids in role_counters.items():
        placeholders = ",".join(["?"] * len(sids))
        
        # Calculate completion %
        c.execute(f"SELECT AVG(progress_percent) FROM screens WHERE id IN ({placeholders})", sids)
        avg_prog = int(c.fetchone()[0] or 0)
        
        # Update each screen's role_completion_percent
        c.execute(f"UPDATE screens SET role_completion_percent = ? WHERE id IN ({placeholders})", [avg_prog] + sids)
    conn.commit()
    print("Role completion percentages populated on all screens.")
    
    # 4. Populate role_screen_audit table
    c.execute("DELETE FROM role_screen_audit")
    
    now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    c.execute("""
        SELECT role_key, role_name, MIN(role_category) as role_category 
        FROM screens 
        WHERE role_key IS NOT NULL 
        GROUP BY role_key, role_name
    """)
    distinct_roles = c.fetchall()
    
    print(f"Computing audit metrics for {len(distinct_roles)} distinct roles...")
    
    for dr in distinct_roles:
        rkey = dr['role_key']
        rname = dr['role_name']
        rcat = dr['role_category']
        
        # Count stats
        c.execute("SELECT COUNT(*) FROM screens WHERE role_key = ?", (rkey,))
        total_screens = c.fetchone()[0]
        
        c.execute("SELECT COUNT(*) FROM screens WHERE role_key = ? AND production_ready = 1", (rkey,))
        production_ready_count = c.fetchone()[0]
        
        c.execute("SELECT COUNT(*) FROM screens WHERE role_key = ? AND (production_ready = 0 OR progress_percent < 100)", (rkey,))
        incomplete_count = c.fetchone()[0]
        
        c.execute("SELECT COUNT(*) FROM screens WHERE role_key = ? AND false_progress = 1", (rkey,))
        false_progress_count = c.fetchone()[0]
        
        c.execute("SELECT COUNT(*) FROM screens WHERE role_key = ? AND screen_body_total_interactions = 0", (rkey,))
        zero_interaction_count = c.fetchone()[0]
        
        c.execute("SELECT AVG(progress_percent) FROM screens WHERE role_key = ?", (rkey,))
        average_progress = c.fetchone()[0] or 0.0
        
        c.execute("SELECT AVG(screen_body_total_interactions) FROM screens WHERE role_key = ?", (rkey,))
        average_interactive_objects = c.fetchone()[0] or 0.0
        
        c.execute("SELECT COUNT(*) FROM screens WHERE role_key = ? AND needs_review = 1", (rkey,))
        screens_needing_review = c.fetchone()[0]
        
        doc_path = f"docs/roles/{rkey}_screens.md"
        
        c.execute("""
            INSERT INTO role_screen_audit (
                role_key, role_name, role_category, total_screens, production_ready_count, 
                incomplete_count, false_progress_count, zero_interaction_count, average_progress, 
                average_interactive_objects, screens_needing_review, markdown_doc_path, last_generated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (rkey, rname, rcat, total_screens, production_ready_count, 
              incomplete_count, false_progress_count, zero_interaction_count, average_progress, 
              average_interactive_objects, screens_needing_review, doc_path, now_str))
        
    conn.commit()
    print("Table role_screen_audit populated successfully.")
    
    # 5. Generate Markdown Documentation
    if not os.path.exists(DOCS_DIR):
        os.makedirs(DOCS_DIR)
        print(f"Created documentation directory at {DOCS_DIR}")
        
    # Query role audit stats
    c.execute("SELECT * FROM role_screen_audit")
    audit_records = c.fetchall()
    
    print("Generating role markdown files...")
    for ar in audit_records:
        rkey = ar['role_key']
        rname = ar['role_name']
        rcat = ar['role_category']
        
        # Load screens for this role
        c.execute("""
            SELECT screen_name, route_path, actual_file_path, file_path, progress_percent, 
                   total_interactive_objects, button_count, form_field_count, table_action_count,
                   screen_purpose, primary_user_goal, expected_user_actions, business_reason,
                   blocker, next_action, false_progress, production_ready, needs_review, visual_status,
                   screen_body_button_count, screen_body_form_count, screen_body_filter_count,
                   screen_body_table_action_count, screen_body_clickable_card_count,
                   screen_body_total_interactions, global_navigation_count, meaningful_interaction_status,
                   business_workflow_score, role_expectation_score, missing_business_features, business_ready
            FROM screens 
            WHERE role_key = ?
        """, (rkey,))
        role_screens_rows = c.fetchall()
        
        file_path = os.path.join(DOCS_DIR, f"{rkey}_screens.md")
        
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(f"# {rname}\n\n")
            f.write(f"## Role Summary\n\n")
            f.write(f"* **Role key**: `{rkey}`\n")
            f.write(f"* **Role category**: `{rcat}`\n")
            f.write(f"* **Total screens**: {ar['total_screens']}\n")
            f.write(f"* **Business ready screens**: {ar['production_ready_count']}\n")
            f.write(f"* **Incomplete screens**: {ar['incomplete_count']}\n")
            f.write(f"* **False progress screens**: {ar['false_progress_count']}\n")
            f.write(f"* **Zero Screen-Body Interaction screens**: {ar['zero_interaction_count']}\n")
            f.write(f"* **Average progress**: {ar['average_progress']:.1f}%\n")
            f.write(f"* **Average screen-body interactions**: {ar['average_interactive_objects']:.1f}\n\n")
            
            f.write(f"## Screen List\n\n")
            f.write("| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |\n")
            f.write("| --- | --- | --- | --- | --- | --- | --- | --- | --- |\n")
            for s in role_screens_rows:
                ready_str = "Yes" if s['business_ready'] else "No"
                missing_f = s['missing_business_features'] or 'None'
                f.write(f"| {s['screen_name']} | `{s['route_path']}` | {s['screen_body_total_interactions']} | {s['global_navigation_count']} | `{s['meaningful_interaction_status']}` | {s['business_workflow_score']} | {s['role_expectation_score']} | {missing_f} | **{ready_str}** |\n")
            f.write("\n")
            
            f.write(f"## Screen Details\n\n")
            for s in role_screens_rows:
                comp_file = s['actual_file_path'] or s['file_path'] or 'N/A'
                f.write(f"### {s['screen_name']}\n\n")
                f.write(f"* **Route**: `{s['route_path']}`\n")
                f.write(f"* **Component file**: `{comp_file}`\n")
                f.write(f"* **Current stage**: Stage {int(s['progress_percent']/10)}\n")
                f.write(f"* **Progress %**: {s['progress_percent']}%\n")
                f.write(f"* **Visual status**: `{s['visual_status']}`\n")
                f.write(f"* **Business ready**: `{'Yes' if s['business_ready'] else 'No'}`\n")
                f.write(f"* **Meaningful Interaction Status**: `{s['meaningful_interaction_status']}`\n")
                f.write(f"* **Screen Body Interactions**: {s['screen_body_total_interactions']}\n")
                f.write(f"  * **Buttons**: {s['screen_body_button_count']}\n")
                f.write(f"  * **Forms**: {s['screen_body_form_count']}\n")
                f.write(f"  * **Filters**: {s['screen_body_filter_count']}\n")
                f.write(f"  * **Table Actions**: {s['screen_body_table_action_count']}\n")
                f.write(f"  * **Clickable Cards**: {s['screen_body_clickable_card_count']}\n")
                f.write(f"* **Global Navigation Count**: {s['global_navigation_count']}\n")
                f.write(f"* **Business Workflow Score**: {s['business_workflow_score']}\n")
                f.write(f"* **Role Expectation Score**: {s['role_expectation_score']}\n")
                f.write(f"* **Missing Business Features**: {s['missing_business_features'] or 'None'}\n")
                f.write(f"* **Purpose**: {s['screen_purpose'] or 'N/A'}\n")
                f.write(f"* **Primary user goal**: {s['primary_user_goal'] or 'N/A'}\n")
                f.write(f"* **Expected user actions**: {s['expected_user_actions'] or 'N/A'}\n")
                f.write(f"* **Business reason**: {s['business_reason'] or 'N/A'}\n")
                f.write(f"* **Missing items**: {s['blocker'] or 'None'}\n")
                f.write(f"* **Next action**: {s['next_action'] or 'None'}\n\n")
                
            # Screens to fix first
            # Sort order: business_ready = 0 first, progress lowest first
            sorted_screens = list(role_screens_rows)
            sorted_screens.sort(key=lambda x: (
                0 if not x['business_ready'] else 1,
                x['progress_percent']
            ))
            
            f.write(f"## Screens to Fix First\n\n")
            worst_screens = [s for s in sorted_screens if not s['business_ready']]
            
            if worst_screens:
                for idx, s in enumerate(worst_screens[:10], 1):
                    f.write(f"{idx}. **{s['screen_name']}** (Progress: {s['progress_percent']}%, Business Score: {s['business_workflow_score']}, Role Score: {s['role_expectation_score']})  \n")
                    f.write(f"   *Reason*: Missing core workflows/features: {s['missing_business_features'] or 'No business features implemented'}\n")
            else:
                f.write("All screens are fully business-ready and verified! Zero issues found.\n")
                
            f.write(f"\n## Recommended Build Order\n\n")
            must_fix = [s['screen_name'] for s in sorted_screens if not s['business_ready']]
            fix_next = []
            polish = [s['screen_name'] for s in sorted_screens if s['business_ready'] and s['progress_percent'] < 100]
            
            f.write("### 1. Must Fix Now (High Priority)\n")
            if must_fix:
                for name in must_fix[:5]:
                    f.write(f"- {name} (Implement role-specific workflows and transactional features)\n")
            else:
                f.write("- None (All screens have core workflows implemented)\n")
                
            f.write("\n### 2. Fix Next (Medium Priority)\n")
            if fix_next:
                for name in fix_next[:5]:
                    f.write(f"- {name} (Complete backend wiring & data validation)\n")
            else:
                f.write("- None (All screens are functionally complete)\n")
                
            f.write("\n### 3. Polish Later (Low Priority)\n")
            if polish:
                for name in polish[:5]:
                    f.write(f"- {name} (Micro-interactions and design alignment polish)\n")
            else:
                f.write("- None (All screens fully completed and polished)\n")
                
            f.write("\n### 4. Consider Merging / Deleting\n")
            duplicates = [s['screen_name'] for s in sorted_screens if 'dup-' in s['route_path']]
            if duplicates:
                for name in duplicates[:5]:
                    f.write(f"- {name} (Consolidate redundant route split entries)\n")
            else:
                f.write("- None (Zero duplicate screens identified)\n")
                
    # 6. Generate Master Role Index
    master_index_path = os.path.join(DOCS_DIR, "ROLE_SCREEN_INDEX.md")
    print(f"Generating Master Role Index at {master_index_path}...")
    
    # Query all screens for the master list
    c.execute("""
        SELECT screen_name, route_path, role_name, screen_body_total_interactions, global_navigation_count, 
               meaningful_interaction_status, business_workflow_score, role_expectation_score, 
               missing_business_features, business_ready
        FROM screens
        ORDER BY role_name, screen_name
    """)
    all_screens_rows = c.fetchall()
    
    with open(master_index_path, "w", encoding="utf-8") as f:
        f.write("# Master Role Screen Index\n\n")
        f.write("This index compiles all roles and screens across the PrimeCare platform under the **strict role-aware business validation guidelines** (requiring core business workflows for production readiness).\n\n")
        
        f.write("## Roles Summary\n\n")
        f.write("| Role | Category | Total Screens | Business Ready | Incomplete | False Progress | Zero Body Interaction | Average Progress | Doc Link |\n")
        f.write("| --- | --- | --- | --- | --- | --- | --- | --- | --- |\n")
        
        # Sort by total screens descending
        audit_records_sorted = list(audit_records)
        audit_records_sorted.sort(key=lambda x: x['total_screens'], reverse=True)
        
        for ar in audit_records_sorted:
            rkey = ar['role_key']
            doc_link = f"[{ar['role_name']}]({rkey}_screens.md)"
            f.write(f"| {ar['role_name']} | `{ar['role_category']}` | {ar['total_screens']} | {ar['production_ready_count']} | {ar['incomplete_count']} | {ar['false_progress_count']} | {ar['zero_interaction_count']} | {ar['average_progress']:.1f}% | {doc_link} |\n")
            
        f.write("\n## Master Screen Index\n\n")
        f.write("A comprehensive list of all screens on the platform with role-aware business readiness scoring and missing features list.\n\n")
        f.write("| Screen Name | Role | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |\n")
        f.write("| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |\n")
        for s in all_screens_rows:
            role_n = s['role_name'] or 'Guest'
            ready_str = "Yes" if s['business_ready'] else "No"
            missing_f = s['missing_business_features'] or 'None'
            f.write(f"| {s['screen_name']} | {role_n} | `{s['route_path']}` | {s['screen_body_total_interactions']} | {s['global_navigation_count']} | `{s['meaningful_interaction_status']}` | {s['business_workflow_score']} | {s['role_expectation_score']} | {missing_f} | **{ready_str}** |\n")
            
    print("Master Role Index generated successfully.")
    conn.close()
 
if __name__ == "__main__":
    run_migration_and_classification()
