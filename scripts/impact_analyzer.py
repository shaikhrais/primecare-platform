import os
import sys
import sqlite3
import argparse

# Ensure unicode safe terminal output on Windows console
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

# Resolve DB path
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

# ANSI Color Codes
COLOR_RESET = "\033[0m"
COLOR_BOLD = "\033[1m"
COLOR_CRITICAL = "\033[91m"  # Red
COLOR_HIGH = "\033[93m"      # Yellow/Orange
COLOR_MEDIUM = "\033[33m"    # Gold
COLOR_LOW = "\033[92m"       # Green
COLOR_CYAN = "\033[96m"      # Cyan
COLOR_GRAY = "\033[90m"      # Gray
COLOR_PURPLE = "\033[95m"    # Purple

CRITICALITY_COLORS = {
    "critical": COLOR_CRITICAL,
    "high": COLOR_HIGH,
    "medium": COLOR_MEDIUM,
    "low": COLOR_LOW
}

def lookup_impacts(target_code):
    if not os.path.exists(DB_PATH):
        print(f"{COLOR_CRITICAL}[ERROR] Database not found at {DB_PATH}{COLOR_RESET}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Find the target artifact in runtime_artifacts
    cursor.execute("""
    SELECT id, artifact_type, artifact_code, artifact_name, physical_path, status, health_status
    FROM runtime_artifacts
    WHERE artifact_code = ? OR artifact_code = ? OR artifact_code = ?;
    """, (target_code, f"SCR_{target_code}", f"API_{target_code}"))
    target = cursor.fetchone()

    if not target:
        # Fuzzy match attempt
        cursor.execute("""
        SELECT id, artifact_type, artifact_code, artifact_name, physical_path, status, health_status
        FROM runtime_artifacts
        WHERE artifact_code LIKE ? OR artifact_name LIKE ?;
        """, (f"%{target_code}%", f"%{target_code}%"))
        results = cursor.fetchall()
        
        if not results:
            print(f"{COLOR_CRITICAL}[ERROR] No asset found matching code or name: '{target_code}'{COLOR_RESET}")
            conn.close()
            sys.exit(1)
        elif len(results) > 1:
            print(f"{COLOR_HIGH}[INFO] Multiple matching assets found. Please refine your query:{COLOR_RESET}")
            for r in results:
                print(f"  - {COLOR_CYAN}{r['artifact_code']}{COLOR_RESET} ({r['artifact_type']}): {r['artifact_name']}")
            conn.close()
            sys.exit(0)
        else:
            target = results[0]

    target_id = target['id']
    t_code = target['artifact_code']
    t_name = target['artifact_name']
    t_type = target['artifact_type']

    print(f"\n{COLOR_BOLD}{COLOR_PURPLE}======================================================================")
    print(f"ENTERPRISE GRAPH IMPACT REPORT: {t_code}")
    print(f"======================================================================{COLOR_RESET}")
    print(f"Asset Name:   {COLOR_CYAN}{t_name}{COLOR_RESET}")
    print(f"Asset Type:   {COLOR_CYAN}{t_type.upper()}{COLOR_RESET}")
    print(f"Physical Path: {COLOR_GRAY}{target['physical_path'] or 'N/A'}{COLOR_RESET}")
    print(f"Status:       {COLOR_LOW}{target['status'].upper()}{COLOR_RESET} | Health: {COLOR_LOW}{target['health_status'].upper()}{COLOR_RESET}")
    print(f"{COLOR_BOLD}{COLOR_PURPLE}----------------------------------------------------------------------{COLOR_RESET}")

    # Query all impacts
    cursor.execute("""
    SELECT di.impact_depth, di.impact_type, di.criticality, di.description, 
           ra.artifact_code, ra.artifact_name, ra.artifact_type, ra.physical_path
    FROM dependency_impacts di
    JOIN runtime_artifacts ra ON di.source_artifact_id = ra.id
    WHERE di.target_artifact_id = ?
    ORDER BY di.impact_depth ASC, di.criticality DESC, ra.artifact_type ASC;
    """, (target_id,))
    impacts = cursor.fetchall()

    if not impacts:
        print(f"{COLOR_LOW}[CLEAN] Zero downstream impacts found! Modifying this asset poses negligible architectural risk.{COLOR_RESET}")
        conn.close()
        return

    print(f"{COLOR_BOLD}Detected Downstream Impacts ({len(impacts)} affected assets):{COLOR_RESET}\n")

    # Group impacts by depth
    depth_groups = {}
    for imp in impacts:
        depth_groups.setdefault(imp['impact_depth'], []).append(imp)

    for depth in sorted(depth_groups.keys()):
        print(f"{COLOR_BOLD}Depth {depth} (Direct Impacts)" if depth == 1 else f"{COLOR_BOLD}Depth {depth} (Transitive Impacts){COLOR_RESET}")
        
        for idx, imp in enumerate(depth_groups[depth]):
            crit = imp['criticality'].lower()
            color = CRITICALITY_COLORS.get(crit, COLOR_RESET)
            
            # Draw ASCII tree characters
            is_last = (idx == len(depth_groups[depth]) - 1)
            connector = "└── " if is_last else "├── "
            
            indent = "  " * (depth - 1)
            print(f"{indent}{connector}[{color}{crit.upper()}{COLOR_RESET}] {COLOR_CYAN}{imp['artifact_code']}{COLOR_RESET} ({imp['artifact_type'].upper()}): {imp['artifact_name']}")
            print(f"{indent}    {COLOR_GRAY}Impact Type: {imp['impact_type']} | Path: {imp['physical_path'] or 'N/A'}{COLOR_RESET}")
            if imp['description']:
                print(f"{indent}    {COLOR_GRAY}Details: {imp['description']}{COLOR_RESET}")
        print()

    print(f"{COLOR_BOLD}{COLOR_PURPLE}======================================================================{COLOR_RESET}")
    conn.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PrimeCare Enterprise Architecture Graph Downstream Impact Analyzer")
    parser.add_argument("--lookup", required=True, help="Target asset code (e.g. SCR_COORDINATOR_HUB_SCREEN or database table name)")
    args = parser.parse_args()
    
    lookup_impacts(args.lookup)
