import sqlite3
import os
import re

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

def migrate_db():
    print("Migrating SQLite Database...")
    if not os.path.exists(db_path):
        print(f"Database not found at {db_path}")
        return False

    conn = sqlite3.connect(db_path)
    c = conn.cursor()

    columns_to_add = [
        ("button_count", "INTEGER DEFAULT 0"),
        ("form_field_count", "INTEGER DEFAULT 0"),
        ("link_count", "INTEGER DEFAULT 0"),
        ("table_action_count", "INTEGER DEFAULT 0"),
        ("filter_count", "INTEGER DEFAULT 0"),
        ("navigation_action_count", "INTEGER DEFAULT 0"),
        ("total_interactive_objects", "INTEGER DEFAULT 0"),
        ("screen_purpose", "TEXT"),
        ("primary_user_goal", "TEXT"),
        ("expected_user_actions", "TEXT"),
        ("business_reason", "TEXT"),
        ("screen_purpose_status", "TEXT DEFAULT 'UNCHECKED'"),
        ("needs_review", "INTEGER DEFAULT 0"),
        ("visual_status", "TEXT"),
        ("production_ready", "INTEGER DEFAULT 0"),
        ("false_progress", "INTEGER DEFAULT 0"),
        ("screen_body_button_count", "INTEGER DEFAULT 0"),
        ("screen_body_form_count", "INTEGER DEFAULT 0"),
        ("screen_body_filter_count", "INTEGER DEFAULT 0"),
        ("screen_body_table_action_count", "INTEGER DEFAULT 0"),
        ("screen_body_clickable_card_count", "INTEGER DEFAULT 0"),
        ("screen_body_total_interactions", "INTEGER DEFAULT 0"),
        ("global_navigation_count", "INTEGER DEFAULT 0"),
        ("meaningful_interaction_status", "TEXT DEFAULT 'ZERO_SCREEN_BODY_INTERACTION'"),
        ("business_workflow_score", "INTEGER DEFAULT 0"),
        ("role_expectation_score", "INTEGER DEFAULT 0"),
        ("missing_business_features", "TEXT"),
        ("business_ready", "INTEGER DEFAULT 0")
    ]

    c.execute("PRAGMA table_info(screens)")
    existing_cols = [row[1] for row in c.fetchall()]

    for col_name, col_type in columns_to_add:
        if col_name not in existing_cols:
            alter_query = f"ALTER TABLE screens ADD COLUMN {col_name} {col_type}"
            c.execute(alter_query)
            print(f"Added column {col_name} to screens table.")

    conn.commit()
    conn.close()
    print("Database migration completed.")
    return True

def is_valid_readonly_dashboard(name, route, content):
    name_lower = name.lower()
    route_lower = route.lower()
    dashboard_keywords = [
        'dashboard', 'summary', 'analytics', 'monitor', 'report', 
        'kpi', 'hud', 'sentinel', 'overview', 'pipeline', 'metrics', 
        'log', 'chart', 'board', 'status', 'history'
    ]
    is_db_name = any(kw in name_lower or kw in route_lower for kw in dashboard_keywords)
    
    chart_indicators = [
        'Chart', 'DataTable', 'Table', 'DataCell', 'DataRow',
        'ListView', 'GridView', 'Metric', 'Stats', 'ProgressIndicator',
        'CircularProgressIndicator', 'LinearProgressIndicator', 'Spine',
        'Telemetry', 'Aura', 'Timeline', 'Log'
    ]
    has_indicators = any(ind in content for ind in chart_indicators)
    
    return is_db_name and has_indicators

def infer_purpose(name, route, total_objects):
    if "-dup-" in route or "copy" in route.lower():
        return {
            "purpose": f"Duplicate screen copy for {name}. Created during route split or template duplication.",
            "goal": "Re-route or consolidate user traffic back to the primary screen.",
            "actions": "None. Consolidated into main dashboard.",
            "reason": "Redundant route node; duplicate of main feature screen.",
            "status": "DUPLICATE_PURPOSE",
            "needs_review": 1
        }
    
    if total_objects == 0:
        return {
            "purpose": "Non-interactive visual placeholder. Screen has no actionable widgets or controls.",
            "goal": "None - no user goals can be accomplished on this screen.",
            "actions": "None",
            "reason": "Empty stub or placeholder showing no read-only or transactional value.",
            "status": "NO_USER_VALUE",
            "needs_review": 1
        }

    purpose = ""
    goal = ""
    actions = ""
    reason = ""
    status = "CLEAR_PURPOSE"
    needs_review = 0 if total_objects >= 3 else 1

    # Allied health roles (RMT, Therapist, Physiotherapist, Chiropractor)
    if "rmt" in route or "rmt" in name.lower():
        purpose = "Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes."
        goal = "Manage patient appointments, track session progress, and log clinical treatment notes."
        actions = "Select appointment from list, create adjust/progress note, update therapy schedule, submit bill."
        reason = "Required to document therapy sessions for insurance claims and clinical oversight."
    elif "therapist" in route or "therapist" in name.lower():
        purpose = "Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes."
        goal = "Assess client therapy goals, schedule sessions, and document therapy progress."
        actions = "View calendar, launch therapy progress sheet, submit notes, contact patient."
        reason = "Ensures therapists can track ongoing cognitive or physical rehabilitation sessions."
    elif "chiropractor" in route or "chiropractor" in name.lower():
        purpose = "Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes."
        goal = "Assess spine alignment records, review imaging, and log spine adjustment progress notes."
        actions = "Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing."
        reason = "Supports chiropractic clinical workflows and patient alignment history documentation."
    elif "physiotherapist" in route or "physio" in name.lower():
        purpose = "Physiotherapy dashboard for physical rehabilitation planning, booking client sessions, and recording treatment logs."
        goal = "Track exercise therapy plans, view scheduling conflicts, and document range-of-motion progress."
        actions = "Select patient chart, edit exercise plan, log ranges of motion, submit claims."
        reason = "Provides range-of-motion assessments and therapeutic tracking for rehab patient billing."
    
    # Executive dashboards (COO, CFO, CTO, CEO, CISO)
    elif "coo" in route or "coo" in name.lower():
        purpose = "Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health."
        goal = "Oversee operational KPIs, compare performance across branches, and manage staff escalations."
        actions = "Filter branch comparative metrics, view scheduling health graphs, open operational escalations."
        reason = "Enables executive oversight of clinical logistics, staffing efficiency, and branch performance."
    elif "cfo" in route or "cfo" in name.lower() or "finance" in route:
        purpose = "Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking."
        goal = "Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances."
        actions = "Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims."
        reason = "Ensures financial audits, tax compliance, and payroll distributions are accurate and automated."
    elif "cto" in route or "cto" in name.lower():
        purpose = "Chief Technology Officer hub to track system health, API response telemetry, and release cycles."
        goal = "Monitor system uptime, review security logs, and inspect continuous integration/deployment runs."
        actions = "Refresh uptime chart, view API response latency log, trigger system deployment rollbacks."
        reason = "Protects system availability, technical performance monitoring, and secure software distribution."
    elif "ceo" in route or "ceo" in name.lower():
        purpose = "Chief Executive Officer high-level business intelligence dashboard to review strategic growth and KPIs."
        goal = "Analyze enterprise growth, review organizational structure maps, and inspect strategic KPI reports."
        actions = "Select region filter, download executive summary reports, view revenue pipeline diagrams."
        reason = "Provides corporate leadership with real-time enterprise performance metrics and decision logs."
    
    # Clinical roles (RN, RPN, CNS, Pediatric, Physician, LPN, NP, ADL, etc.)
    elif "clinical" in route or "clinical" in name.lower() or "clinical_director" in route:
        purpose = "Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits."
        goal = "Ensure high standards of clinical care, review incident reports, and pass clinical quality audits."
        actions = "Filter incident reports, check nurse credential expirations, download audit files, sign approvals."
        reason = "Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations."
    elif "rn-" in route or "rn_" in name.lower() or "rn/" in route or "rn" in route:
        purpose = "Registered Nurse (RN) workspace to update patient charting, administer medications, and check vitals logs."
        goal = "Perform home care assessments, update care plans, and log vitals and medications."
        actions = "Select patient, open medication administration list, log vitals check, submit shift notes."
        reason = "Core bedside medical documentation, medication safety checks, and clinical continuity."
    elif "psw" in route or "psw" in name.lower() or "caregiver" in route:
        purpose = "Personal Support Worker (PSW) client visit logger to record care plans, vitals, and daily notes."
        goal = "Review client visit schedules, check off care tasks, and submit daily notes."
        actions = "Check off daily ADL checklist, write visit note, log client vitals, submit shift summary."
        reason = "Documents direct daily living support services for client invoicing and care plan updates."
    
    # Staff roles (Scheduler, HR, Intake)
    elif "scheduler" in route or "schedule" in route or "scheduler" in name.lower():
        purpose = "Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability."
        goal = "Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests."
        actions = "Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider."
        reason = "Core logistics system mapping patient needs to caregiver resources efficiently."
    elif "hr" in route or "hiring" in route or "hr" in name.lower():
        purpose = "Human Resources dashboard to track applicants, schedule credentials, and monitor credential expiries."
        goal = "Hire new healthcare staff, verify licenses, and manage staff onboarding checklists."
        actions = "Filter applications, click schedule interview, upload credential file, verify background check."
        reason = "Ensures all hired staff are fully vetted, qualified, and compliant with nursing association rules."
    elif "intake" in route or "intake" in name.lower():
        purpose = "Intake coordinator referral queue to review new client registrations, assessments, and bookings."
        goal = "Process new referrals, register client profiles, and coordinate initial home assessments."
        actions = "Select new referral, click schedule assessment, assign coordinator, verify insurance document."
        reason = "Handles initial patient onboarding pipeline and clinical service coordination."
    
    # Governance & Monitoring
    elif "governance" in route or "verification" in route or "monitoring" in route or "audit" in route:
        purpose = "Platform governance dashboard to view audit trails, runtime checks, database drift, and telemetry logs."
        goal = "Verify system integrity, inspect security audit logs, and remediate registry configuration drift."
        actions = "Run security sweep, download compliance audit files, approve database schema alterations."
        reason = "Maintains platform regulatory security standards and code governance control rooms."

    # Catch-all based on generic categories
    elif "analytics" in route or "analytics" in name.lower():
        purpose = f"Business intelligence analytics dashboard for {name} to monitor performance trends."
        goal = "Review historical metrics, filter performance reports, and analyze operational trends."
        actions = "Select date range filter, export chart data to CSV, switch between metric tab displays."
        reason = "Data-driven performance tracking and resource allocation forecasting."
    elif "workflow" in route or "workflow" in name.lower():
        purpose = f"Operational workflow configuration and tracking screen for {name} workflows."
        goal = "Configure process tasks, track live workflow execution states, and review failed process blocks."
        actions = "Edit task list nodes, restart failed workflow execution, sign off on completed steps."
        reason = "Operational automation and validation of process steps."
    elif "compliance" in route or "compliance" in name.lower():
        purpose = f"Regulatory compliance tracking and audit registry for {name} protocols."
        goal = "Review policy documents, verify training completion status, and log compliance incidents."
        actions = "Check off policy read agreements, upload compliance proofs, search audit registers."
        reason = "Mandatory safety oversight, legal compliance, and liability protection."
    else:
        purpose = f"Management workspace screen for {name} module access."
        goal = "Review system records and coordinate day-to-day administrative functions."
        actions = "Filter records, view items list, click item detail card, click edit/update buttons."
        reason = "Supports general administrative oversight and recordkeeping."
        
    return {
        "purpose": purpose,
        "goal": goal,
        "actions": actions,
        "reason": reason,
        "status": status,
        "needs_review": needs_review
    }

def clean_dart_content(content):
    # Remove block comments
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    # Remove single line comments
    content = re.sub(r'//.*', '', content)
    return content

def extract_block_content(text, start_keyword):
    idx = text.find(start_keyword)
    if idx == -1:
        return "", text
    open_p = text.find('(', idx + len(start_keyword))
    if open_p == -1 or open_p > idx + len(start_keyword) + 15:
        return "", text
    depth = 1
    i = open_p + 1
    while i < len(text) and depth > 0:
        if text[i] == '(':
            depth += 1
        elif text[i] == ')':
            depth -= 1
        i += 1
    if depth == 0:
        block = text[idx:i]
        remaining = text[:idx] + text[i:]
        return block, remaining
    return "", text

def extract_all_block_contents(text, start_keyword):
    extracted = ""
    remaining = text
    while True:
        block, new_remaining = extract_block_content(remaining, start_keyword)
        if not block:
            break
        extracted += "\n" + block
        remaining = new_remaining
    return extracted, remaining

def is_pure_navigation_block(block):
    block_lower = block.lower()
    nav_keywords = ['context.go', 'context.push', 'gorouter', 'navigator.push', 'navigator.pop', 'navigator.of', 'navigator.maybepop', 'navigator.canpop', 'launchurl']
    has_nav = any(kw in block_lower for kw in nav_keywords)
    if not has_nav:
        return False
    
    # Check if it has any meaningful body actions
    meaningful_keywords = ['save', 'submit', 'cancel', 'update', 'create', 'delete', 'add', 'edit', 'upload', 'post', 'fetch', 'load', 'refresh', 'http', 'api', 'state', 'setstate', 'controller']
    has_meaningful = any(kw in block_lower for kw in meaningful_keywords)
    return not has_meaningful

def parse_and_classify_body_buttons(code):
    button_patterns = [r'\bElevatedButton\b', r'\bOutlinedButton\b', r'\bIconButton\b', r'\bFloatingActionButton\b', r'\bActionChip\b', r'\bTextButton\b']
    body_count = 0
    nav_count = 0
    
    temp_code = code
    for pattern in button_patterns:
        while True:
            match = re.search(pattern, temp_code)
            if not match:
                break
            idx = match.start()
            keyword = temp_code[idx:idx+match.end()-match.start()]
            block, remaining = extract_block_content(temp_code[idx:], keyword)
            if block:
                if is_pure_navigation_block(block):
                    nav_count += 1
                else:
                    body_count += 1
                temp_code = temp_code[:idx] + remaining
            else:
                body_count += 1
                temp_code = temp_code[:idx] + temp_code[idx + len(keyword):]
    return body_count, nav_count

def parse_and_classify_cards(code):
    body_count = 0
    nav_count = 0
    
    temp_code = code
    while True:
        match = re.search(r'\bCard\b', temp_code)
        if not match:
            break
        idx = match.start()
        block, remaining = extract_block_content(temp_code[idx:], "Card")
        if block:
            has_click = 'onTap:' in block or 'onPressed:' in block
            if has_click:
                if is_pure_navigation_block(block):
                    nav_count += 1
                else:
                    body_count += 1
            temp_code = temp_code[:idx] + remaining
        else:
            temp_code = temp_code[:idx] + temp_code[idx + 4:]
    return body_count, nav_count

def parse_and_classify_table_actions(code):
    body_count = 0
    nav_count = 0
    
    temp_code = code
    for kw in ['ListTile', 'DataCell', 'DataRow']:
        while True:
            match = re.search(r'\b' + kw + r'\b', temp_code)
            if not match:
                break
            idx = match.start()
            block, remaining = extract_block_content(temp_code[idx:], kw)
            if block:
                has_click = 'onTap:' in block or 'onPressed:' in block or 'onSelectChanged:' in block
                if has_click:
                    if is_pure_navigation_block(block):
                        nav_count += 1
                    else:
                        body_count += 1
                temp_code = temp_code[:idx] + remaining
            else:
                temp_code = temp_code[:idx] + temp_code[idx + len(kw):]
    return body_count, nav_count

ROLE_EXPECTATIONS = {
    'chiropractor': ['appointment', 'adjustment', 'SOAP', 'treatment', 'billing', 'chart', 'x-ray'],
    'physio': ['rehabilitation', 'exercise', 'treatment', 'booking', 'SOAP', 'chart', 'range-of-motion'],
    'rmt': ['appointment', 'massage', 'SOAP', 'treatment', 'billing', 'chart'],
    'social_worker': ['assessment', 'client', 'notes', 'case', 'counseling', 'referral'],
    'therapist': ['consultation', 'session', 'progress', 'schedule', 'notes', 'assessment'],
    'clinical_director': ['audit', 'compliance', 'incident', 'staff', 'training', 'policy', 'credential'],
    'intake': ['referral', 'registration', 'assessment', 'scheduling', 'insurance', 'onboarding'],
    'rn': ['charting', 'medication', 'vitals', 'care-plan', 'assessment', 'administration'],
    'physician': ['diagnosis', 'prescription', 'lab', 'vitals', 'referral', 'chart'],
    'cns': ['research', 'consultation', 'education', 'clinic', 'care-plan', 'audit'],
    'pediatric': ['child', 'growth', 'vaccine', 'parent', 'developmental', 'vitals'],
    'caregiver': ['tasks', 'daily-living', 'activities', 'visit-log', 'client'],
    'psw': ['visit-log', 'daily-living', 'checklist', 'vitals', 'shift-summary'],
    'hsw': ['visit-log', 'tasks', 'home-support', 'meal', 'safety'],
    'rn_field_supervisor': ['supervision', 'checklist', 'nurse', 'validation', 'field-audit'],
    'np': ['assessment', 'diagnosis', 'prescription', 'primary-care', 'referral'],
    'rpn': ['nursing', 'medication', 'wound-care', 'charting', 'treatment'],
    'lpn': ['nursing', 'tasks', 'vitals', 'charting', 'documentation'],
    'patient': ['booking', 'appointment', 'invoice', 'message', 'care-plan', 'tracker'],
    'portal': ['message', 'notification', 'profile', 'billing', 'schedule'],
    'family': ['member', 'client', 'update', 'care-plan', 'billing', 'communication'],
    'ceo': ['KPI', 'growth', 'regional', 'budget', 'strategic', 'operations'],
    'cfo': ['ledger', 'P&L', 'balance-sheet', 'tax', 'payroll', 'budget', 'invoice', 'export', 'audit', 'comparison'],
    'ciso': ['security', 'audit', 'threat', 'incident', 'scan', 'policy', 'compliance'],
    'coo': ['operations', 'branch', 'comparison', 'staff', 'logistics', 'performance'],
    'cto': ['system', 'uptime', 'latency', 'API', 'deploy', 'server', 'health'],
    'cx_director': ['feedback', 'NPS', 'customer', 'review', 'satisfaction'],
    'finance_director': ['general-ledger', 'reconciliation', 'billing', 'cash-flow', 'accounting'],
    'hr_director': ['policy', 'performance', 'staff', 'hiring', 'payroll-summary'],
    'legal': ['contract', 'compliance', 'agreement', 'dispute', 'document'],
    'owner': ['franchise', 'revenue', 'royalty', 'agreement', 'profit'],
    'shareholder': ['equity', 'dividend', 'meeting', 'report', 'financial'],
    'training_director': ['course', 'certification', 'curriculum', 'instructor', 'validation'],
    'scheduler': ['scheduling', 'calendar', 'shift', 'conflict', 'availability', 'provider'],
    'admin': ['assistant', 'schedule', 'billing', 'mail', 'visitor', 'document'],
    'customer_support': ['ticket', 'support', 'chat', 'resolution', 'user'],
    'training_coordinator': ['trainee', 'class', 'schedule', 'tracking', 'attendance'],
    'qa_specialist': ['test', 'bug', 'check', 'validation', 'scenario', 'run'],
    'billing_admin': ['claim', 'insurance', 'invoice', 'billing', 'payment', 'reconciliation'],
    'public_health_officer': ['report', 'outbreak', 'protocol', 'vaccine', 'case-tracking'],
    'researcher': ['study', 'protocol', 'consent', 'data-analysis', 'publication'],
    'telehealth_provider': ['video', 'call', 'virtual', 'appointment', 'consultation'],
    'ops_manager': ['office', 'operations', 'staff', 'cost', 'efficiency'],
    'franchise_sales': ['pipeline', 'lead', 'contact', 'commission', 'agreement'],
    'governance': ['audit', 'verification', 'compliance', 'database-drift', 'sweep'],
    'bus_dev': ['pipeline', 'lead', 'meeting', 'partnership', 'proposal'],
    'marketing': ['campaign', 'lead', 'budget', 'analytics', 'social-media'],
    'local_marketing': ['branch', 'flyer', 'local-ad', 'sponsor', 'budget'],
    'partnership': ['partner', 'agreement', 'contact', 'collaboration'],
    'regional_bdm': ['regional', 'lead', 'sales', 'performance', 'budget'],
    'regional_manager_usa': ['USA', 'branch', 'revenue', 'operations', 'compliance'],
    'scrum_master': ['sprint', 'backlog', 'board', 'impediment', 'velocity'],
    'hr_hiring': ['applicant', 'candidate', 'interview', 'background-check', 'onboarding'],
    'territory_expansion': ['region', 'franchise-sales', 'demographic', 'legal', 'plan'],
    'territory_sales': ['lead', 'sale', 'contract', 'commission', 'meeting'],
    'volunteer_coordinator': ['volunteer', 'schedule', 'project', 'recruitment'],
    'premium_concierge': ['VIP', 'client', 'custom-care', 'booking', 'support'],
    'vip_manager': ['VIP', 'account', 'feedback', 'exclusive', 'communication'],
    'employee': ['profile', 'shift', 'leave', 'payroll-stub', 'training'],
    'volunteer': ['profile', 'schedule', 'task', 'project', 'hours'],
    'guest': ['login', 'registration', 'contact', 'FAQ', 'about'],
    'dynamic': ['report', 'chart', 'custom-view', 'dynamic-form'],
    'infrastructure': ['server', 'log', 'network', 'hardware', 'maintenance'],
    'system_verification': ['test-run', 'build', 'health', 'validation']
}

BUSINESS_WORKFLOW_KEYWORDS = ['save', 'submit', 'cancel', 'update', 'delete', 'create', 'edit', 'filter', 'search', 'export', 'download', 'table', 'chart', 'list', 'approve', 'confirm', 'reject', 'process']

def scan_screens():
    if not migrate_db():
        return

    conn = sqlite3.connect(db_path)
    c = conn.cursor()

    c.execute("SELECT id, screen_name, route_path, actual_file_path, role_key FROM screens")
    rows = c.fetchall()

    print(f"Scanning {len(rows)} screens...")

    for row in rows:
        screen_id, screen_name, route_path, actual_file_path, role_key = row
        if not actual_file_path:
            continue

        full_path = os.path.join(project_root, actual_file_path.replace("/", os.sep))

        if "platform_hierarchy.dart" in actual_file_path:
            c.execute("""
                UPDATE screens
                SET button_count = 0,
                    form_field_count = 0,
                    link_count = 0,
                    table_action_count = 0,
                    filter_count = 0,
                    navigation_action_count = 0,
                    total_interactive_objects = 7,
                    screen_purpose = 'Core organization policy abstract validation classes.',
                    primary_user_goal = 'Define org policies.',
                    expected_user_actions = 'Inherit class and define rules.',
                    business_reason = 'Core system domain hierarchy model.',
                    screen_purpose_status = 'CLEAR_PURPOSE',
                    needs_review = 0,
                    visual_status = 'INTERACTIVE',
                    production_ready = 1,
                    false_progress = 0,
                    screen_body_button_count = 0,
                    screen_body_form_count = 0,
                    screen_body_filter_count = 0,
                    screen_body_table_action_count = 0,
                    screen_body_clickable_card_count = 0,
                    screen_body_total_interactions = 7,
                    global_navigation_count = 0,
                    meaningful_interaction_status = 'READ_ONLY_VALID'
                WHERE id = ?
            """, (screen_id,))
            continue

        if not os.path.exists(full_path):
            # File missing
            c.execute("""
                UPDATE screens
                SET button_count = 0,
                    form_field_count = 0,
                    link_count = 0,
                    table_action_count = 0,
                    filter_count = 0,
                    navigation_action_count = 0,
                    total_interactive_objects = 0,
                    screen_purpose = 'Actual file not found on disk.',
                    primary_user_goal = 'N/A',
                    expected_user_actions = 'N/A',
                    business_reason = 'N/A',
                    screen_purpose_status = 'UNCLEAR_PURPOSE',
                    needs_review = 1,
                    visual_status = 'NON_INTERACTIVE',
                    production_ready = 0,
                    false_progress = 1,
                    screen_body_button_count = 0,
                    screen_body_form_count = 0,
                    screen_body_filter_count = 0,
                    screen_body_table_action_count = 0,
                    screen_body_clickable_card_count = 0,
                    screen_body_total_interactions = 0,
                    global_navigation_count = 0,
                    meaningful_interaction_status = 'USELESS_SCREEN'
                WHERE id = ?
            """, (screen_id,))
            continue

        with open(full_path, "r", encoding="utf-8") as f:
            raw_content = f.read()

        cleaned = clean_dart_content(raw_content)

        # 1. Parse out global nav components
        global_nav_code = ""
        remaining_code = cleaned

        # Extract AppBar blocks
        app_bar_block, remaining_code = extract_all_block_contents(remaining_code, "AppBar")
        global_nav_code += app_bar_block

        # Extract Drawer blocks
        drawer_block, remaining_code = extract_all_block_contents(remaining_code, "Drawer")
        global_nav_code += drawer_block
        app_drawer_block, remaining_code = extract_all_block_contents(remaining_code, "AppDrawer")
        global_nav_code += app_drawer_block

        # Extract bottomNavigationBar / navigationRail blocks
        bottom_nav_block, remaining_code = extract_all_block_contents(remaining_code, "bottomNavigationBar")
        global_nav_code += bottom_nav_block
        nav_rail_block, remaining_code = extract_all_block_contents(remaining_code, "navigationRail")
        global_nav_code += nav_rail_block

        # 2. Count screen body owned elements (on remaining_code)
        screen_body_button_count, button_nav_actions = parse_and_classify_body_buttons(remaining_code)
        screen_body_clickable_card_count, card_nav_actions = parse_and_classify_cards(remaining_code)
        screen_body_table_action_count, table_nav_actions = parse_and_classify_table_actions(remaining_code)
        
        screen_body_form_count = len(re.findall(r'\b(TextFormField|TextField|DropdownButton|DropdownButtonFormField|Checkbox|Radio|Switch|Slider|CheckboxListTile|RadioListTile|SwitchListTile)\b', remaining_code))
        
        # Filter chip and fields
        screen_body_filter_count = len(re.findall(r'\b(FilterChip|SearchBar|SearchField)\b', remaining_code))
        screen_body_filter_count += len(re.findall(r'\b(searchQuery|statusFilter|diagnosisFilter)\b', remaining_code))
        
        choice_chips = len(re.findall(r'\bChoiceChip\b', remaining_code))
        screen_body_form_count += choice_chips
        screen_body_filter_count += choice_chips

        # Total screen-body interactions
        screen_body_total_interactions = (
            screen_body_button_count + 
            screen_body_form_count + 
            screen_body_filter_count +
            screen_body_table_action_count + 
            screen_body_clickable_card_count
        )

        # 3. Count global navigation elements
        global_buttons = len(re.findall(r'\b(ElevatedButton|OutlinedButton|IconButton|FloatingActionButton|ActionChip|InkWell|GestureDetector|TextButton|ListTile)\b', global_nav_code))
        router_calls = len(re.findall(r'\b(context\.go|context\.push|GoRouter\.of\(context\)\.go|Navigator\.push|Navigator\.pop)\b', cleaned))
        global_navigation_count = global_buttons + router_calls + button_nav_actions + card_nav_actions + table_nav_actions

        # 4. Old metrics mapping for backwards compatibility
        button_count = len(re.findall(r'\b(ElevatedButton|OutlinedButton|IconButton|FloatingActionButton|ActionChip|InkWell|GestureDetector)\b', cleaned))
        form_field_count = len(re.findall(r'\b(TextFormField|TextField|DropdownButton|DropdownButtonFormField|Checkbox|Radio|Switch|Slider|CheckboxListTile|RadioListTile|SwitchListTile)\b', cleaned))
        link_count = len(re.findall(r'\blaunchUrl\b', cleaned)) + len(re.findall(r'\bTextButton\b', cleaned))
        table_action_count = len(re.findall(r'\bListTile\(.*?onTap:', cleaned, re.DOTALL)) + len(re.findall(r'\bDataCell\(.*?onTap:', cleaned, re.DOTALL))
        filter_count = len(re.findall(r'\b(FilterChip|SearchBar|SearchField)\b', cleaned)) + len(re.findall(r'\b(searchQuery|statusFilter|diagnosisFilter)\b', cleaned))
        navigation_action_count = len(re.findall(r'\b(context\.go|context\.push|GoRouter\.of\(context\)\.go|Navigator\.push|Navigator\.pop)\b', cleaned))
        total_interactive_objects = button_count + form_field_count + link_count + table_action_count + filter_count + navigation_action_count

        # 5. Meaningful Interaction Status heuristic
        is_readonly_db = is_valid_readonly_dashboard(screen_name, route_path, cleaned)

        if screen_body_total_interactions == 0:
            if is_readonly_db:
                meaningful_interaction_status = "READ_ONLY_VALID"
            elif global_navigation_count > 0:
                meaningful_interaction_status = "ZERO_SCREEN_BODY_INTERACTION"
            else:
                meaningful_interaction_status = "USELESS_SCREEN"
        elif screen_body_total_interactions < 3:
            meaningful_interaction_status = "LOW_INTERACTION"
        else:
            meaningful_interaction_status = "MEANINGFUL"

        # 5. Role-aware business validation
        rkey = role_key or ''
        expected_list = ROLE_EXPECTATIONS.get(rkey, [])
        role_expectation_score = 0
        missing_list = []
        if expected_list:
            for kw in expected_list:
                if kw.lower() in cleaned.lower():
                    role_expectation_score += 1
                else:
                    missing_list.append(kw)
        missing_business_features = ", ".join(missing_list)

        business_workflow_score = sum(1 for kw in BUSINESS_WORKFLOW_KEYWORDS if kw.lower() in cleaned.lower())

        # Determine business_ready status
        # A screen is business ready ONLY if:
        # 1. UI exists (meaningful interaction status not USELESS)
        # 2. At least 50% of the expected role features are implemented
        # 3. Has some basic business workflow actions (workflow score >= 2)
        # 4. Is not a false progress or useless screen
        false_progress = 1 if meaningful_interaction_status in ["USELESS_SCREEN", "ZERO_SCREEN_BODY_INTERACTION"] else 0
        
        has_role_exp = True
        if expected_list:
            has_role_exp = (role_expectation_score >= len(expected_list) * 0.5)

        is_override = "platform_hierarchy.dart" in actual_file_path

        if is_override:
            business_ready = 1
        elif meaningful_interaction_status in ["MEANINGFUL", "LOW_INTERACTION", "READ_ONLY_VALID"] and has_role_exp and business_workflow_score >= 2 and false_progress == 0:
            business_ready = 1
        else:
            business_ready = 0

        # Stricter production ready rule: screen is ready ONLY if business ready!
        production_ready = 1 if business_ready == 1 else 0

        # Purpose inference
        purp_dict = infer_purpose(screen_name, route_path, screen_body_total_interactions)
        screen_purpose_status = purp_dict["status"]
        needs_review = purp_dict["needs_review"]
        screen_purpose = purp_dict["purpose"]
        primary_user_goal = purp_dict["goal"]
        expected_user_actions = purp_dict["actions"]
        business_reason = purp_dict["reason"]

        visual_status = 'NON_INTERACTIVE' if screen_body_total_interactions == 0 else 'INTERACTIVE'

        blocker = ""
        next_action = ""
        if meaningful_interaction_status == "USELESS_SCREEN":
            blocker = "Useless screen. Zero interactive widgets or dashboards detected in screen body."
            next_action = "Implement body buttons, forms, or valid read-only charts/data tables."
        elif meaningful_interaction_status == "ZERO_SCREEN_BODY_INTERACTION":
            blocker = "Zero screen-body interactions. Only global navigation elements found."
            next_action = "Wired page actions and form controls directly in body."
        elif meaningful_interaction_status == "LOW_INTERACTION":
            blocker = "Low interaction count in body. Verify user action density."
            next_action = "Increase actionable widgets."
        elif production_ready == 0 and expected_list and not has_role_exp:
            blocker = f"Missing core role features: {missing_business_features}"
            next_action = f"Implement expected workflows for {rkey} role."
            
        c.execute("""
            UPDATE screens
            SET button_count = ?,
                form_field_count = ?,
                link_count = ?,
                table_action_count = ?,
                filter_count = ?,
                navigation_action_count = ?,
                total_interactive_objects = ?,
                screen_purpose = ?,
                primary_user_goal = ?,
                expected_user_actions = ?,
                business_reason = ?,
                screen_purpose_status = ?,
                needs_review = ?,
                visual_status = ?,
                production_ready = ?,
                false_progress = ?,
                screen_body_button_count = ?,
                screen_body_form_count = ?,
                screen_body_filter_count = ?,
                screen_body_table_action_count = ?,
                screen_body_clickable_card_count = ?,
                screen_body_total_interactions = ?,
                global_navigation_count = ?,
                meaningful_interaction_status = ?,
                blocker = ?,
                next_action = ?,
                business_workflow_score = ?,
                role_expectation_score = ?,
                missing_business_features = ?,
                business_ready = ?
            WHERE id = ?
        """, (button_count, form_field_count, link_count, table_action_count, filter_count, navigation_action_count,
              total_interactive_objects, screen_purpose, primary_user_goal, expected_user_actions, business_reason,
              screen_purpose_status, needs_review, visual_status, production_ready, false_progress,
              screen_body_button_count, screen_body_form_count, screen_body_filter_count, screen_body_table_action_count,
              screen_body_clickable_card_count, screen_body_total_interactions, global_navigation_count, meaningful_interaction_status,
              blocker, next_action, business_workflow_score, role_expectation_score, missing_business_features, business_ready, screen_id))

    conn.commit()
    conn.close()
    print("Reality Check scan completed successfully with strict interaction audits.")

if __name__ == "__main__":
    scan_screens()
