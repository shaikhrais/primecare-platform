# scripts/reset_database_gaps.py
import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("Resetting SQLite tracking columns to clean pending states...")
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE screens
        SET
            required_components_json = NULL,
            actual_components_json = NULL,
            missing_components_json = NULL,
            required_buttons_json = NULL,
            actual_buttons_json = NULL,
            missing_buttons_json = NULL,
            required_functions_json = NULL,
            actual_functions_json = NULL,
            missing_functions_json = NULL,
            required_apis_json = NULL,
            actual_apis_json = NULL,
            missing_apis_json = NULL,
            required_responsive_json = NULL,
            actual_responsive_json = NULL,
            missing_responsive_json = NULL,
            code_gap_summary = NULL,
            implementation_plan_text = NULL,
            ready_for_implementation = 0,
            
            implementation_depth_status = 'pending',
            runtime_clicked = 0,
            runtime_data_loaded = 0,
            runtime_api_success = 0,
            runtime_save_tested = 0,
            workflow_verified = 0,
            verification_status = 'pending',
            problem_summary = NULL,
            suggested_fix = NULL;
    """)
    print(f"Successfully reset {cursor.rowcount} screens in the registry database.")
    
    # Delete implementation tasks
    cursor.execute("""
        DELETE FROM implementation_tasks 
        WHERE task_type = 'screen_requirement_implementation';
    """)
    print(f"Removed {cursor.rowcount} requirements tasks.")
    
    conn.commit()
    conn.close()

if __name__ == '__main__':
    main()
