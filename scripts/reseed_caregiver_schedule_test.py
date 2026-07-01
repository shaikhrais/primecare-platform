import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("RE-SEEDING DYNAMIC TEST FOR CAREGIVER SCHEDULE (SCREEN 281)")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    # 1. Clean old test cases
    c.execute("DELETE FROM screen_test_steps WHERE test_definition_id IN (SELECT id FROM screen_test_definitions WHERE screen_id = 577 or screen_id = 281)")
    c.execute("DELETE FROM screen_test_definitions WHERE screen_id = 577 or screen_id = 281")

    # 2. Update screen_required_elements for screen ID 281
    # Deactivate the wrong underscore-based elements
    c.execute("""
        UPDATE screen_required_elements
        SET required = 0
        WHERE screen_id = 281 AND test_id LIKE '%_%'
    """)
    # Activate the correct non-underscore elements found in the Dart file
    c.execute("""
        UPDATE screen_required_elements
        SET required = 1
        WHERE screen_id = 281 AND test_id IN ('caregiverschedule-screen', 'caregiverschedule-title', 'caregiverschedule-content')
    """)

    # 3. Insert new test definition for CaregiverScheduleScreen (ID 281)
    print("Inserting test definition for CaregiverScheduleScreen...")
    c.execute("""
        INSERT INTO screen_test_definitions (
            screen_id, test_code, test_name, test_type, enabled, priority, requires_auth, 
            role_id, route_path, sidebar_label, expected_title, expected_layout, 
            required_elements_json, forbidden_text_json, acceptance_criteria_json
        ) VALUES (
            281, 
            'caregiver_schedule_runtime', 
            'Caregiver Schedule Runtime Test', 
            'e2e', 
            1, 
            100, 
            1, 
            12, 
            '/offices/clinical/roles/caregiver/schedule', 
            'Schedule', 
            'Schedule Control Center', 
            'dashboard',
            '["caregiverschedule-screen", "caregiverschedule-title", "caregiverschedule-content"]',
            '["Fully Implemented", "Placeholder", "Coming Soon", "TODO", "Lorem ipsum", "Under Construction", "Sample Data", "Screen Implemented"]',
            '["Screen loads successfully", "Schedule title is visible", "Schedule content is present"]'
        )
    """)
    def_id = c.lastrowid

    print(f"Seeding steps for test definition ID {def_id}...")
    steps = [
        (1, 'login_as_role', None, 'caregiver', None),
        (2, 'visit', None, '/offices/clinical/roles/caregiver/schedule', None),
        (3, 'should_be_visible', 'caregiverschedule-screen', None, None),
        (4, 'should_be_visible', 'caregiverschedule-title', None, None),
        (5, 'should_be_visible', 'caregiverschedule-content', None, None),
        (6, 'should_contain', 'caregiverschedule-title', None, 'Schedule Control Center'),
        (7, 'screenshot', None, None, None)
    ]
    for order, action, selector, value, expected in steps:
        c.execute("""
            INSERT INTO screen_test_steps (test_definition_id, step_order, action, selector, value, expected)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (def_id, order, action, selector, value, expected))

    # Also clean all previous test results to start clean
    c.execute("DELETE FROM screen_test_results")
    c.execute("DELETE FROM screen_test_runs")

    conn.commit()
    conn.close()

    print("==============================================================")
    print("RE-SEEDING COMPLETED SUCCESSFULLY!")
    print("==============================================================")

if __name__ == "__main__":
    main()
