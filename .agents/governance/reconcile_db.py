import os
import re
import sys
import sqlite3

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

def find_dashboard_files(screens_dir):
    files = []
    for root, _, filenames in os.walk(screens_dir):
        for name in filenames:
            name_lower = name.lower()
            if name_lower.endswith('_dashboard_screen.dart') or name_lower.endswith('_dashboard.dart'):
                files.append(os.path.join(root, name))
    return files

def reconcile():
    print("=====================================================")
    print("Starting SQL-Backed Sidebar Reconciliation Engine")
    print("=====================================================")

    screens_dir = r"packages\primecare_ui\lib\src\screens"
    report_path = r".agents\governance\sidebar_governance_report.md"

    if not os.path.exists(screens_dir):
        print(f"[ERROR] Screen directory not found: {screens_dir}")
        sys.exit(1)

    # Discover files
    files = find_dashboard_files(screens_dir)
    print(f"Discovered {len(files)} physical dashboard screen files on disk.")

    conn = governance_db.get_connection()
    cursor = conn.cursor()

    # Load master expected configuration from the SQLite DB
    cursor.execute("SELECT screen_id, screen_name, path, requires_sidebar, category FROM dashboards;")
    db_dashboards = {row['screen_id']: dict(row) for row in cursor.fetchall()}

    anomalies = []
    parsed_screens = {}

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
        screen_id = _camel_to_snake(class_name.replace('Screen', ''))

        has_physical_sidebar = ('ResponsiveSplitDashboard' in content) or ('defaultSidebarWidgets:' in content)

        physical_items = []
        if has_physical_sidebar:
            sidebar_block_content = content
            start_idx = content.find('defaultSidebarWidgets:')
            if start_idx != -1:
                sidebar_block_content = _extract_matching_block(content, start_idx)

            # Parse QuickActionItems
            action_regex = r'''QuickActionItem\(\s*label:\s*["']([^"']+)["'][\s\S]*?onTap:\s*(.*?)(?:,|\n\s*\))'''
            action_matches = re.finditer(action_regex, sidebar_block_content, re.IGNORECASE)
            for match in action_matches:
                label = match.group(1)
                raw_callback = match.group(2).strip()
                item_id = _camel_to_snake(label.replace(' ', ''))
                status = _analyze_callback(raw_callback, content)
                
                physical_items.append({
                    'id': item_id,
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
                    'id': 'capacity_slider',
                    'label': 'Threshold Capacity Adjuster',
                    'type': 'interactive_slider',
                    'callback': 'onChanged: (val) { controller.updateThreshold(...) }',
                    'status': 'api_connected' if file_has_real_api else 'mock_stub'
                })
            if 'AuditLogConsole' in content or 'Operational Audit Logs' in content:
                physical_items.append({
                    'id': 'audit_logs_terminal',
                    'label': 'Live Auditing timeline Console',
                    'type': 'log_timeline',
                    'callback': 'state.logs',
                    'status': 'api_connected' if file_has_real_api else 'mock_stub'
                })

        # Category mapping
        path_parts = relative_path.split('/')
        category = 'common'
        if 'screens' in path_parts:
            screens_idx = path_parts.index('screens')
            if screens_idx + 1 < len(path_parts):
                category = path_parts[screens_idx + 1]

        parsed_screens[screen_id] = {
            'screen_name': class_name,
            'path': relative_path,
            'has_physical_sidebar': has_physical_sidebar,
            'sidebar_items': physical_items,
            'category': category
        }

    # ==========================================
    # DATABASE & ZERO-TRUST RECONCILIATION AUDIT
    # ==========================================

    # 1. Check for Undocumented Screens (On Disk but not in SQLite DB)
    for screen_id, parsed in parsed_screens.items():
        if screen_id not in db_dashboards:
            anomalies.append(f"- **[ERROR]** Undocumented Screen: Physical dashboard screen `{parsed['screen_name']}` has no corresponding configuration block in database.")
            # Insert stub undocumented screen so it doesn't crash the database lookup
            cursor.execute("""
            INSERT OR REPLACE INTO dashboards (screen_id, screen_name, path, requires_sidebar, category, layout_compliant)
            VALUES (?, ?, ?, ?, ?, 0)
            """, (screen_id, parsed['screen_name'], parsed['path'], 1 if parsed['has_physical_sidebar'] else 0, parsed['category']))
            
            for item in parsed['sidebar_items']:
                cursor.execute("""
                INSERT OR REPLACE INTO sidebar_items (screen_id, item_id, label, type, expected_handler, status)
                VALUES (?, ?, ?, ?, ?, ?)
                """, (screen_id, item['id'], item['label'], item['type'], item['callback'], 'mock_stub' if item['status'] == 'mock_stub' else 'api_connected'))
            conn.commit()

    # Refresh DB dashboards list
    cursor.execute("SELECT screen_id, screen_name, path, requires_sidebar, category FROM dashboards;")
    db_dashboards = {row['screen_id']: dict(row) for row in cursor.fetchall()}

    # 2. Check for Mismatched Registry (Registered in SQLite DB but missing on Disk)
    for screen_id, db_sb in db_dashboards.items():
        if screen_id not in parsed_screens:
            anomalies.append(f"- **[ERROR]** Mismatched Registry: Sidebar registry expects screen `{screen_id}` at `{db_sb['path']}`, but the file does not exist on disk.")

    # 3. Perform Layout compliance & Sidebar item validation
    for screen_id, db_sb in db_dashboards.items():
        if screen_id not in parsed_screens:
            continue
        
        parsed = parsed_screens[screen_id]
        requires_sidebar = db_sb['requires_sidebar'] == 1
        has_physical = parsed['has_physical_sidebar']
        
        # Update layout conformity in DB
        is_layout_compliant = 1 if (has_physical == requires_sidebar) else 0
        cursor.execute("UPDATE dashboards SET layout_compliant = ? WHERE screen_id = ?", (is_layout_compliant, screen_id))
        
        if not is_layout_compliant:
            anomalies.append(f"- **[ERROR]** Layout Mismatch: Dashboard `{parsed['screen_name']}` layout is {'Split Dual-Panel' if has_physical else 'Single-Column'} in code, but database expects {'Split Dual-Panel' if requires_sidebar else 'Single-Column'}.")

        # Retrieve expected items from the SQLite DB
        cursor.execute("SELECT item_id, label, type, expected_handler, status FROM sidebar_items WHERE screen_id = ?", (screen_id,))
        expected_items = {row['item_id']: dict(row) for row in cursor.fetchall()}
        
        physical_item_map = {item['id']: item for item in parsed['sidebar_items']}

        # Loop through expected items and check physical presence
        for item_id, exp_item in expected_items.items():
            phys = physical_item_map.get(item_id)
            if not phys:
                anomalies.append(f"- **[WARNING]** Missing Widget: expected sidebar item `{exp_item['label']}` (ID: `{item_id}`) in `{parsed['screen_name']}` is missing in the physical code.")
                cursor.execute("UPDATE sidebar_items SET status = 'pending', expected_handler = 'N/A (Missing in Code)' WHERE screen_id = ? AND item_id = ?", (screen_id, item_id))
            else:
                # Update with actual found callback and zero-trust analyzed status
                status_to_write = 'api_connected' if phys['status'] == 'api_connected' else 'mock_stub'
                cursor.execute("""
                UPDATE sidebar_items 
                SET status = ?, expected_handler = ? 
                WHERE screen_id = ? AND item_id = ?
                """, (status_to_write, phys['callback'], screen_id, item_id))

        # Check for undocumented physical items (exist in code but not in SQLite spec)
        for phys_id, phys in physical_item_map.items():
            if phys_id not in expected_items:
                anomalies.append(f"- **[WARNING]** Mismatched Action: Undocumented sidebar item `{phys['label']}` (ID: `{phys_id}`) found in `{parsed['screen_name']}` code but not declared in database registry.")

    conn.commit()

    # ==========================================
    # STATISTICS COMPILATION FROM DATABASE
    # ==========================================

    # Global Quality Scores
    cursor.execute("SELECT COUNT(*) FROM dashboards;")
    total_dashboards = cursor.fetchone()[0] or 1
    cursor.execute("SELECT COUNT(*) FROM dashboards WHERE layout_compliant = 1;")
    compliant_dashboards = cursor.fetchone()[0] or 0
    layout_compliance_score = (compliant_dashboards / total_dashboards) * 100.0

    cursor.execute("SELECT COUNT(*) FROM sidebar_items;")
    total_expected_items = cursor.fetchone()[0] or 0
    cursor.execute("SELECT COUNT(*) FROM sidebar_items WHERE status = 'api_connected';")
    api_connected_items = cursor.fetchone()[0] or 0
    api_connectivity_score = (api_connected_items / total_expected_items) * 100.0 if total_expected_items > 0 else 100.0

    cursor.execute("SELECT COUNT(*) FROM sidebar_items WHERE status != 'pending';")
    functional_items = cursor.fetchone()[0] or 0
    functional_score = (functional_items / total_expected_items) * 100.0 if total_expected_items > 0 else 100.0

    # Module break-down categories
    known_categories = ['allied', 'clinical', 'common', 'executive', 'management', 'psw', 'rn', 'rpn', 'staff']
    category_stats = {}
    for cat in known_categories:
        cursor.execute("SELECT COUNT(*) FROM dashboards WHERE category = ?", (cat,))
        cat_total = cursor.fetchone()[0] or 0
        cursor.execute("SELECT COUNT(*) FROM dashboards WHERE category = ? AND requires_sidebar = 1;", (cat,))
        cat_requires = cursor.fetchone()[0] or 0
        cursor.execute("SELECT COUNT(*) FROM dashboards WHERE category = ? AND layout_compliant = 1;", (cat,))
        cat_compliant = cursor.fetchone()[0] or 0
        
        cursor.execute("SELECT COUNT(*) FROM sidebar_items WHERE screen_id IN (SELECT screen_id FROM dashboards WHERE category = ?);", (cat,))
        cat_items = cursor.fetchone()[0] or 0
        cursor.execute("SELECT COUNT(*) FROM sidebar_items WHERE status = 'api_connected' AND screen_id IN (SELECT screen_id FROM dashboards WHERE category = ?);", (cat,))
        cat_api = cursor.fetchone()[0] or 0
        cursor.execute("SELECT COUNT(*) FROM sidebar_items WHERE status != 'pending' AND screen_id IN (SELECT screen_id FROM dashboards WHERE category = ?);", (cat,))
        cat_func = cursor.fetchone()[0] or 0

        category_stats[cat] = {
            'total_dashboards': cat_total,
            'requires_sidebar': cat_requires,
            'layout_compliant': cat_compliant,
            'total_items': cat_items,
            'api_connected': cat_api,
            'functional': cat_func
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

    # Compile the report
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
        stats = category_stats[cat]
        if stats['total_dashboards'] == 0:
            continue
        
        l_score = (stats['layout_compliant'] / stats['total_dashboards']) * 100.0 if stats['total_dashboards'] > 0 else 100.0
        a_score = (stats['api_connected'] / stats['total_items']) * 100.0 if stats['total_items'] > 0 else 100.0
        f_score = (stats['functional'] / stats['total_items']) * 100.0 if stats['total_items'] > 0 else 100.0
        fixes = stats['total_items'] - stats['api_connected']
        
        rep.append(f"| **{cat}** | {stats['total_dashboards']} | {stats['requires_sidebar']} | `{l_score:.1f}%` | `{a_score:.1f}%` | `{f_score:.1f}%` | **{fixes}** |")
    rep.append('')

    rep.append('## 👥 Complete Apps & User Roles Directory')
    rep.append('Here is the directory of all 55+ user roles within the PrimeCare platform, categorized by their corresponding Screen Groups on disk:\n')
    for cat in known_categories:
        roles = role_directory.get(cat, [])
        total = category_stats[cat]['total_dashboards']
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
    
    # Query outstanding mock/stub items
    cursor.execute("""
    SELECT s.screen_name, s.path, s.category, i.item_id, i.label, i.expected_handler, i.status 
    FROM sidebar_items i
    JOIN dashboards s ON i.screen_id = s.screen_id
    WHERE i.status IN ('mock_stub', 'pending')
    ORDER BY s.category, s.screen_name, i.label;
    """)
    outstanding_items = cursor.fetchall()

    if not outstanding_items:
        rep.append('✅ **All sidebar controls are 100% connected to real APIs! No outstanding fixes required.**')
    else:
        current_cat = None
        current_screen = None
        for row in outstanding_items:
            cat = row['category']
            screen = row['screen_name']
            path = row['path']
            label = row['label']
            item_id = row['item_id']
            handler = row['expected_handler'] or ''
            
            if cat != current_cat:
                current_cat = cat
                rep.append(f"### 📁 Module: `{cat}`")
                current_screen = None
                
            if screen != current_screen:
                current_screen = screen
                rep.append(f"- [ ] **{screen}** (`{path}`):")
                
            clean_handler = handler.replace('\n', ' ').strip()
            display_handler = f"{clean_handler[:67]}..." if len(clean_handler) > 70 else clean_handler
            rep.append(f"  - [ ] Wire `{label}` (`ID: {item_id}`) to active API/controller method instead of mock: `{display_handler}`")
        rep.append('')

    rep.append('## 📋 Full Master Sidebar Item Catalog\n')
    rep.append('| Screen | Sidebar Item | Callback / Action Callback | Integration Status | Connected to API |')
    rep.append('|--------|--------------|----------------------------|--------------------|------------------|')
    
    cursor.execute("""
    SELECT s.screen_name, i.label, i.expected_handler, i.status 
    FROM sidebar_items i
    JOIN dashboards s ON i.screen_id = s.screen_id
    ORDER BY s.screen_name, i.label;
    """)
    all_catalog_items = cursor.fetchall()
    
    for row in all_catalog_items:
        clean_handler = (row['expected_handler'] or '').replace('\n', ' ').strip()
        display_handler = f"{clean_handler[:47]}..." if len(clean_handler) > 50 else clean_handler
        status_str = '🟢 Connected' if row['status'] == 'api_connected' else '🔴 Mock/Stub'
        rep.append(f"| `{row['screen_name']}` | `{row['label']}` | `{display_handler}` | `{row['status']}` | {status_str} |")

    # Write report
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(rep))

    conn.close()

    print("=====================================================")
    print(f"Governance Report compiled: {report_path}")
    print("=====================================================")

    # Enforce strict audit compliance
    has_critical_errors = any('[ERROR]' in anomaly for anomaly in anomalies)
    if has_critical_errors:
        print("[ERROR] GOVERNANCE CRITICAL AUDIT FAILURE: Mismatched structures detected! Please review sidebar_governance_report.md")
        sys.exit(1)
    else:
        print("[OK] Architectural Governance Verification Complete. Status: COMPLIANT.")
        sys.exit(0)

if __name__ == "__main__":
    reconcile()
