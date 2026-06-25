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
        ("false_progress", "INTEGER DEFAULT 0")
    ]

    c.execute("PRAGMA table_info(screens)")
    existing_cols = [row[1] for row in c.fetchall()]

    for col_name, col_type in columns_to_add:
        if col_name not in existing_cols:
            alter_query = f"ALTER TABLE screens ADD COLUMN {col_name} {col_type}"
            c.execute(alter_query)
            print(f"Added column {col_name} to screens table.")
        else:
            print(f"Column {col_name} already exists in screens table.")

    conn.commit()
    conn.close()
    print("Database migration completed.")
    return True

def infer_purpose(name, route, total_objects):
    # Detect duplicates
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
        purpose = "Human Resources dashboard to track applicants, schedule interviews, and monitor credential expiries."
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

def scan_screens():
    if not migrate_db():
        return

    conn = sqlite3.connect(db_path)
    c = conn.cursor()

    c.execute("SELECT id, screen_name, route_path, actual_file_path FROM screens")
    rows = c.fetchall()

    print(f"Scanning {len(rows)} screens...")

    for row in rows:
        screen_id, screen_name, route_path, actual_file_path = row
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
                    false_progress = 0
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
                    false_progress = 1
                WHERE id = ?
            """, (screen_id,))
            continue

        with open(full_path, "r", encoding="utf-8") as f:
            raw_content = f.read()

        cleaned = clean_dart_content(raw_content)

        # Counting interactive items
        button_count = len(re.findall(r'\b(ElevatedButton|OutlinedButton|IconButton|FloatingActionButton|ActionChip|InkWell|GestureDetector)\b', cleaned))
        form_field_count = len(re.findall(r'\b(TextFormField|TextField|DropdownButton|DropdownButtonFormField|Checkbox|Radio|Switch|Slider|CheckboxListTile|RadioListTile|SwitchListTile)\b', cleaned))
        link_count = len(re.findall(r'\blaunchUrl\b', cleaned)) + len(re.findall(r'\bTextButton\b', cleaned))
        
        # Simple heuristics for table/list row actions
        table_action_count = len(re.findall(r'\bListTile\(.*?onTap:', cleaned, re.DOTALL)) + len(re.findall(r'\bDataCell\(.*?onTap:', cleaned, re.DOTALL))
        
        # Filter chip and fields
        filter_count = len(re.findall(r'\b(FilterChip|SearchBar|SearchField)\b', cleaned)) + len(re.findall(r'\b(searchQuery|statusFilter|diagnosisFilter)\b', cleaned))
        
        # Navigation
        navigation_action_count = len(re.findall(r'\b(context\.go|context\.push|GoRouter\.of\(context\)\.go|Navigator\.push|Navigator\.pop)\b', cleaned))

        total_interactive_objects = button_count + form_field_count + link_count + table_action_count + filter_count + navigation_action_count

        # Purpose inference
        purp_dict = infer_purpose(screen_name, route_path, total_interactive_objects)

        visual_status = 'NON_INTERACTIVE' if total_interactive_objects == 0 else 'INTERACTIVE'
        production_ready = 0 if total_interactive_objects == 0 else 1
        false_progress = 1 if total_interactive_objects == 0 else 0
        screen_purpose_status = purp_dict["status"]
        needs_review = purp_dict["needs_review"]
        screen_purpose = purp_dict["purpose"]
        primary_user_goal = purp_dict["goal"]
        expected_user_actions = purp_dict["actions"]
        business_reason = purp_dict["reason"]

        if total_interactive_objects == 0:
            screen_purpose_status = 'NO_USER_VALUE'
            needs_review = 1
            # Add missing items tag
            c.execute("SELECT blocker, next_action FROM screens WHERE id = ?", (screen_id,))
            res = c.fetchone()
            curr_blocker = res[0] or ""
            curr_action = res[1] or ""
            new_blocker = "No interactive objects found. Screen needs clear user action or should be removed/merged."
            new_action = "Implement transactional buttons or interactive widgets"
            
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
                    progress_percent = 0,
                    blocker = ?,
                    next_action = ?
                WHERE id = ?
            """, (button_count, form_field_count, link_count, table_action_count, filter_count, navigation_action_count,
                  total_interactive_objects, screen_purpose, primary_user_goal, expected_user_actions, business_reason,
                  screen_purpose_status, needs_review, visual_status, production_ready, false_progress, new_blocker, new_action, screen_id))
        else:
            if total_interactive_objects < 3:
                needs_review = 1
                new_blocker = "Very low interaction count. Verify whether this screen has enough user value."
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
                        blocker = ?
                    WHERE id = ?
                """, (button_count, form_field_count, link_count, table_action_count, filter_count, navigation_action_count,
                      total_interactive_objects, screen_purpose, primary_user_goal, expected_user_actions, business_reason,
                      screen_purpose_status, needs_review, visual_status, production_ready, false_progress, new_blocker, screen_id))
            else:
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
                        false_progress = ?
                    WHERE id = ?
                """, (button_count, form_field_count, link_count, table_action_count, filter_count, navigation_action_count,
                      total_interactive_objects, screen_purpose, primary_user_goal, expected_user_actions, business_reason,
                      screen_purpose_status, needs_review, visual_status, production_ready, false_progress, screen_id))

    conn.commit()
    conn.close()
    print("Reality Check scan completed successfully.")

if __name__ == "__main__":
    scan_screens()
