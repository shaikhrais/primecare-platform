import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PATCHING PRIMECARE GOVERNANCE DB WITH CYPRESS TESTING SCHEMAS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    # Drop existing tables to start fresh
    c.execute("DROP TABLE IF EXISTS screen_test_steps")
    c.execute("DROP TABLE IF EXISTS screen_test_results")
    c.execute("DROP TABLE IF EXISTS screen_test_definitions")
    c.execute("DROP TABLE IF EXISTS screen_test_runs")

    # 1. Create screen_test_definitions
    print("Creating screen_test_definitions table...")
    c.execute("""
    CREATE TABLE screen_test_definitions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        test_code TEXT UNIQUE NOT NULL,
        test_name TEXT NOT NULL,
        test_type TEXT NOT NULL,
        enabled INTEGER DEFAULT 1,
        priority INTEGER DEFAULT 100,
        requires_auth INTEGER DEFAULT 1,
        role_id INTEGER,
        route_path TEXT,
        sidebar_label TEXT,
        expected_title TEXT,
        expected_layout TEXT,
        required_elements_json TEXT,
        forbidden_text_json TEXT,
        acceptance_criteria_json TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id)
    );
    """)

    # 2. Create screen_test_steps
    print("Creating screen_test_steps table...")
    c.execute("""
    CREATE TABLE screen_test_steps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        test_definition_id INTEGER NOT NULL,
        step_order INTEGER NOT NULL,
        action TEXT NOT NULL,
        selector TEXT,
        value TEXT,
        expected TEXT,
        timeout_ms INTEGER DEFAULT 10000,
        required INTEGER DEFAULT 1,
        FOREIGN KEY (test_definition_id) REFERENCES screen_test_definitions(id) ON DELETE CASCADE
    );
    """)

    # 3. Create screen_test_results
    print("Creating screen_test_results table...")
    c.execute("""
    CREATE TABLE screen_test_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        test_definition_id INTEGER NOT NULL,
        screen_id INTEGER NOT NULL,
        run_id TEXT NOT NULL,
        status TEXT NOT NULL,
        error_message TEXT,
        screenshot_path TEXT,
        video_path TEXT,
        browser TEXT,
        started_at TEXT,
        finished_at TEXT,
        duration_ms INTEGER,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (test_definition_id) REFERENCES screen_test_definitions(id) ON DELETE CASCADE,
        FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
    );
    """)

    # 4. Create screen_test_runs
    print("Creating screen_test_runs table...")
    c.execute("""
    CREATE TABLE screen_test_runs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_id TEXT UNIQUE NOT NULL,
        run_type TEXT NOT NULL,
        total_tests INTEGER DEFAULT 0,
        passed_tests INTEGER DEFAULT 0,
        failed_tests INTEGER DEFAULT 0,
        skipped_tests INTEGER DEFAULT 0,
        started_at TEXT,
        finished_at TEXT,
        report_path TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    # 5. Seed one screen test case (ID 577, ScheduleScreen)
    print("\nSeeding dynamic test definition for ScheduleScreen (ID 577)...")
    c.execute("""
        INSERT INTO screen_test_definitions (
            screen_id, test_code, test_name, test_type, enabled, priority, requires_auth, 
            role_id, route_path, sidebar_label, expected_title, expected_layout, 
            required_elements_json, forbidden_text_json, acceptance_criteria_json
        ) VALUES (
            577, 
            'caregiver_schedule_runtime', 
            'Caregiver Schedule Runtime Test', 
            'e2e', 
            1, 
            100, 
            1, 
            12, 
            '/offices/clinical/roles/caregiver/psw-schedule', 
            'Schedule', 
            'Schedule', 
            'dashboard',
            '["schedule-screen", "schedule-title", "schedule-content"]',
            '["Fully Implemented", "Placeholder", "Coming Soon", "TODO", "Lorem ipsum", "Under Construction", "Sample Data", "Screen Implemented"]',
            '["Screen loads successfully", "Schedule title is visible", "Schedule content is present"]'
        )
    """)
    def_id = c.lastrowid

    print(f"Seeding steps for test definition ID {def_id}...")
    steps = [
        (1, 'login_as_role', None, 'caregiver', None),
        (2, 'visit', None, '/offices/clinical/roles/caregiver/psw-schedule', None),
        (3, 'should_be_visible', 'schedule-screen', None, None),
        (4, 'should_be_visible', 'schedule-title', None, None),
        (5, 'should_be_visible', 'schedule-content', None, None),
        (6, 'should_contain', 'schedule-title', None, 'Schedule'),
        (7, 'screenshot', None, None, None)
    ]
    for idx, (order, action, selector, value, expected) in enumerate(steps):
        c.execute("""
            INSERT INTO screen_test_steps (test_definition_id, step_order, action, selector, value, expected)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (def_id, order, action, selector, value, expected))

    conn.commit()
    conn.close()

    print("==============================================================")
    print("DATABASE PATCHED AND SEEDED SUCCESSFULLY!")
    print("==============================================================")

if __name__ == "__main__":
    main()
