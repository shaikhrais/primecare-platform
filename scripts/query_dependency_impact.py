#!/usr/bin/env python3
import os
import sys
import sqlite3
import argparse
import datetime
from typing import List, Dict, Any, Tuple

# Resolve absolute paths relative to project root
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def setup_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="PrimeCare Governance Operating System - Auto Dependency Impact Analysis CLI",
        formatter_class=argparse.RawTextHelpFormatter
    )
    
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        "--api",
        type=str,
        help="Route path or endpoint pattern to inspect (e.g., '/v1/clinic/summary' or 'GET /v1/auth/login')"
    )
    group.add_argument(
        "--file",
        type=str,
        help="Physical package file path to inspect (e.g., 'packages/primecare_ui/lib/src/screens/clinic/clinic_dashboard_screen.dart')"
    )
    group.add_argument(
        "--screen",
        type=str,
        help="Visual screen code to inspect (e.g., 'clinic_dashboard')"
    )
    group.add_argument(
        "--id",
        type=int,
        help="Direct central runtime artifact database ID to inspect"
    )
    
    parser.add_argument(
        "--save",
        action="store_true",
        default=True,
        help="Automatically compile and save detailed Markdown impact report (default: True)"
    )
    
    return parser

def get_db_connection() -> sqlite3.Connection:
    db_path = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
    if not os.path.exists(db_path):
        print(f"\033[91m[ERROR] Database not found at: {db_path}\033[0m")
        sys.exit(1)
    
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    return conn

def resolve_target(conn: sqlite3.Connection, args: argparse.Namespace) -> Dict[str, Any]:
    cursor = conn.cursor()
    
    if args.id:
        cursor.execute("SELECT * FROM runtime_artifacts WHERE id = ?;", (args.id,))
        row = cursor.fetchone()
        if row:
            return dict(row)
        print(f"\033[91m[ERROR] Runtime artifact with ID {args.id} not found.\033[0m")
        sys.exit(1)
        
    elif args.screen:
        code = args.screen.strip()
        # Search screens table
        cursor.execute("SELECT * FROM screens WHERE screen_code = ? OR screen_code = ?;", (code, f"{code}_screen"))
        scr = cursor.fetchone()
        if not scr:
            cursor.execute("SELECT * FROM screens WHERE screen_code LIKE ? OR screen_name LIKE ?;", (f"%{code}%", f"%{code}%"))
            scr = cursor.fetchone()
            
        if scr:
            scr_dict = dict(scr)
            # Find in runtime_artifacts
            cursor.execute("SELECT * FROM runtime_artifacts WHERE artifact_type = 'screen' AND (artifact_code = ? OR physical_path = ?);", 
                           (f"SCR_{scr_dict['screen_code']}", scr_dict['file_path']))
            row = cursor.fetchone()
            if row:
                return dict(row)
        print(f"\033[91m[ERROR] Screen with code '{args.screen}' not found.\033[0m")
        sys.exit(1)
        
    elif args.file:
        file_path = args.file.replace('\\', '/').strip()
        cursor.execute("SELECT * FROM runtime_artifacts WHERE artifact_type = 'file' AND physical_path LIKE ?;", (f"%{file_path}%",))
        row = cursor.fetchone()
        if not row:
            # Check package files
            cursor.execute("SELECT * FROM package_files WHERE file_path LIKE ?;", (f"%{file_path}%",))
            pf = cursor.fetchone()
            if pf:
                cursor.execute("SELECT * FROM runtime_artifacts WHERE physical_path = ?;", (pf['file_path'],))
                row = cursor.fetchone()
                
        if row:
            return dict(row)
        print(f"\033[91m[ERROR] File with path '{args.file}' not registered in central registry.\033[0m")
        sys.exit(1)
        
    elif args.api:
        api_input = args.api.strip()
        method = None
        route = api_input
        
        # Parse "GET /v1/auth/login" format
        if " " in api_input:
            parts = api_input.split(" ", 1)
            method = parts[0].upper()
            route = parts[1]
            
        if method:
            cursor.execute("SELECT * FROM api_endpoints WHERE http_method = ? AND route_path LIKE ?;", (method, f"%{route}%"))
        else:
            cursor.execute("SELECT * FROM api_endpoints WHERE route_path LIKE ?;", (f"%route%",))
            
        api_res = cursor.fetchone()
        if not api_res:
            # Direct code search
            cursor.execute("SELECT * FROM api_endpoints WHERE endpoint_code LIKE ?;", (f"%{api_input}%",))
            api_res = cursor.fetchone()
            
        if api_res:
            api_dict = dict(api_res)
            clean_route = api_dict['route_path'].replace('/', '_').replace('-', '_').upper().strip('_')
            code = f"API_{api_dict['http_method']}_{clean_route}"
            
            cursor.execute("SELECT * FROM runtime_artifacts WHERE artifact_type = 'api' AND (artifact_code = ? OR artifact_code = ?);", 
                           (code, f"{code}_{api_dict['id']}"))
            row = cursor.fetchone()
            if row:
                return dict(row)
                
        print(f"\033[91m[ERROR] API endpoint matching '{args.api}' not found in registry.\033[0m")
        sys.exit(1)

    print("\033[91m[ERROR] Could not resolve artifact query.\033[0m")
    sys.exit(1)

def query_impacts(conn: sqlite3.Connection, target_id: int) -> List[Dict[str, Any]]:
    cursor = conn.cursor()
    cursor.execute("""
        SELECT di.source_artifact_id, di.impact_depth, di.impact_type, di.criticality, di.description,
               ra.artifact_code, ra.artifact_type, ra.artifact_name, ra.physical_path, ra.logical_app_id
        FROM dependency_impacts di
        JOIN runtime_artifacts ra ON di.source_artifact_id = ra.id
        WHERE di.target_artifact_id = ?
        ORDER BY di.impact_depth ASC, di.criticality DESC;
    """, (target_id,))
    return [dict(r) for r in cursor.fetchall()]

def query_associated_tests(conn: sqlite3.Connection, affected_ids: List[int], target_id: int) -> List[Dict[str, Any]]:
    cursor = conn.cursor()
    if not affected_ids:
        affected_ids = [0]
    
    # We query test cases mapped to any affected screen, api or directly via runtime_artifact_id
    # Get all screen database IDs downstream
    cursor.execute(f"""
        SELECT s.id 
        FROM screens s 
        WHERE s.file_path IN (
            SELECT physical_path FROM runtime_artifacts WHERE id IN ({','.join(map(str, affected_ids))})
        );
    """)
    screen_ids = [r['id'] for r in cursor.fetchall()]
    if not screen_ids:
        screen_ids = [0]
        
    # Get all API route paths from affected runtime artifacts
    cursor.execute(f"""
        SELECT artifact_name 
        FROM runtime_artifacts 
        WHERE id IN ({','.join(map(str, affected_ids))}) AND artifact_type = 'api';
    """)
    api_names = [r[0] for r in cursor.fetchall()]
    api_routes = []
    for name in api_names:
        for verb in ('GET ', 'POST ', 'PUT ', 'DELETE ', 'PATCH '):
            if name.startswith(verb):
                name = name[len(verb):]
                break
        api_routes.append(name)
        
    api_ids = []
    if api_routes:
        placeholders = ','.join('?' for _ in api_routes)
        cursor.execute(f"SELECT id FROM api_endpoints WHERE route_path IN ({placeholders});", api_routes)
        api_ids = [r[0] for r in cursor.fetchall()]
    if not api_ids:
        api_ids = [0]
        
    placeholders_aff = ','.join('?' for _ in affected_ids)
    cursor.execute(f"""
        SELECT tc.id, tc.test_name, tc.test_type, tc.priority, tc.file_path, tc.expected_result,
               s.screen_name as related_screen, a.route_path as related_api
        FROM test_cases tc
        LEFT JOIN screens s ON tc.related_screen_id = s.id
        LEFT JOIN api_endpoints a ON tc.related_api_id = a.id
        WHERE tc.runtime_artifact_id IN ({placeholders_aff})
           OR tc.runtime_artifact_id = ?
           OR tc.related_screen_id IN ({','.join(map(str, screen_ids))})
           OR tc.related_api_id IN ({','.join(map(str, api_ids))})
        GROUP BY tc.id;
    """, affected_ids + [target_id])
    return [dict(r) for r in cursor.fetchall()]

def query_associated_permissions(conn: sqlite3.Connection, affected_ids: List[int]) -> List[Dict[str, Any]]:
    cursor = conn.cursor()
    if not affected_ids:
        return []
    
    # Get screen codes for affected screens
    cursor.execute(f"""
        SELECT id, screen_code, screen_name FROM screens 
        WHERE file_path IN (
            SELECT physical_path FROM runtime_artifacts WHERE id IN ({','.join(map(str, affected_ids))}) AND artifact_type = 'screen'
        );
    """)
    screens = cursor.fetchall()
    screen_ids = [s['id'] for s in screens]
    if not screen_ids:
        screen_ids = [0]
        
    # Query roles that have view access to these screens
    cursor.execute(f"""
        SELECT r.role_code, r.role_name, s.screen_code, s.screen_name,
               (CASE WHEN rsp.can_edit = 1 THEN 'write' ELSE 'read' END) as permission_type
        FROM role_screen_permissions rsp
        JOIN roles r ON rsp.role_id = r.id
        JOIN screens s ON rsp.screen_id = s.id
        WHERE rsp.screen_id IN ({','.join(map(str, screen_ids))}) AND rsp.can_view = 1
        ORDER BY r.role_code, s.screen_code;
    """)
    return [dict(r) for r in cursor.fetchall()]

def calculate_risk_and_level(impacts: List[Dict[str, Any]]) -> Tuple[int, str, str]:
    score = 0
    for imp in impacts:
        depth = imp['impact_depth']
        if depth == 1:
            score += 15
        elif depth == 2:
            score += 8
        elif depth == 3:
            score += 4
            
    score = min(score, 100)
    
    if score == 0:
        return 0, "NEGLIGIBLE", "\033[94m" # Blue
    elif score <= 20:
        return score, "LOW", "\033[92m" # Green
    elif score <= 50:
        return score, "MEDIUM", "\033[93m" # Yellow
    elif score <= 80:
        return score, "HIGH", "\033[91m" # Red
    else:
        return score, "CRITICAL", "\033[91m\033[1m" # Bold Red

def print_terminal_report(target: Dict[str, Any], impacts: List[Dict[str, Any]], 
                          tests: List[Dict[str, Any]], perms: List[Dict[str, Any]], 
                          risk_score: int, risk_level: str, color_ansi: str) -> None:
    # Clear console formatting
    reset = "\033[0m"
    bold = "\033[1m"
    cyan = "\033[96m"
    
    print("\n" + "="*80)
    print(f" {bold}PRIMECARE GOVERNANCE AUTOMATION: DOWNSTREAM DEPENDENCY IMPACT REPORT{reset}")
    print("="*80)
    
    print(f"\n{bold}Root Target Modified:{reset}")
    print(f"  * {bold}Type:{reset} {target['artifact_type'].upper()}")
    print(f"  * {bold}Code:{reset} {target['artifact_code']}")
    print(f"  * {bold}Name:{reset} {target['artifact_name']}")
    if target['physical_path']:
        print(f"  * {bold}File Path:{reset} {target['physical_path']}")
    print(f"  * {bold}Central Reg ID:{reset} #{target['id']}")
    
    print(f"\n{bold}Impact Risk Assessment:{reset}")
    print(f"  * {bold}Risk Score:{reset} {color_ansi}{risk_score}/100{reset}")
    print(f"  * {bold}Risk Level:{reset} {color_ansi}{risk_level}{reset}")
    print(f"  * {bold}Total Cascade Impacts:{reset} {len(impacts)} downstream nodes affected")
    
    # Cascade groupings
    by_type = {}
    for imp in impacts:
        by_type.setdefault(imp['artifact_type'], []).append(imp)
        
    print(f"\n{bold}Traversed Dependency Cascade Details:{reset}")
    if not impacts:
        print("  (No downstream dependency impacts detected. The artifact is fully isolated!)")
    else:
        for t, list_nodes in by_type.items():
            print(f"\n  {bold}>>> {t.upper()} ({len(list_nodes)} affected):{reset}")
            for node in list_nodes:
                c_lbl = "\033[91m[Direct]\033[0m" if node['impact_depth'] == 1 else f"\033[93m[Transitive L{node['impact_depth']}]\033[0m"
                print(f"    - {c_lbl} {bold}{node['artifact_name']}{reset} ({node['artifact_code']})")
                if node['physical_path']:
                    print(f"      Path: {node['physical_path']}")
                    
    # Tests verification recommendations
    print(f"\n{bold}Required QA Verification Matrix ({len(tests)} test suites mapped):{reset}")
    if not tests:
        print("  [WARNING] No explicit regression test suites are mapped to these components. Please draft a new test case!")
    else:
        for test in sorted(tests, key=lambda x: x['priority'].lower() == 'high', reverse=True):
            p_color = "\033[91m" if test['priority'].lower() == 'high' else "\033[92m"
            print(f"  * [{p_color}{test['priority'].upper()}{reset}] {test['test_name']} ({test['test_type']})")
            print(f"    File: {test['file_path']}")
            
    # Permissions verification
    print(f"\n{bold}RBAC Permissions Hardening Verification ({len(perms)} roles mapped):{reset}")
    if not perms:
        print("  (No role screen permissions are mapped to the affected components.)")
    else:
        # Group by role
        roles_grouped = {}
        for p in perms:
            roles_grouped.setdefault(p['role_name'], []).append(p['screen_name'])
        for r_name, scr_names in list(roles_grouped.items())[:8]: # limit to first 8 for cleaner CLI
            print(f"  * {bold}Role: {r_name}{reset} has visual access to affected screens: {', '.join(set(scr_names))}")
        if len(roles_grouped) > 8:
            print(f"  * ... and {len(roles_grouped) - 8} more roles verified in the comprehensive audit report.")
            
    print("\n" + "="*80)
    print(f" \033[90mGenerated on {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Zero-Drift Guardian Engine\033[0m")
    print("="*80 + "\n")

def save_markdown_report(target: Dict[str, Any], impacts: List[Dict[str, Any]], 
                         tests: List[Dict[str, Any]], perms: List[Dict[str, Any]], 
                         risk_score: int, risk_level: str) -> str:
    reports_dir = os.path.join(PROJECT_ROOT, "reports", "governance", "impact_reports")
    os.makedirs(reports_dir, exist_ok=True)
    
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    t_type = target['artifact_type']
    t_id = target['id']
    filename = f"impact_{t_type}_{t_id}_{timestamp}.md"
    file_path = os.path.join(reports_dir, filename)
    
    # Calculate Risk Color Block
    alert_type = "NOTE"
    if risk_score > 80:
        alert_type = "CAUTION"
    elif risk_score > 50:
        alert_type = "WARNING"
    elif risk_score > 20:
        alert_type = "IMPORTANT"
    else:
        alert_type = "TIP"
        
    markdown = f"""# Downstream Dependency Impact Report

This automated analysis traces all downstream architectural and visual dependencies affected by modifications made to **{target['artifact_name']}**.

## Modified Target Details

| Attribute | Value |
| --- | --- |
| **Artifact ID** | `#{target['id']}` |
| **Artifact Code** | `{target['artifact_code']}` |
| **Type** | `{target['artifact_type'].upper()}` |
| **Name** | `{target['artifact_name']}` |
| **Physical Path** | `{target['physical_path'] or 'N/A'}` |

---

## Impact Risk Assessment

> [!{alert_type}]
> ### **Risk Score: {risk_score}/100 ({risk_level})**
> This change impacts **{len(impacts)} downstream artifact(s)** in the software lifecycle dependency graph. Complete all QA verification steps listed below before staging deployment.

### Downstream Impact Topology

| Downstream Artifact | Type | Impact Depth | Criticality | Path Description |
| --- | --- | --- | --- | --- |
"""
    
    if not impacts:
        markdown += "| (None) | - | - | - | Fully isolated artifact. |\n"
    else:
        for imp in impacts:
            path = imp['physical_path'] or 'N/A'
            markdown += f"| **{imp['artifact_name']}**<br>`{imp['artifact_code']}` | `{imp['artifact_type'].upper()}` | Depth {imp['impact_depth']} | `{imp['criticality'].upper()}` | {imp['description']} |\n"
            
    markdown += f"""
---

## Required QA Regression Matrix

The following **{len(tests)} test suites** cover the affected modules and must be run and verified.

| Test Case Suite | Type | Priority | Related Component | File Path |
| --- | --- | --- | --- | --- |
"""
    
    if not tests:
        markdown += "| (None Mapped) | - | - | - | *WARNING: No automated regression suites cover these paths. Manual validation recommended.* |\n"
    else:
        for test in tests:
            comp = test['related_screen'] or test['related_api'] or 'Common Core'
            markdown += f"| **{test['test_name']}** | `{test['test_type'].upper()}` | **{test['priority'].upper()}** | {comp} | [{os.path.basename(test['file_path'])}](file:///{test['file_path']}) |\n"
            
    markdown += f"""
---

## RBAC Permissions Under Audit

This modification affects screens accessed by the following roles. Validate screen function access and page locks under these permission groups.

"""
    
    if not perms:
        markdown += "*No role screen permissions are mapped to the affected visual screens.*\n"
    else:
        markdown += "| Role Code | Role Name | Affected Screen | Screen Code | Access Type |\n"
        markdown += "| --- | --- | --- | --- | --- |\n"
        for p in perms:
            markdown += f"| `{p['role_code']}` | {p['role_name']} | **{p['screen_name']}** | `{p['screen_code']}` | `{p['permission_type']}` |\n"
            
    markdown += f"""
---

## Recommended Mitigation Checklist

- [ ] **Code Audit**: Verify method signatures for all affected services and controllers.
- [ ] **Visual Testing**: Manually review visual page layout adapters on screens identified in depth 1 cascade.
- [ ] **Automated Validation**: Re-run the detailed regression tests mapped above and ensure success.
- [ ] **Deployment Gate Validation**: Ensure all continuous integration gates (Linting, Tests, Security Scan) return `PASSED`.

*Generated by PrimeCare Enterprise Governance OS - Zero-Drift Guardian CLI.*
"""
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(markdown)
        
    return file_path

def main():
    parser = setup_arg_parser()
    args = parser.parse_args()
    
    conn = get_db_connection()
    try:
        # 1. Resolve Target Modified Artifact
        target = resolve_target(conn, args)
        
        # 2. Query all downstream cascading impacts
        impacts = query_impacts(conn, target['id'])
        affected_ids = [imp['source_artifact_id'] for imp in impacts]
        
        # 3. Query related regression test suites
        tests = query_associated_tests(conn, affected_ids, target['id'])
        
        # 4. Query RBAC permissions associated with visual impacts
        perms = query_associated_permissions(conn, affected_ids)
        
        # 5. Evaluate overall Risk metrics
        risk_score, risk_level, color_ansi = calculate_risk_and_level(impacts)
        
        # 6. Render Terminal output
        print_terminal_report(target, impacts, tests, perms, risk_score, risk_level, color_ansi)
        
        # 7. Auto-save Markdown Report
        if args.save:
            report_path = save_markdown_report(target, impacts, tests, perms, risk_score, risk_level)
            print(f"\033[92m[SUCCESS] Detailed impact report compiled and saved to:\033[0m")
            print(f"  \033[94mfile:///{report_path}\033[0m\n")
            
    finally:
        conn.close()

if __name__ == "__main__":
    main()
