#!/usr/bin/env python3
import os
import sys
import sqlite3
import datetime
from typing import List, Dict, Any, Tuple

# Resolve absolute paths relative to project root
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def get_db_connection() -> sqlite3.Connection:
    db_path = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
    if not os.path.exists(db_path):
        print(f"\033[91m[ERROR] Database not found at: {db_path}\033[0m")
        sys.exit(1)
    
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    return conn

def scan_orphaned_apis(conn: sqlite3.Connection) -> List[Dict[str, Any]]:
    cursor = conn.cursor()
    # Query APIs that are client-facing (is_backend_only = 0) but not consumed by any screen or function
    cursor.execute("""
        SELECT a.id, a.endpoint_code, a.http_method, a.route_path, a.health_status, ap.app_name, ap.app_code
        FROM api_endpoints a
        JOIN apps ap ON a.app_id = ap.id
        WHERE a.is_backend_only = 0
          AND a.id NOT IN (SELECT DISTINCT api_id FROM screen_api_links WHERE api_id IS NOT NULL)
          AND a.id NOT IN (SELECT DISTINCT api_id FROM screen_functions WHERE api_id IS NOT NULL)
        ORDER BY a.route_path;
    """)
    return [dict(r) for r in cursor.fetchall()]

def scan_unowned_files(conn: sqlite3.Connection) -> List[Dict[str, Any]]:
    cursor = conn.cursor()
    # Query package files that have no ownership entries registered
    cursor.execute("""
        SELECT pf.id, pf.file_name, pf.file_path, pf.purpose, p.package_name
        FROM package_files pf
        JOIN physical_packages p ON pf.package_id = p.id
        WHERE pf.id NOT IN (SELECT DISTINCT package_file_id FROM artifact_ownership WHERE package_file_id IS NOT NULL)
        ORDER BY pf.file_path
        LIMIT 100; -- Cap for CLI readability
    """)
    return [dict(r) for r in cursor.fetchall()]

def scan_dead_controllers_and_services(conn: sqlite3.Connection) -> Tuple[List[Dict[str, Any]], List[Dict[str, Any]]]:
    cursor = conn.cursor()
    # Query controllers not linked to any active endpoint in api_endpoints
    cursor.execute("""
        SELECT c.id, c.controller_name, c.file_path
        FROM api_controllers c
        WHERE c.controller_name NOT IN (SELECT DISTINCT controller_name FROM api_endpoints WHERE controller_name IS NOT NULL)
        ORDER BY c.controller_name;
    """)
    dead_ctrls = [dict(r) for r in cursor.fetchall()]
    
    # Query services not linked to any active endpoint in api_endpoints
    cursor.execute("""
        SELECT s.id, s.service_name, s.file_path
        FROM api_services s
        WHERE s.service_name NOT IN (SELECT DISTINCT service_name FROM api_endpoints WHERE service_name IS NOT NULL)
        ORDER BY s.service_name;
    """)
    dead_srvs = [dict(r) for r in cursor.fetchall()]
    
    return dead_ctrls, dead_srvs

def scan_orphaned_layouts(conn: sqlite3.Connection) -> List[Dict[str, Any]]:
    cursor = conn.cursor()
    # Query layout bindings where the screen_id does not reference an active screen
    cursor.execute("""
        SELECT lb.id, lb.layout_name, lb.binding_type, la.app_name
        FROM layout_bindings lb
        JOIN logical_apps la ON lb.logical_app_id = la.id
        WHERE lb.screen_id IS NULL OR lb.screen_id NOT IN (SELECT id FROM screens)
        ORDER BY lb.layout_name;
    """)
    return [dict(r) for r in cursor.fetchall()]

def auto_register_findings(conn: sqlite3.Connection, orphaned_apis: List[Dict[str, Any]], 
                            unowned_files: List[Dict[str, Any]], dead_ctrls: List[Dict[str, Any]], 
                            dead_srvs: List[Dict[str, Any]]) -> int:
    cursor = conn.cursor()
    registered_count = 0
    
    # 1. Register Orphaned APIs in drift_findings
    for api in orphaned_apis:
        # Check if already registered
        cursor.execute("SELECT count(*) FROM drift_findings WHERE related_api_id = ? AND finding_type = 'api_gap';", (api['id'],))
        if cursor.fetchone()[0] == 0:
            # Get app_id from api_endpoints
            cursor.execute("SELECT app_id FROM api_endpoints WHERE id = ?;", (api['id'],))
            app_id = cursor.fetchone()[0] or 1
            
            desc = f"Orphaned client-facing API endpoint detected: '{api['http_method']} {api['route_path']}' has no active consumer mapping on any screen."
            cursor.execute("""
                INSERT INTO drift_findings (app_id, finding_type, severity, related_api_id, message, status)
                VALUES (?, 'api_gap', 'low', ?, ?, 'open');
            """, (app_id, api['id'], desc))
            registered_count += 1
            
    # 2. Register Unowned Files in drift_findings
    for f in unowned_files[:20]: # Limit db flood for first run
        # Check if already registered
        cursor.execute("SELECT count(*) FROM drift_findings WHERE related_file_id = ? AND finding_type = 'ownership_drift';", (f['id'],))
        if cursor.fetchone()[0] == 0:
            # Let's see if we can resolve physical file to runtime artifact or check package files
            cursor.execute("SELECT id FROM package_files WHERE id = ?;", (f['id'],))
            pf_id = cursor.fetchone()[0]
            
            desc = f"Physical code asset '{f['file_name']}' is registered in package files but lacks a defined team/role owner in artifact_ownership."
            cursor.execute("""
                INSERT INTO drift_findings (app_id, finding_type, severity, related_file_id, message, status)
                VALUES (1, 'ownership_drift', 'low', ?, ?, 'open');
            """, (pf_id, desc))
            registered_count += 1
            
    # 3. Register Dead Controllers in incident_reports
    for ctrl in dead_ctrls:
        inc_code = f"INC_DEAD_CTRL_{ctrl['id']}"
        cursor.execute("SELECT count(*) FROM incident_reports WHERE incident_code = ?;", (inc_code,))
        if cursor.fetchone()[0] == 0:
            # Find in runtime_artifacts
            cursor.execute("SELECT id, logical_app_id FROM runtime_artifacts WHERE artifact_type = 'controller' AND physical_path = ?;", (ctrl['file_path'],))
            rt_row = cursor.fetchone()
            rt_id = rt_row[0] if rt_row else None
            la_id = rt_row[1] if rt_row else 1
            
            summary = f"Dead Controller Detected: {ctrl['controller_name']}"
            desc = f"API controller '{ctrl['controller_name']}' is registered in file registries but maps zero active endpoints in the router schema. Consider removing dead code."
            cursor.execute("""
                INSERT INTO incident_reports (logical_app_id, incident_code, severity, summary, description, affected_artifact_id, status)
                VALUES (?, ?, 'low', ?, ?, ?, 'unresolved');
            """, (la_id, inc_code, summary, desc, rt_id))
            registered_count += 1
            
    # 4. Register Dead Services in incident_reports
    for srv in dead_srvs:
        inc_code = f"INC_DEAD_SRV_{srv['id']}"
        cursor.execute("SELECT count(*) FROM incident_reports WHERE incident_code = ?;", (inc_code,))
        if cursor.fetchone()[0] == 0:
            # Find in runtime_artifacts
            cursor.execute("SELECT id, logical_app_id FROM runtime_artifacts WHERE artifact_type = 'service' AND physical_path = ?;", (srv['file_path'],))
            rt_row = cursor.fetchone()
            rt_id = rt_row[0] if rt_row else None
            la_id = rt_row[1] if rt_row else 1
            
            summary = f"Dead Service Detected: {srv['service_name']}"
            desc = f"Backend service module '{srv['service_name']}' is registered in registries but maps zero active routing pathways. Consider auditing for dead methods."
            cursor.execute("""
                INSERT INTO incident_reports (logical_app_id, incident_code, severity, summary, description, affected_artifact_id, status)
                VALUES (?, ?, 'low', ?, ?, ?, 'unresolved');
            """, (la_id, inc_code, summary, desc, rt_id))
            registered_count += 1
            
    conn.commit()
    return registered_count

def print_console_report(orphaned_apis: List[Dict[str, Any]], unowned_files: List[Dict[str, Any]], 
                         dead_ctrls: List[Dict[str, Any]], dead_srvs: List[Dict[str, Any]], 
                         orphaned_layouts: List[Dict[str, Any]], db_inserted_count: int) -> None:
    reset = "\033[0m"
    bold = "\033[1m"
    yellow = "\033[93m"
    green = "\033[92m"
    red = "\033[91m"
    cyan = "\033[96m"
    
    print("\n" + "="*80)
    print(f" {bold}PRIMECARE GOVERNANCE AUTOMATION: AUTO DEAD-CODE & ORPHAN AUDIT{reset}")
    print("="*80)
    
    # 1. Orphaned APIs
    print(f"\n{bold}1. Orphaned Client-Facing APIs ({len(orphaned_apis)} identified):{reset}")
    if not orphaned_apis:
        print(f"  {green}* Zero orphaned APIs detected. All client endpoints have visual consumers!{reset}")
    else:
        for api in orphaned_apis[:10]:
            print(f"  * {yellow}[ORPHAN]{reset} {bold}{api['http_method']} {api['route_path']}{reset}")
            print(f"    Code: {api['endpoint_code']} | App: {api['app_name']}")
        if len(orphaned_apis) > 10:
            print(f"  * ... and {len(orphaned_apis) - 10} more orphaned APIs documented in the markdown report.")
            
    # 2. Unowned Files
    print(f"\n{bold}2. Unowned Physical Package Files ({len(unowned_files)} identified):{reset}")
    if not unowned_files:
        print(f"  {green}* Zero unowned files detected. All registered files have designated role owners!{reset}")
    else:
        for f in unowned_files[:8]:
            print(f"  * {yellow}[UNOWNED]{reset} {bold}{f['file_name']}{reset}")
            print(f"    Path: {f['file_path']} | Package: {f['package_name']}")
        if len(unowned_files) > 8:
            print(f"  * ... and {len(unowned_files) - 8} more unowned files documented in the markdown report.")
            
    # 3. Dead Controllers & Services
    print(f"\n{bold}3. Dead Controllers & Services ({len(dead_ctrls)} controllers, {len(dead_srvs)} services):{reset}")
    if not dead_ctrls and not dead_srvs:
        print(f"  {green}* Zero dead modules detected. All controllers and services bind active routing endpoints!{reset}")
    else:
        for ctrl in dead_ctrls:
            print(f"  * {red}[DEAD CTRL]{reset} {bold}{ctrl['controller_name']}{reset}")
            print(f"    File: {ctrl['file_path']}")
        for srv in dead_srvs:
            print(f"  * {red}[DEAD SERV]{reset} {bold}{srv['service_name']}{reset}")
            print(f"    File: {srv['file_path']}")
            
    # 4. Orphaned Layouts
    print(f"\n{bold}4. Orphaned Layout Bindings ({len(orphaned_layouts)} identified):{reset}")
    if not orphaned_layouts:
        print(f"  {green}* Zero orphaned layout bindings detected.{reset}")
    else:
        for l in orphaned_layouts:
            print(f"  * {yellow}[ORPHAN LAY]{reset} {bold}{l['layout_name']}{reset} ({l['binding_type']}) | App: {l['app_name']}")
            
    print("\n" + "="*80)
    print(f" {green}[AUTO-RECONCILE] Registered {db_inserted_count} new unresolved issues inside SQLite governance tables.{reset}")
    print("="*80 + "\n")

def save_markdown_audit_report(orphaned_apis: List[Dict[str, Any]], unowned_files: List[Dict[str, Any]], 
                              dead_ctrls: List[Dict[str, Any]], dead_srvs: List[Dict[str, Any]], 
                              orphaned_layouts: List[Dict[str, Any]]) -> str:
    reports_dir = os.path.join(PROJECT_ROOT, "reports", "governance", "orphan_reports")
    os.makedirs(reports_dir, exist_ok=True)
    
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"orphan_audit_{timestamp}.md"
    file_path = os.path.join(reports_dir, filename)
    
    total_issues = len(orphaned_apis) + len(unowned_files) + len(dead_ctrls) + len(dead_srvs) + len(orphaned_layouts)
    alert_type = "NOTE" if total_issues == 0 else ("WARNING" if total_issues > 30 else "IMPORTANT")
    
    markdown = f"""# Platform Orphan & Dead-Code Governance Audit

This automated trace sweep scans the SQLite relational registry to locate unused endpoints, unowned assets, dead MVC controllers, and layout bindings.

## Audit Executive Summary

> [!{alert_type}]
> ### **Discovered Governance Issues: {total_issues} item(s)**
> Sweep concluded with findings requiring continuous integration clean-ups. Actions and maps are automatically registered inside `drift_findings` and `incident_reports`.

---

## 1. Orphaned Client-Facing APIs ({len(orphaned_apis)} items)

Client-facing API endpoints must bind to at least one user action or page layout to avoid dead routing pathways.

{"*Zero orphaned APIs detected. Registry is aligned!*" if not orphaned_apis else ""}
"""
    if orphaned_apis:
        markdown += "| API Endpoint | HTTP Method | Endpoint Code | App Module | Status |\n"
        markdown += "| --- | --- | --- | --- | --- |\n"
        for api in orphaned_apis:
            markdown += f"| `{api['route_path']}` | **{api['http_method']}** | `{api['endpoint_code']}` | {api['app_name']} | `{api['health_status'].upper()}` |\n"
            
    markdown += f"""
---

## 2. Unowned Physical Package Files ({len(unowned_files)} items)

Physical package files must have clear role/team owners mapped in `artifact_ownership` to preserve organizational sanity.

{"*Zero unowned physical assets detected.*" if not unowned_files else ""}
"""
    if unowned_files:
        markdown += "| File Name | Package Name | Physical Path | Purpose / Description |\n"
        markdown += "| --- | --- | --- | --- |\n"
        for f in unowned_files:
            markdown += f"| **{f['file_name']}** | {f['package_name']} | [{f['file_path']}](file:///{f['file_path']}) | {f['purpose'] or 'N/A'} |\n"
            
    markdown += f"""
---

## 3. Dead Controllers & Backend Services ({len(dead_ctrls) + len(dead_srvs)} items)

Controllers and services registered in registries must bind to at least one active routing gateway.

{"*Zero dead controllers or services detected.*" if not dead_ctrls and not dead_srvs else ""}
"""
    if dead_ctrls or dead_srvs:
        markdown += "| Module Name | Type | Physical Code Path |\n"
        markdown += "| --- | --- | --- |\n"
        for c in dead_ctrls:
            markdown += f"| **{c['controller_name']}** | `CONTROLLER` | [{os.path.basename(c['file_path'])}](file:///{c['file_path']}) |\n"
        for s in dead_srvs:
            markdown += f"| **{s['service_name']}** | `SERVICE` | [{os.path.basename(s['file_path'])}](file:///{s['file_path']}) |\n"
            
    markdown += f"""
---

## 4. Orphaned Layout Bindings ({len(orphaned_layouts)} items)

Layout bindings should correspond to active user-facing screens to prevent layout render overheads.

{"*Zero orphaned layout bindings detected.*" if not orphaned_layouts else ""}
"""
    if orphaned_layouts:
        markdown += "| Layout Name | Binding Type | Host Application |\n"
        markdown += "| --- | --- | --- |\n"
        for l in orphaned_layouts:
            markdown += f"| **{l['layout_name']}** | `{l['binding_type']}` | {l['app_name']} |\n"
            
    markdown += f"""
---

## Continuous Remediation Actions

- [ ] **API Gating**: Set unlinked APIs that are purely internal to `is_backend_only = 1`.
- [ ] **Artifact Ownership Mapping**: Populate team ownership details inside `artifact_ownership` for all unowned files.
- [ ] **Dead Code Removal**: Audit dead controllers and service modules; remove deprecated code.
- [ ] **Database Reconciliation**: Re-run database remodeling to verify all orphans are successfully cleared.

*Generated by PrimeCare Enterprise Governance OS - Zero-Drift Guardian CLI.*
"""
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(markdown)
        
    return file_path

def main():
    conn = get_db_connection()
    try:
        # 1. Scan for orphaned / unconsumed APIs
        orphaned_apis = scan_orphaned_apis(conn)
        
        # 2. Scan for unowned package files
        unowned_files = scan_unowned_files(conn)
        
        # 3. Scan for dead controllers & services
        dead_ctrls, dead_srvs = scan_dead_controllers_and_services(conn)
        
        # 4. Scan for orphaned layout bindings
        orphaned_layouts = scan_orphaned_layouts(conn)
        
        # 5. Auto-register findings into drift_findings & incident_reports
        inserted_count = auto_register_findings(conn, orphaned_apis, unowned_files, dead_ctrls, dead_srvs)
        
        # 6. Render Terminal report
        print_console_report(orphaned_apis, unowned_files, dead_ctrls, dead_srvs, orphaned_layouts, inserted_count)
        
        # 7. Save Markdown Audit report
        report_path = save_markdown_audit_report(orphaned_apis, unowned_files, dead_ctrls, dead_srvs, orphaned_layouts)
        print(f"\033[92m[SUCCESS] Detailed orphan audit compiled and saved to:\033[0m")
        print(f"  \033[94mfile:///{report_path}\033[0m\n")
        
    finally:
        conn.close()

if __name__ == "__main__":
    main()
