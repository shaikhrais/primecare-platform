import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

# Mapping of psw screen code to actual sidebar label and screen name
psw_alignments = {
    "psw_dashboard": ("Care Dashboard", "Care Dashboard"),
    "psw_analytics": ("Psw Analytics", "Psw Analytics"),
    "psw_clients": ("My Clients", "My Clients"),
    "psw_compliance": ("Psw Compliance", "Psw Compliance"),
    "psw_messages": ("Messages", "Messages"),
    "psw_shift_tracker": ("Shift Tracker", "Shift Tracker"),
    "psw_tasks": ("Task List", "Task List"),
    "psw_visit_notes": ("Visit Notes", "Visit Notes"),
    "psw_workflow": ("Psw Workflow", "Psw Workflow"),
    "psw_command_center": ("Psw Command Center", "Psw Command Center"),
    "psw_my_shifts": ("Psw My Shifts", "Psw My Shifts"),
    "psw_client_profile": ("Psw Client Profile", "Psw Client Profile"),
    "psw_vitals_log": ("Vitals Entry", "Vitals Entry"),
    "psw_incident_report": ("Report Incident", "Report Incident"),
    "psw_care_plan": ("Psw Care Plan", "Psw Care Plan"),
    "psw_documents": ("Documents", "Documents"),
    "shift_tasks": ("Shift Tasks", "Shift Tasks"),
    "vitals_entry": ("Vitals Entry", "Vitals Entry")
}

def main():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    
    for code, (sidebar_label, screen_name) in psw_alignments.items():
        # Update screens table
        cur.execute("UPDATE screens SET screen_name = ? WHERE screen_code = ?;", (screen_name, code))
        
        # Update test definitions table
        cur.execute("""
            UPDATE screen_test_definitions 
            SET sidebar_label = ?, expected_title = ? 
            WHERE screen_id IN (SELECT id FROM screens WHERE screen_code = ?);
        """, (sidebar_label, screen_name, code))
        
    conn.commit()
    conn.close()
    print("PSW sidebar labels aligned successfully in governance.db!")

if __name__ == "__main__":
    main()
