import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def inject():
    print("=====================================================")
    print("Resetting Screens Registry & Injecting Interaction Audit Tasks")
    print("=====================================================")
    
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # 1. Wipe out legacy mock interaction fields to reset all 387 screens to a clean slate
    print("Clearing legacy mock interaction details...")
    cursor.execute("""
        UPDATE screens
        SET 
            button_list_text = NULL,
            function_list_text = NULL,
            function_audit_json = NULL,
            api_call_list_text = NULL,
            api_audit_json = NULL,
            allowed_roles_text = NULL,
            proof_log_path = NULL,
            screenshot_path = NULL,
            verification_status = 'interaction_pending';
    """)
    wiped_count = cursor.rowcount
    print(f"  Reset {wiped_count} screens to clean slate in screens table.")

    # 2. Enforce strict status reset to 'interaction_pending'
    print("Enforcing strict 6-state status reset queries...")
    cursor.execute("""
        UPDATE screens
        SET verification_status = 'interaction_pending'
        WHERE button_list_text IS NULL
           OR button_list_text = ''
           OR function_list_text IS NULL
           OR function_list_text = ''
           OR api_call_list_text IS NULL
           OR api_call_list_text = ''
           OR allowed_roles_text IS NULL
           OR allowed_roles_text = ''
           OR screenshot_path IS NULL
           OR screenshot_path = ''
           OR proof_log_path IS NULL
           OR proof_log_path = '';
    """)
    reset_count = cursor.rowcount
    print(f"  Strict status reset verified: {reset_count} screens set to 'interaction_pending'.")

    # 3. Clean any existing pending or completed screen_interaction_audit tasks to prevent duplication
    print("Wiping existing implementation tasks for screen interaction audits...")
    cursor.execute("""
        DELETE FROM implementation_tasks 
        WHERE task_type = 'screen_interaction_audit';
    """)
    deleted_tasks = cursor.rowcount
    print(f"  Cleaned {deleted_tasks} redundant audit tasks from implementaton queue.")
    
    # 4. Inject 387 strict task groups matching screens lacking audited interaction data
    print("Injecting new screen interaction audit tasks queue...")
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
       OR screenshot_path = ''
       OR proof_log_path IS NULL
       OR proof_log_path = '';
    """)
    tasks_inserted = cursor.rowcount
    print(f"  Successfully injected {tasks_inserted} screen interaction audit tasks in pending state.")
    
    conn.commit()
    conn.close()
    print("Injection pipeline successfully executed.")

if __name__ == "__main__":
    inject()
