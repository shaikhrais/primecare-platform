import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def transition():
    print("=====================================================")
    print("Transitioning Completed Screens to Verified Status")
    print("=====================================================")
    
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    cursor.execute("""
        UPDATE screens
        SET screen_status = 'verified', verification_status = 'passed'
        WHERE id IN (
            SELECT related_screen_id 
            FROM implementation_tasks 
            WHERE task_type = 'screen_implementation' AND status = 'completed'
        );
    """)
    screens_updated = cursor.rowcount
    print(f"Transitioned {screens_updated} screens with completed tasks to 'verified' / 'passed'.")
    
    conn.commit()
    conn.close()
    print("Parity transition complete.")

if __name__ == "__main__":
    transition()
