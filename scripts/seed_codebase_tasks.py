# scripts/seed_codebase_tasks.py
import os
import sys
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE IMPLEMENTATION TASKS SEEDER: GENERATING GAPS TASKS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Clean up existing pending screen_requirement_implementation tasks to prevent duplication
    print("Cleaning up old pending screen requirement tasks...")
    cursor.execute("""
        DELETE FROM implementation_tasks 
        WHERE task_type = 'screen_requirement_implementation' AND status = 'pending';
    """)
    deleted_count = cursor.rowcount
    print(f"Removed {deleted_count} stale pending implementation tasks.")

    # 2. Insert tasks from view
    print("Seeding new tasks from v_screen_code_gap_plan view...")
    cursor.execute("""
        INSERT INTO implementation_tasks
        (app_id, task_title, task_description, priority, task_type, related_screen_id, assigned_agent, status, created_at)
        SELECT
          app_id,
          'Implement missing screen requirements: ' || screen_name,
          implementation_plan_text,
          'high',
          'screen_requirement_implementation',
          id,
          'antigravity_agent',
          'pending',
          CURRENT_TIMESTAMP
        FROM v_screen_code_gap_plan;
    """)
    seeded_count = cursor.rowcount
    print(f"Successfully seeded {seeded_count} requirements implementation tasks!")

    conn.commit()
    conn.close()
    print("==============================================================")
    print("TASK SEEDING PROCESS COMPLETED SUCCESSFULLY!")
    print("==============================================================")

if __name__ == '__main__':
    main()
