import os
import sqlite3
import json

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def upgrade_schema_and_seed():
    print("=====================================================")
    print("Executing Screen Hierarchy & Navigation Migration")
    print("=====================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: SQLite database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # 1. Alter screens table to add the 8 new columns (Self-healing)
    new_columns = [
        ("module_name", "TEXT"),
        ("screen_group", "TEXT"),
        ("parent_screen_code", "TEXT"),
        ("menu_section", "TEXT"),
        ("navigation_order", "INTEGER DEFAULT 50"),
        ("is_command_center", "INTEGER DEFAULT 0"),
        ("workflow_stage", "TEXT"),
        ("duplicate_of_screen_id", "INTEGER")
    ]

    cursor.execute("PRAGMA table_info(screens);")
    existing_cols = [row['name'] for row in cursor.fetchall()]

    for col_name, col_type in new_columns:
        if col_name not in existing_cols:
            print(f"Adding column '{col_name}' to 'screens' table...")
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type};")
        else:
            print(f"Column '{col_name}' already exists.")

    # 2. Create screen_navigation_map table
    print("Creating 'screen_navigation_map' table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_navigation_map (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      source_screen_id INTEGER NOT NULL,
      target_screen_id INTEGER NOT NULL,
      navigation_type TEXT, -- drill_down, modal, workflow_step, back_navigation
      trigger_action TEXT, -- onPressed, onSelect, onComplete, onDischarge
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY(source_screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY(target_screen_id) REFERENCES screens(id) ON DELETE CASCADE
    );
    """)

    # 3. Load all screens to apply modular classification rulesets
    print("Classifying and updating modular statistics for all screens...")
    cursor.execute("SELECT id, screen_name, screen_code, expected_file_path, route_path, allowed_roles_text, role_id FROM screens;")
    screens = cursor.fetchall()
    print(f"Loaded {len(screens)} screens to classify.")

    for scr in screens:
        scr_id = scr['id']
        scr_name = scr['screen_name']
        scr_code = scr['screen_code']
        file_path = scr['expected_file_path'] or ''
        role_id = scr['role_id']
        
        # A. Module Name
        if 'executive' in file_path or 'governance' in file_path or 'compliance' in file_path or 'sec' in scr_code:
            module_name = "Governance & Compliance"
        elif 'clinical' in file_path or 'rn' in file_path or 'rpn' in file_path or 'allied' in file_path or 'patient' in scr_code or 'vitals' in scr_code:
            module_name = "Clinical & Care Planning"
        elif 'psw' in file_path or 'care' in scr_code:
            module_name = "Caregiving Services"
        elif 'finance' in scr_code or 'billing' in scr_code or 'revenue' in scr_code or 'expense' in scr_code or 'payroll' in scr_code or 'tax' in scr_code:
            module_name = "Finance & Billing"
        elif 'management' in file_path or 'franchise' in file_path or 'staff' in file_path or 'sched' in scr_code or 'workflow' in scr_code:
            module_name = "Operations & Scheduling"
        else:
            module_name = "Core Platform Services"

        # B. Screen Group
        if "4K" in scr_name or "CommandCenter" in scr_name or "Hub" in scr_name:
            screen_group = "Command Center"
        elif "Dashboard" in scr_name or "Overview" in scr_name:
            screen_group = "Dashboard"
        elif "Analytics" in scr_name or "Report" in scr_name or "Metrics" in scr_name or "Trends" in scr_name or "Audit" in scr_name:
            screen_group = "Reports & Analytics"
        elif "List" in scr_name or "Manage" in scr_name or "View" in scr_name or "Details" in scr_name or "Form" in scr_name or "Entry" in scr_name or "Log" in scr_name:
            screen_group = "CRUD & Details"
        elif "Workflow" in scr_name or "Intake" in scr_name or "Wizard" in scr_name or "Session" in scr_name or "Track" in scr_name:
            screen_group = "Workflow & Wizards"
        else:
            screen_group = "Transactional"

        # C. Is Command Center
        is_command_center = 1 if ("4K" in scr_name or "CommandCenter" in scr_name) else 0

        # D. Menu Section
        if is_command_center == 1:
            menu_section = "Command Centers"
        elif screen_group == "Dashboard":
            menu_section = "Overview Dashboards"
        elif screen_group == "Reports & Analytics":
            menu_section = "Analytics & Reports"
        elif screen_group == "Workflow & Wizards":
            menu_section = "Workflows"
        else:
            menu_section = "Operational Workspaces"

        # E. Workflow Stage
        if "Intake" in scr_name or "Registration" in scr_name or "Admit" in scr_name or "Onboard" in scr_name:
            workflow_stage = "Intake & Onboarding"
        elif "Plan" in scr_name or "Chart" in scr_name or "Vitals" in scr_name or "Medication" in scr_name or "Visit" in scr_name or "Care" in scr_name:
            workflow_stage = "Treatment & Clinical Care"
        elif "Billing" in scr_name or "Invoice" in scr_name or "Revenue" in scr_name or "Payroll" in scr_name or "Tax" in scr_name or "Financial" in scr_name:
            workflow_stage = "Billing & Remittance"
        elif "Audit" in scr_name or "Log" in scr_name or "Compliance" in scr_name or "Security" in scr_name:
            workflow_stage = "Governance & Audit"
        else:
            workflow_stage = "General Operations"

        # F. Navigation Order
        if screen_group == "Command Center":
            navigation_order = 10
        elif screen_group == "Dashboard":
            navigation_order = 20
        elif screen_group == "Workflow & Wizards":
            navigation_order = 30
        elif screen_group == "Reports & Analytics":
            navigation_order = 40
        else:
            navigation_order = 50

        cursor.execute("""
            UPDATE screens
            SET
                module_name = ?,
                screen_group = ?,
                menu_section = ?,
                is_command_center = ?,
                workflow_stage = ?,
                navigation_order = ?
            WHERE id = ?;
        """, (
            module_name,
            screen_group,
            menu_section,
            is_command_center,
            workflow_stage,
            navigation_order,
            scr_id
        ))

    conn.commit()
    print("Classifications seeded successfully.")

    # 4. Determine Parent Screen Hierarchy Tree
    print("\nMapping role-based parent-child hierarchies...")
    cursor.execute("SELECT DISTINCT role_id FROM screens WHERE role_id IS NOT NULL;")
    roles = [r['role_id'] for r in cursor.fetchall()]

    for r_id in roles:
        # Find the primary main screen (Dashboard or Command Center) for this role
        cursor.execute("""
            SELECT screen_code, screen_name 
            FROM screens 
            WHERE role_id = ? 
            ORDER BY is_command_center DESC, 
                     CASE screen_group WHEN 'Command Center' THEN 1 WHEN 'Dashboard' THEN 2 ELSE 3 END ASC,
                     navigation_order ASC, 
                     id ASC 
            LIMIT 1;
        """, (r_id,))
        parent_row = cursor.fetchone()
        
        if parent_row:
            p_code = parent_row['screen_code']
            print(f"Role ID {r_id}: Selected parent screen '{parent_row['screen_name']}' ({p_code})")
            
            # Update all child screens under this role
            cursor.execute("""
                UPDATE screens
                SET parent_screen_code = ?
                WHERE role_id = ? AND screen_code != ?;
            """, (p_code, r_id, p_code))
            
            # Explicitly set parent screen's own parent to NULL
            cursor.execute("""
                UPDATE screens
                SET parent_screen_code = NULL
                WHERE role_id = ? AND screen_code = ?;
            """, (r_id, p_code))

    conn.commit()
    print("Hierarchies successfully established.")

    # 5. Populate navigation map table
    print("\nPopulating 'screen_navigation_map' table...")
    # Clear existing mapping to ensure no duplicates on re-run
    cursor.execute("DELETE FROM screen_navigation_map;")

    # Link parent screens to child screens (workspace drill-downs)
    cursor.execute("SELECT id, parent_screen_code, screen_group, screen_name FROM screens WHERE parent_screen_code IS NOT NULL;")
    child_screens = cursor.fetchall()
    
    links_count = 0
    for child in child_screens:
        child_id = child['id']
        p_code = child['parent_screen_code']
        group = child['screen_group']
        
        cursor.execute("SELECT id FROM screens WHERE screen_code = ? LIMIT 1;", (p_code,))
        p_row = cursor.fetchone()
        if p_row:
            p_id = p_row['id']
            nav_type = "drill_down" if group in ("Reports & Analytics", "CRUD & Details") else "workspace_launch"
            trigger = "onPressed"
            
            cursor.execute("""
                INSERT INTO screen_navigation_map (source_screen_id, target_screen_id, navigation_type, trigger_action)
                VALUES (?, ?, ?, ?);
            """, (p_id, child_id, nav_type, trigger))
            links_count += 1

    # Link workflow sequences dynamically (Intake ➔ Charting ➔ Billing ➔ Audit)
    print("Seeding sequence workflow traversal pathways...")
    cursor.execute("SELECT DISTINCT module_name FROM screens WHERE module_name != 'Core Platform Services';")
    modules = [m['module_name'] for m in cursor.fetchall()]

    for mod in modules:
        # Find intake screen, charting screen, and billing screen within this module
        cursor.execute("SELECT id FROM screens WHERE module_name = ? AND workflow_stage = 'Intake & Onboarding' LIMIT 1;", (mod,))
        intake = cursor.fetchone()
        
        cursor.execute("SELECT id FROM screens WHERE module_name = ? AND workflow_stage = 'Treatment & Clinical Care' LIMIT 1;", (mod,))
        treatment = cursor.fetchone()
        
        cursor.execute("SELECT id FROM screens WHERE module_name = ? AND workflow_stage = 'Billing & Remittance' LIMIT 1;", (mod,))
        billing = cursor.fetchone()

        cursor.execute("SELECT id FROM screens WHERE module_name = ? AND workflow_stage = 'Governance & Audit' LIMIT 1;", (mod,))
        audit = cursor.fetchone()

        # Chain them together if they exist
        if intake and treatment:
            cursor.execute("""
                INSERT INTO screen_navigation_map (source_screen_id, target_screen_id, navigation_type, trigger_action)
                VALUES (?, ?, 'workflow_step', 'onComplete');
            """, (intake['id'], treatment['id']))
            links_count += 1
            
        if treatment and billing:
            cursor.execute("""
                INSERT INTO screen_navigation_map (source_screen_id, target_screen_id, navigation_type, trigger_action)
                VALUES (?, ?, 'workflow_step', 'onDischarge');
            """, (treatment['id'], billing['id']))
            links_count += 1

        if billing and audit:
            cursor.execute("""
                INSERT INTO screen_navigation_map (source_screen_id, target_screen_id, navigation_type, trigger_action)
                VALUES (?, ?, 'workflow_step', 'onAuditSubmit');
            """, (billing['id'], audit['id']))
            links_count += 1

    conn.commit()
    print(f"Populated {links_count} parent-child and workflow transitions in 'screen_navigation_map'.")

    # 6. Deploy View for duplicate similarity tracking
    print("\nDeploying duplicate screen similarity tracking view 'v_duplicate_or_similar_screens'...")
    cursor.execute("DROP VIEW IF EXISTS v_duplicate_or_similar_screens;")
    cursor.execute("""
    CREATE VIEW v_duplicate_or_similar_screens AS
    SELECT 
        s1.id AS screen_id,
        s1.screen_name,
        s1.screen_code,
        s1.screen_type,
        s1.module_name,
        s2.id AS similar_screen_id,
        s2.screen_name AS similar_screen_name,
        s2.screen_code AS similar_screen_code,
        s2.screen_type AS similar_screen_type,
        CASE 
            WHEN s1.screen_name = s2.screen_name THEN 'exact_duplicate'
            WHEN s1.screen_name LIKE '%' || REPLACE(s2.screen_name, 'Dashboard', '') || '%' THEN 'high_similarity'
            WHEN s1.screen_code LIKE '%' || REPLACE(s2.screen_code, 'dashboard', '') || '%' THEN 'high_similarity'
            ELSE 'role_overlap'
        END AS similarity_type
    FROM screens s1
    JOIN screens s2 ON s1.id < s2.id 
    WHERE (s1.screen_name = s2.screen_name)
       OR (s1.screen_code LIKE '%' || REPLACE(s2.screen_code, 'dashboard', '') || '%' AND s1.role_id = s2.role_id)
       OR (s1.screen_name LIKE '%' || REPLACE(s2.screen_name, 'Dashboard', '') || '%' AND s1.role_id = s2.role_id);
    """)

    conn.commit()
    
    # 7. Print final statistics
    cursor.execute("SELECT module_name, COUNT(*) FROM screens GROUP BY module_name;")
    print("\nScreens count by Module:")
    for row in cursor.fetchall():
        print(f"  - {row[0]}: {row[1]}")

    cursor.execute("SELECT screen_group, COUNT(*) FROM screens GROUP BY screen_group;")
    print("\nScreens count by Screen Group:")
    for row in cursor.fetchall():
        print(f"  - {row[0]}: {row[1]}")

    conn.close()
    print("\nMigration Completed Successfully. Governance database upgraded to Stage 5!")

if __name__ == "__main__":
    upgrade_schema_and_seed()
