# scripts/seed_screen_functionality.py
import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def seed():
    print(f"Connecting to database: {DB_PATH}")
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    # Enable foreign keys
    cur.execute("PRAGMA foreign_keys = ON;")

    # 1. Seed Requirements for PSW Dashboard (ID 61)
    cur.execute("DELETE FROM screen_requirements WHERE screen_id = 61;")
    cur.execute("""
        INSERT INTO screen_requirements (screen_id, business_purpose, user_story, sidebar_label, acceptance_criteria)
        VALUES (
            61,
            'Provide the Personal Support Worker (PSW) with a unified operational command center for viewing their schedule, tracking shifts, checking client details, and logging tasks.',
            'As a PSW, I want to see my upcoming shifts, check in/out of client homes, view assigned tasks, and quickly access vitals logging or incident reporting so I can deliver high-quality, compliant care.',
            'PSW Dashboard',
            '1. Render upcoming shifts list dynamically.\n2. Allow interactive check-in/check-out button action to update shift state.\n3. Display active alerts and a shortcut to log vitals or report incidents.'
        );
    """)

    # 2. Seed Required Elements for PSW Dashboard (ID 61)
    cur.execute("DELETE FROM screen_required_elements WHERE screen_id = 61;")
    elements = [
        ('psw-shift-status-card', 'card', 'Active Shift Status', 'psw-shift-status-card'),
        ('psw-start-shift-btn', 'button', 'Start/End Shift Action Button', 'psw-start-shift-btn'),
        ('psw-report-incident-btn', 'button', 'Report Incident Action Button', 'psw-report-incident-btn'),
        ('psw-view-vitals-btn', 'button', 'Log Vitals Action Button', 'psw-view-vitals-btn'),
        ('psw-clients-list', 'list', 'Assigned Clients List Widget', 'psw-clients-list')
    ]
    for el_key, el_type, label, test_id in elements:
        cur.execute("""
            INSERT INTO screen_required_elements (screen_id, element_key, element_type, label, test_id, required)
            VALUES (?, ?, ?, ?, ?, 1);
        """, (61, el_key, el_type, label, test_id))

    # 3. Seed Development Task for PSW Dashboard (ID 61)
    cur.execute("DELETE FROM development_tasks WHERE screen_id = 61;")
    cur.execute("""
        INSERT INTO development_tasks (screen_id, assigned_to, task_type, status, started_at)
        VALUES (61, 'Antigravity AI', 'functional_implementation', 'IN_PROGRESS', datetime('now'));
    """)

    conn.commit()
    print("Successfully seeded requirements, elements, and development tasks for PSW Dashboard (ID 61).")
    conn.close()

if __name__ == "__main__":
    seed()
