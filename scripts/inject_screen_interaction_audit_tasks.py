import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def inject():
    print("=====================================================")
    print("Injecting Screen Interaction Audit Tasks")
    print("=====================================================")
    
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # 1. Clean existing incomplete screen_interaction_audit tasks to prevent duplication if re-run
    cursor.execute("""
        DELETE FROM implementation_tasks 
        WHERE task_type = 'screen_interaction_audit' AND status = 'pending';
    """)
    
    # 2. Insert new tasks
    cursor.execute("""
    INSERT INTO implementation_tasks
    (app_id, task_title, task_description, priority, task_type, related_screen_id, assigned_agent, status, created_at)
    SELECT
      app_id,
      'Complete screen interaction audit: ' || screen_name,
      'Fill button_list_text, function_list_text, api_call_list_text, allowed_roles_text, proof_log_path, screenshot_path. Verify real buttons/actions/APIs, not only widget render.',
      'high',
      'screen_interaction_audit',
      id,
      'antigravity_agent',
      'pending',
      CURRENT_TIMESTAMP
    FROM screens
    WHERE button_list_text IS NULL
       OR button_list_text = ''
       OR function_list_text IS NULL
       OR function_list_text = ''
       OR api_call_list_text IS NULL
       OR api_call_list_text = ''
       OR allowed_roles_text IS NULL
       OR allowed_roles_text = ''
       OR screenshot_path IS NULL
       OR screenshot_path = '';
    """)
    tasks_inserted = cursor.rowcount
    print(f"Successfully injected {tasks_inserted} screen interaction audit tasks in pending state.")
    
    conn.commit()
    conn.close()
    print("Injection complete.")

if __name__ == "__main__":
    inject()
