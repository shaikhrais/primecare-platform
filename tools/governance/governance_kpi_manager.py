import os
import sys
import sqlite3
import json
import argparse
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
CYPRESS_SCREENS_DIR = os.path.join(PROJECT_ROOT, "cypress", "e2e", "03_screens")
TEST_REGISTRY_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "governance", "e2e_test_registry.json")
REPORT_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "governance_kpi_report.json")

def get_db_connection():
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Governance SQLite database not found at '{DB_PATH}'!")
        sys.exit(1)
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def run_pre_flight():
    print("==============================================================")
    print("[PRE-FLIGHT] EXECUTING INTEGRITY SWEEP ACROSS ALL SCREENS")
    print("==============================================================")
    
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT id, screen_code, screen_name, actual_file_path, route_path, complexity_score, estimated_loc
        FROM screens
    """)
    screens = cursor.fetchall()
    
    total = len(screens)
    missing_files = []
    missing_routes = []
    high_risk_screens = []
    
    for s in screens:
        code = s["screen_code"]
        name = s["screen_name"]
        file_path = s["actual_file_path"]
        route = s["route_path"]
        complexity = s["complexity_score"] or 0
        loc = s["estimated_loc"] or 0
        
        # 1. Verify source code existence on disk
        if not file_path:
            missing_files.append((code, name, "Path undefined in database"))
        else:
            full_file_path = os.path.join(PROJECT_ROOT, file_path.replace("/", os.sep).replace("\\", os.sep))
            if not os.path.exists(full_file_path):
                missing_files.append((code, name, file_path))
                
        # 2. Verify router path mapping
        if not route or route.strip() == "" or route.lower() == "null":
            missing_routes.append((code, name))
            
        # 3. Identify high risk (high complexity, no spec check yet)
        if complexity > 25 or loc > 300:
            high_risk_screens.append((code, name, complexity, loc))
            
    # Calculate scores
    file_integrity_pct = ((total - len(missing_files)) / total * 100) if total > 0 else 0
    route_completeness_pct = ((total - len(missing_routes)) / total * 100) if total > 0 else 0
    overall_health_score = (file_integrity_pct + route_completeness_pct) / 2
    
    print(f"Total screens in registry: {total}")
    print(f"File integrity coverage  : {file_integrity_pct:.1f}% ({total - len(missing_files)} / {total} files exist)")
    print(f"Route mapping coverage   : {route_completeness_pct:.1f}% ({total - len(missing_routes)} / {total} routes mapped)")
    print(f"Overall Pre-flight Health Score: {overall_health_score:.1f}%")
    
    if len(missing_files) > 0:
        print(f"\n[WARNING] Found {len(missing_files)} screens referencing files that do not exist on disk!")
        for idx, (c, n, p) in enumerate(missing_files[:10], 1):
            print(f"  {idx}. Code: '{c}' | Name: '{n}' | Path: '{p}'")
        if len(missing_files) > 10:
            print(f"  ... and {len(missing_files) - 10} more.")
            
    if len(missing_routes) > 0:
        print(f"\n[WARNING] Found {len(missing_routes)} screens with no router mapping (causes 404/redirection errors)!")
        for idx, (c, n) in enumerate(missing_routes[:10], 1):
            print(f"  {idx}. Code: '{c}' | Name: '{n}'")
        if len(missing_routes) > 10:
            print(f"  ... and {len(missing_routes) - 10} more.")

    if len(high_risk_screens) > 0:
        print(f"\n[INFO] Found {len(high_risk_screens)} High-Complexity screens requiring prioritized E2E testing:")
        # Sort by complexity descending
        high_risk_screens.sort(key=lambda x: x[2], reverse=True)
        for idx, (c, n, comp, l) in enumerate(high_risk_screens[:10], 1):
            print(f"  {idx}. Code: '{c}' | Name: '{n}' | Complexity: {comp} | LOC: {l}")
            
    conn.close()
    return {
        "total_screens": total,
        "missing_files_count": len(missing_files),
        "missing_routes_count": len(missing_routes),
        "health_score": overall_health_score,
        "high_risk_count": len(high_risk_screens)
    }

def run_e2e_readiness():
    print("==============================================================")
    print("[READINESS] EVALUATING CYPRESS E2E SPEC COVERAGE & READINESS")
    print("==============================================================")
    
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT id, screen_code, screen_name, complexity_score, estimated_loc, cypress_ready, cypress_ready_status
        FROM screens
    """)
    screens = cursor.fetchall()
    
    ready_count = 0
    needs_spec_count = 0
    not_ready_count = 0
    updated_records = 0
    
    print("Scanning specs directory...")
    # Get all spec files in cypress/e2e/03_screens/
    spec_files = set()
    if os.path.exists(CYPRESS_SCREENS_DIR):
        for f in os.listdir(CYPRESS_SCREENS_DIR):
            if f.endswith(".cy.js"):
                spec_files.add(f.lower())
                
    print(f"Found {len(spec_files)} screen-level Cypress specs on disk.")
    
    for s in screens:
        code = s["screen_code"]
        name = s["screen_name"]
        complexity = s["complexity_score"] or 0
        loc = s["estimated_loc"] or 0
        current_ready = s["cypress_ready"]
        current_status = s["cypress_ready_status"]
        
        # Match with screen_<screen_code>.cy.js
        expected_spec_name = f"screen_{code.lower()}.cy.js"
        
        has_spec = expected_spec_name in spec_files
        
        new_ready = 1 if has_spec else 0
        new_status = "ready" if has_spec else "not_ready"
        
        # If no spec but high complexity, mark as needs_spec
        if not has_spec and (complexity > 15 or loc > 200):
            new_status = "needs_spec"
            needs_spec_count += 1
        elif has_spec:
            ready_count += 1
        else:
            not_ready_count += 1
            
        if new_ready != current_ready or new_status != current_status:
            cursor.execute("""
                UPDATE screens
                SET cypress_ready = ?, cypress_ready_status = ?
                WHERE id = ?
            """, (new_ready, new_status, s["id"]))
            updated_records += 1
            
    conn.commit()
    conn.close()
    
    total = len(screens)
    coverage = (ready_count / total * 100) if total > 0 else 0
    print(f"Synchronized {updated_records} screen records in database.")
    print(f"E2E Spec Coverage        : {coverage:.1f}% ({ready_count} / {total} screens have specs)")
    print(f"Screens needing spec (complexity priority): {needs_spec_count}")
    print(f"Screens untested/not ready                 : {not_ready_count}")
    
    return {
        "spec_coverage_pct": coverage,
        "ready_specs": ready_count,
        "needs_spec": needs_spec_count,
        "not_ready": not_ready_count
    }

def run_post_flight():
    print("==============================================================")
    print("[POST-FLIGHT] EVALUATING CYPRESS E2E RUN RESULTS & KPI ALIGNMENT")
    print("==============================================================")
    
    if not os.path.exists(TEST_REGISTRY_PATH):
        print(f"[INFO] Cypress test registry JSON not found at '{TEST_REGISTRY_PATH}'.")
        print("  Skipping test execution alignment. Execute cypress test sweeps first!")
        return {"registry_found": False}
        
    with open(TEST_REGISTRY_PATH, "r", encoding="utf-8") as f:
        registry = json.load(f)
        
    print(f"Loaded E2E registry containing {len(registry)} tested screens.")
    
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Get all screens from database to align
    cursor.execute("SELECT id, screen_code, is_valid, screenshot_path, video_recording_path FROM screens")
    screens = cursor.fetchall()
    
    passed_count = 0
    failed_count = 0
    updated_records = 0
    missing_proofs = []
    
    for s in screens:
        code = s["screen_code"]
        current_valid = s["is_valid"]
        
        # Check in registry
        entry = registry.get(code)
        
        if entry:
            status = entry.get("status")
            screenshot = entry.get("screenshot_url")
            video = entry.get("video_url")
            
            new_valid = 1 if status == "PASS" else 0
            
            # Verify screenshot proof actually exists on disk
            proof_valid = True
            if screenshot:
                full_proof_path = os.path.join(PROJECT_ROOT, screenshot.replace("/", os.sep).replace("\\", os.sep))
                if not os.path.exists(full_proof_path):
                    proof_valid = False
                    missing_proofs.append((code, "screenshot", screenshot))
                    
            if video:
                full_video_path = os.path.join(PROJECT_ROOT, video.replace("/", os.sep).replace("\\", os.sep))
                if not os.path.exists(full_video_path):
                    missing_proofs.append((code, "video", video))
            
            # Update database record
            cursor.execute("""
                UPDATE screens
                SET is_valid = ?, 
                    screenshot_path = ?, 
                    video_recording_path = ?,
                    when_tested = ?
                WHERE id = ?
            """, (new_valid, screenshot, video, entry.get("tested_at"), s["id"]))
            
            updated_records += 1
            if new_valid == 1:
                passed_count += 1
            else:
                failed_count += 1
        else:
            # If not in registry and had valid=1, reset it unless manually approved by user remarks
            if current_valid == 1:
                cursor.execute("UPDATE screens SET is_valid = 0 WHERE id = ?", (s["id"],))
                updated_records += 1
                
    conn.commit()
    conn.close()
    
    print(f"Synchronized {updated_records} E2E run results into database.")
    print(f"E2E Passed Screens         : {passed_count}")
    print(f"E2E Failed/Untested Screens: {failed_count}")
    
    if len(missing_proofs) > 0:
        print(f"\n[WARNING] Found {len(missing_proofs)} registered runs with missing visual proofs on disk!")
        for idx, (c, t, p) in enumerate(missing_proofs[:10], 1):
            print(f"  {idx}. Screen: '{c}' | Proof Type: {t} | Expected Path: '{p}'")
            
    return {
        "registry_found": True,
        "passed_count": passed_count,
        "failed_count": failed_count,
        "missing_proofs_count": len(missing_proofs)
    }

def main():
    parser = argparse.ArgumentParser(description="Quality Governance KPI and E2E Testing Manager Utility.")
    parser.add_argument("--pre-flight", action="store_true", help="Execute Pre-testing integrity sweep (files & routes)")
    parser.add_argument("--e2e-readiness", action="store_true", help="Audit Cypress specs and readiness metrics")
    parser.add_argument("--post-flight", action="store_true", help="Align post-testing Cypress E2E results and visual proofs")
    parser.add_argument("--all", action="store_true", help="Execute all sweeps (Pre-flight, E2E Readiness, and Post-flight)")
    
    args = parser.parse_args()
    
    if not (args.pre_flight or args.e2e_readiness or args.post_flight or args.all):
        parser.print_help()
        sys.exit(0)
        
    results = {}
    
    if args.pre_flight or args.all:
        results["pre_flight"] = run_pre_flight()
        print()
        
    if args.e2e_readiness or args.all:
        results["e2e_readiness"] = run_e2e_readiness()
        print()
        
    if args.post_flight or args.all:
        results["post_flight"] = run_post_flight()
        print()
        
    # Write aggregated report
    os.makedirs(os.path.dirname(REPORT_PATH), exist_ok=True)
    with open(REPORT_PATH, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2)
        
    print(f"[SUCCESS] Saved comprehensive quality governance sweep report to '{REPORT_PATH}'.")

if __name__ == "__main__":
    main()
