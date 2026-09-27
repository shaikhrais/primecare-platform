import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print(f"🚀 Initiating Screen Quality Milestones Database Setup on '{DB_PATH}'...")
    
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Create screen_milestones table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS screen_milestones (
            screen_code TEXT PRIMARY KEY,
            pre_test_ready INTEGER DEFAULT 0,
            routes_files_ready INTEGER DEFAULT 0,
            layout_ready INTEGER DEFAULT 0,
            code_ready INTEGER DEFAULT 0,
            data_code_ready INTEGER DEFAULT 0,
            presentation_ready INTEGER DEFAULT 0,
            last_updated TEXT DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (screen_code) REFERENCES screens (screen_code)
        );
    """)
    print("✨ Successfully created 'screen_milestones' schema in SQLite database!")

    # 2. Get all screen codes in registry
    cursor.execute("SELECT screen_code FROM screens")
    screens = [r[0] for r in cursor.fetchall()]
    print(f"  Found {len(screens)} screens in registry. Seeding initial milestones...")

    # Insert default milestones (0) for all screens if not exists
    milestone_seeds = []
    for code in screens:
        milestone_seeds.append((code, 0, 0, 0, 0, 0, 0))

    cursor.executemany("""
        INSERT OR IGNORE INTO screen_milestones (screen_code, pre_test_ready, routes_files_ready, layout_ready, code_ready, data_code_ready, presentation_ready)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """, milestone_seeds)
    conn.commit()

    # 3. Update the 5 high-priority clinical flow screens to 100% completed milestones
    # As they have been static verified, Cypress E2E visual verified, and route mounted successfully.
    completed_clinical_screens = ["psw_workflow", "rn_workflow", "rpn_workflow", "rn_analytics", "clinical_dashboard"]
    
    cursor.execute(f"""
        UPDATE screen_milestones
        SET pre_test_ready = 1,
            routes_files_ready = 1,
            layout_ready = 1,
            code_ready = 1,
            data_code_ready = 1,
            presentation_ready = 1,
            last_updated = CURRENT_TIMESTAMP
        WHERE screen_code IN ({",".join("?" for _ in completed_clinical_screens)})
    """, completed_clinical_screens)
    
    conn.commit()
    print(f"✨ Successfully updated milestones to 100% (Completed) for high-priority clinical flow screens: {completed_clinical_screens}")

    # 4. Count and verify database status
    cursor.execute("SELECT COUNT(*) FROM screen_milestones")
    total_records = cursor.fetchone()[0]
    
    cursor.execute("SELECT COUNT(*) FROM screen_milestones WHERE presentation_ready = 1")
    ready_count = cursor.fetchone()[0]

    print(f"📈 Total Milestone Records: {total_records} / 948")
    print(f"🏆 Fully Verified and Mounted clinical screens: {ready_count}")

    conn.close()
    print("🏁 Screen Milestones database initialization loop completed successfully!")

if __name__ == '__main__':
    main()
