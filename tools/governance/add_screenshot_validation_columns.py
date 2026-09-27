import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))

def main():
    print("Executing Database Migration: Adding Screenshot Visual Validation Telemetry Columns...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Inspect existing columns
    cursor.execute("PRAGMA table_info(screens)")
    existing_cols = {col[1] for col in cursor.fetchall()}

    new_columns = [
        ("screenshot_file_exists", "INTEGER DEFAULT 0"),
        ("screenshot_file_size_bytes", "INTEGER DEFAULT 0"),
        ("screenshot_blank_detected", "INTEGER DEFAULT 0"),
        ("screenshot_visual_score", "INTEGER DEFAULT 0"),
        ("screenshot_validation_status", "TEXT DEFAULT 'pending'"),
        ("visual_proof_verified", "INTEGER DEFAULT 0")
    ]

    # 2. Add columns if missing
    for col_name, col_type in new_columns:
        if col_name not in existing_cols:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type};")
            print(f"  Added column: {col_name} ({col_type})")
        else:
            print(f"  Column {col_name} already exists.")

    # 3. Create implementation_tasks table if it doesn't exist
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS implementation_tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            task_type TEXT NOT NULL,
            screen_id INTEGER,
            title TEXT NOT NULL,
            description TEXT,
            status TEXT DEFAULT 'pending',
            created_at TEXT DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY(screen_id) REFERENCES screens(id)
        );
    """)
    print("  Ensured table: implementation_tasks")

    # 4. Register the governance function 'validate_visual_proofs'
    cursor.execute("""
        INSERT OR REPLACE INTO governance_functions (
            id, function_code, function_name, function_type, purpose_text, 
            run_command, success_condition_text, updates_table, proof_type, 
            proof_output_path, run_order, last_run_status
        ) VALUES (
            22,
            'validate_visual_proofs',
            'Validate Cypress Visual Proofs',
            'visual_validation',
            'Validate screenshots and videos are not blank and contain real UI pixels.',
            'python tools/governance/validate_screenshots.py',
            'All screenshots have valid size, pixel variance, and visual score.',
            'screens',
            'image_analysis',
            'tools/governance/reports/visual_proof_validation.json',
            93,
            'pending'
        );
    """)
    print("  Registered governance function: validate_visual_proofs (Run order 93)")

    conn.commit()
    conn.close()
    print("[SUCCESS] Database migration completed cleanly.")

if __name__ == '__main__':
    main()
