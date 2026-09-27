# Scripts - Category: remodel | Purpose: Consolidate drift/security/incident into governance_findings, and build/deploy/release/pipeline into release_operations, retaining exactly 16 allowed tables.
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
    "governance_findings",
    "test_cases",
    "release_operations",
    "governance_reports",
    "governance_health_scores"
}

def consolidate_governance_db():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Disable foreign keys temporarily during schema remodeling
    cursor.execute("PRAGMA foreign_keys = OFF;")

    # 1. Create governance_findings table
    print("Creating governance_findings table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_findings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      finding_category TEXT NOT NULL, -- 'drift', 'security', 'incident'
      finding_code TEXT, -- e.g. vulnerability_code, incident_code, finding_type
      title TEXT NOT NULL,
      severity TEXT DEFAULT 'medium',
      description TEXT,
      status TEXT DEFAULT 'open', -- 'open', 'resolved', 'unresolved'
      related_screen_id INTEGER,
      related_file_id INTEGER,
      related_api_id INTEGER,
      resolved_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_file_id) REFERENCES code_files(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL
    );
    """)

    # 2. Create release_operations table
    print("Creating release_operations table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS release_operations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      operation_type TEXT NOT NULL, -- 'pipeline_run', 'deployment', 'release_version', 'build_artifact'
      status TEXT, -- 'passed', 'failed', 'completed', 'released', 'draft'
      version TEXT, -- version code or release version
      run_number INTEGER, -- for pipeline_runs
      commit_sha TEXT, -- for pipeline_runs
      branch TEXT, -- for pipeline_runs
      environment TEXT, -- for deployments
      triggered_by TEXT, -- for pipeline_runs / deployments
      changelog TEXT, -- for deployments / releases
      artifact_name TEXT, -- for build_artifacts
      file_path TEXT, -- for build_artifacts
      file_size INTEGER, -- for build_artifacts
      checksum TEXT, -- for build_artifacts
      started_at TEXT,
      completed_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 3. Migrate data from drift_findings
    print("Migrating drift_findings to governance_findings...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='drift_findings';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM drift_findings;")
        drifts = cursor.fetchall()
        for d in drifts:
            cursor.execute("""
            INSERT INTO governance_findings (app_id, finding_category, finding_code, title, severity, description, status, related_screen_id, related_file_id, related_api_id, created_at)
            VALUES (?, 'drift', ?, ?, ?, ?, ?, ?, ?, ?, ?);
            """, (d['app_id'], d['finding_type'], f"Drift Finding: {d['finding_type']}", d['severity'], d['message'], d['status'], d['related_screen_id'], d['related_file_id'], d['related_api_id'], d['created_at']))
        print(f"  Successfully migrated {len(drifts)} drift findings.")

    # 4. Migrate data from security_findings
    print("Migrating security_findings to governance_findings...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='security_findings';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM security_findings;")
        securities = cursor.fetchall()
        for s in securities:
            cursor.execute("""
            INSERT INTO governance_findings (app_id, finding_category, finding_code, title, severity, description, status, related_file_id, created_at)
            VALUES (?, 'security', ?, ?, ?, ?, ?, ?, ?);
            """, (s['logical_app_id'], s['vulnerability_code'], s['title'], s['severity'], s['description'], s['remediation_status'], s['affected_artifact_id'], s['created_at']))
        print(f"  Successfully migrated {len(securities)} security findings.")

    # 5. Migrate data from incident_reports
    print("Migrating incident_reports to governance_findings...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='incident_reports';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM incident_reports;")
        incidents = cursor.fetchall()
        for i in incidents:
            cursor.execute("""
            INSERT INTO governance_findings (app_id, finding_category, finding_code, title, severity, description, status, related_file_id, resolved_at, created_at)
            VALUES (?, 'incident', ?, ?, ?, ?, ?, ?, ?, ?);
            """, (i['logical_app_id'], i['incident_code'], i['summary'], i['severity'], i['description'], i['status'], i['affected_artifact_id'], i['resolved_at'], i['created_at']))
        print(f"  Successfully migrated {len(incidents)} incident reports.")

    # 6. Migrate data from deployments
    print("Migrating deployments to release_operations...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='deployments';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM deployments;")
        deps = cursor.fetchall()
        for d in deps:
            cursor.execute("""
            INSERT INTO release_operations (app_id, operation_type, status, version, environment, triggered_by, changelog, completed_at, created_at)
            VALUES (?, 'deployment', ?, ?, ?, ?, ?, ?, ?);
            """, (d['logical_app_id'], d['deployment_status'], d['version'], d['environment'], d['deployed_by'], d['changelog'], d['deployed_at'], d['deployed_at']))
        print(f"  Successfully migrated {len(deps)} deployments.")

    # 7. Migrate data from ci_pipeline_runs
    print("Migrating ci_pipeline_runs to release_operations...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='ci_pipeline_runs';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM ci_pipeline_runs;")
        pipelines = cursor.fetchall()
        for p in pipelines:
            cursor.execute("""
            INSERT INTO release_operations (app_id, operation_type, status, run_number, commit_sha, branch, triggered_by, started_at, completed_at, created_at)
            VALUES (?, 'pipeline_run', ?, ?, ?, ?, ?, ?, ?, ?);
            """, (p['logical_app_id'], p['pipeline_status'], p['run_number'], p['commit_sha'], p['branch'], p['triggered_by'], p['started_at'], p['completed_at'], p['started_at']))
        print(f"  Successfully migrated {len(pipelines)} pipeline runs.")

    # 8. Migrate data from release_versions
    print("Migrating release_versions to release_operations...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='release_versions';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM release_versions;")
        rels = cursor.fetchall()
        for r in rels:
            cursor.execute("""
            INSERT INTO release_operations (app_id, operation_type, status, version, changelog, completed_at, created_at)
            VALUES (?, 'release_version', ?, ?, ?, ?, ?);
            """, (r['logical_app_id'], r['release_status'], r['version_code'], r['changelog'], r['released_at'], r['created_at']))
        print(f"  Successfully migrated {len(rels)} release versions.")

    # 9. Migrate data from build_artifacts
    print("Migrating build_artifacts to release_operations...")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='build_artifacts';")
    if cursor.fetchone():
        cursor.execute("SELECT * FROM build_artifacts;")
        artifacts = cursor.fetchall()
        for a in artifacts:
            # Look up logical app ID from parent pipeline run if possible, otherwise default to 1
            cursor.execute("SELECT app_id FROM release_operations WHERE operation_type='pipeline_run' AND run_number=? LIMIT 1;", (a['pipeline_run_id'],))
            row = cursor.fetchone()
            app_id = row['app_id'] if row else 1
            cursor.execute("""
            INSERT INTO release_operations (app_id, operation_type, artifact_name, file_path, file_size, checksum, completed_at, created_at)
            VALUES (?, 'build_artifact', ?, ?, ?, ?, ?, ?);
            """, (app_id, a['artifact_name'], a['file_path'], a['file_size'], a['checksum'], a['created_at'], a['created_at']))
        print(f"  Successfully migrated {len(artifacts)} build artifacts.")

    # 10. Drop old tables
    old_tables = ['drift_findings', 'security_findings', 'incident_reports', 'deployments', 'ci_pipeline_runs', 'release_versions', 'build_artifacts']
    print(f"\nDropping obsolete tables: {old_tables}...")
    for t in old_tables:
        cursor.execute(f"DROP TABLE IF EXISTS {t};")

    # 11. Drop any extra noise views or tables not in ALLOWED_TABLES
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';")
    tables = [r[0] for r in cursor.fetchall()]
    for t in tables:
        if t not in ALLOWED_TABLES:
            print(f"Dropping extra table: {t}")
            cursor.execute(f"DROP TABLE IF EXISTS {t};")

    # Re-enable foreign key constraints
    cursor.execute("PRAGMA foreign_keys = ON;")

    # 12. Run VACUUM
    print("\nExecuting database optimization (VACUUM)...")
    conn.commit()
    conn.isolation_level = None
    conn.execute("VACUUM;")
    conn.close()
    print("\nRelational Consolidation Complete. Exactly 16 tables now remain.")

if __name__ == "__main__":
    consolidate_governance_db()
