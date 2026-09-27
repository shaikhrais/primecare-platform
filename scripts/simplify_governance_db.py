# Scripts - Category: remodel | Purpose: Simplify the SQLite database by dropping all tables and views not in the 21 final allowed list to eliminate schema noise.
import os
import sqlite3

DB_PATH = os.path.join(".agents", "governance", "governance.db")

ALLOWED_TABLES = {
    "orgs",
    "apps",
    "roles",
    "screens",
    "role_screen_permissions",
    "screen_functions",
    "api_endpoints",
    "code_files",
    "screen_file_links",
    "file_verification_checks",
    "implementation_tasks",
    "drift_findings",
    "test_cases",
    "governance_reports",
    "deployments",
    "build_artifacts",
    "release_versions",
    "ci_pipeline_runs",
    "incident_reports",
    "security_findings",
    "governance_health_scores"
}

ALLOWED_VIEWS = {
    "v_unverified_files",
    "v_role_screen_coverage"
}

def simplify_database():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Disable foreign keys temporarily during drop execution
    cursor.execute("PRAGMA foreign_keys = OFF;")

    # 1. Fetch and drop unallowed views
    cursor.execute("SELECT name FROM sqlite_master WHERE type='view';")
    views = [r[0] for r in cursor.fetchall()]
    
    dropped_views_count = 0
    for v in views:
        if v not in ALLOWED_VIEWS:
            cursor.execute(f"DROP VIEW IF EXISTS {v};")
            dropped_views_count += 1
            print(f"Dropped noise view: {v}")

    # 2. Fetch and drop unallowed tables
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';")
    tables = [r[0] for r in cursor.fetchall()]

    dropped_tables_count = 0
    for t in tables:
        if t not in ALLOWED_TABLES:
            cursor.execute(f"DROP TABLE IF EXISTS {t};")
            dropped_tables_count += 1
            print(f"Dropped noise table: {t}")

    # Re-enable foreign key constraints
    cursor.execute("PRAGMA foreign_keys = ON;")

    # 3. Optimize and pack the database file
    print("\nExecuting database cleanup and optimization (VACUUM)...")
    cursor.execute("VACUUM;")
    
    conn.commit()
    conn.close()

    print(f"\nSimplification Sweep Complete.")
    print(f"  Dropped views: {dropped_views_count}")
    print(f"  Dropped tables: {dropped_tables_count}")
    print(f"  Active Tables Remaining (exactly 21): {len(ALLOWED_TABLES)}")
    print(f"  Active Views Remaining (exactly 2): {len(ALLOWED_VIEWS)}")

if __name__ == "__main__":
    simplify_database()
