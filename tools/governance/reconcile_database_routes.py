import os
import sqlite3
import json

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

# Exact mappings for PSW screens
PSW_MAPPINGS = {
    "psw_dashboard": "/offices/clinical/roles/psw/dashboard",
    "psw_shift_tracker": "/offices/clinical/roles/psw/schedule",
    "psw_clients": "/offices/clinical/roles/psw/patient-profile",
    "psw_tasks": "/offices/clinical/roles/psw/visit-checklist",
    "psw_messages": "/offices/clinical/roles/psw/messages",
    "psw_visit_notes": "/offices/clinical/roles/psw/visit-notes",
    "psw_profile": "/offices/clinical/roles/psw/profile",
    "psw_reports": "/offices/clinical/roles/psw/reports",
    "psw_documents": "/offices/clinical/roles/psw/documents",
    "psw_check_in": "/offices/clinical/roles/psw/check-in",
    "psw_system_logs": "/offices/clinical/roles/psw/system-logs",
    "psw_notifications": "/offices/clinical/roles/psw/notifications",
    "psw_help_support": "/offices/clinical/roles/psw/help-support",
    "psw_care_plan": "/offices/clinical/roles/psw/care-plan",
    "psw_vitals_log": "/offices/clinical/roles/psw/observation-vitals-log",
    "psw_incident_report": "/offices/clinical/roles/psw/incident-report",
    "shift_tasks": "/offices/clinical/roles/psw/shift-tasks",
    "visit_notes": "/offices/clinical/roles/psw/visit-notes",
    "vitals_entry": "/offices/clinical/roles/psw/vitals-entry",
    "incident_report": "/offices/clinical/roles/psw/incident-report"
}

# Mappings for RN screens
RN_MAPPINGS = {
    "rn_dashboard": "/offices/clinical/roles/rn/dashboard",
    "rn_medications": "/offices/clinical/roles/rn/medications",
    "rn_vitals": "/offices/clinical/roles/rn/vitals",
    "rn_patient_charting": "/offices/clinical/roles/rn/patient-charting",
    "patient_charting": "/offices/clinical/roles/rn/patient-charting",
    "medication_administration": "/offices/clinical/roles/rn/medication-administration",
    "care_plan_review": "/offices/clinical/roles/rn/care-plan-review",
    "incident_review": "/offices/clinical/roles/rn/incident-review",
    "shift_report": "/offices/clinical/roles/rn/shift-report"
}

# Mappings for RPN screens
RPN_MAPPINGS = {
    "rpn_dashboard": "/offices/clinical/roles/rpn/dashboard",
    "rpn_medications": "/offices/clinical/roles/rpn/medications",
    "rpn_vitals": "/offices/clinical/roles/rpn/vitals",
    "rpn_patient_charting": "/offices/clinical/roles/rpn/patient-charting",
    "nursing_task": "/offices/clinical/roles/rpn/nursing-task",
    "vitals_tracking": "/offices/clinical/roles/rpn/vitals-tracking",
    "medication": "/offices/clinical/roles/rpn/medication",
    "patient_observation": "/offices/clinical/roles/rpn/patient-observation"
}

def main():
    print("==============================================================")
    print("PRIMECARE ROUTE RECONCILIATION: ALIGNING SQLITE TO FLUTTER ROUTER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # 1. Update PSW screen routes
    psw_role = cur.execute("SELECT id FROM roles WHERE role_code='psw';").fetchone()
    if psw_role:
        psw_role_id = psw_role["id"]
        print(f"Updating PSW (role_id={psw_role_id}) screen routes...")
        for code, route in PSW_MAPPINGS.items():
            cur.execute("""
                UPDATE screens
                SET route_path = ?
                WHERE role_id = ? AND (screen_code = ? OR screen_code = ?);
            """, (route, psw_role_id, code, code + "_screen"))
            print(f"  Mapped {code} -> {route}")
            
        # Fallback search for any other /psw/ screen routes
        cur.execute("""
            UPDATE screens
            SET route_path = replace(route_path, '/psw/', '/offices/clinical/roles/psw/')
            WHERE role_id = ? AND route_path LIKE '/psw/%';
        """, (psw_role_id,))
        print("  Mapped any remaining /psw/ routes to /offices/clinical/roles/psw/")
        
    # 2. Update RN screen routes
    rn_role = cur.execute("SELECT id FROM roles WHERE role_code='rn';").fetchone()
    if rn_role:
        rn_role_id = rn_role["id"]
        print(f"\nUpdating RN (role_id={rn_role_id}) screen routes...")
        for code, route in RN_MAPPINGS.items():
            cur.execute("""
                UPDATE screens
                SET route_path = ?
                WHERE role_id = ? AND (screen_code = ? OR screen_code = ?);
            """, (route, rn_role_id, code, code + "_screen"))
            print(f"  Mapped {code} -> {route}")
            
        # Fallback search for any other /rn/ screen routes
        cur.execute("""
            UPDATE screens
            SET route_path = replace(route_path, '/rn/', '/offices/clinical/roles/rn/')
            WHERE role_id = ? AND route_path LIKE '/rn/%';
        """, (rn_role_id,))
        print("  Mapped any remaining /rn/ routes to /offices/clinical/roles/rn/")

    # 3. Update RPN screen routes
    rpn_role = cur.execute("SELECT id FROM roles WHERE role_code='rpn';").fetchone()
    if rpn_role:
        rpn_role_id = rpn_role["id"]
        print(f"\nUpdating RPN (role_id={rpn_role_id}) screen routes...")
        for code, route in RPN_MAPPINGS.items():
            cur.execute("""
                UPDATE screens
                SET route_path = ?
                WHERE role_id = ? AND (screen_code = ? OR screen_code = ?);
            """, (route, rpn_role_id, code, code + "_screen"))
            print(f"  Mapped {code} -> {route}")
            
        # Fallback search for any other /rpn/ screen routes
        cur.execute("""
            UPDATE screens
            SET route_path = replace(route_path, '/rpn/', '/offices/clinical/roles/rpn/')
            WHERE role_id = ? AND route_path LIKE '/rpn/%';
        """, (rpn_role_id,))
        print("  Mapped any remaining /rpn/ routes to /offices/clinical/roles/rpn/")

    conn.commit()
    conn.close()
    print("\nRoute reconciliation successfully committed to SQLite database!")

if __name__ == '__main__':
    main()
