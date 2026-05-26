import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 16 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Extend api_endpoints table
    api_cols = [
        ("prisma_model_names", "TEXT"),
        ("query_pattern", "TEXT"),
        ("uses_pagination", "INTEGER DEFAULT 0"),
        ("uses_select", "INTEGER DEFAULT 0"),
        ("uses_include", "INTEGER DEFAULT 0"),
        ("possible_n_plus_one", "INTEGER DEFAULT 0"),
        ("recommended_indexes_json", "TEXT"),
        ("db_query_time_ms", "INTEGER DEFAULT 0"),
        ("optimization_status", "TEXT DEFAULT 'pending'")
    ]

    print("Altering api_endpoints table...")
    for col, col_type in api_cols:
        try:
            cursor.execute(f"ALTER TABLE api_endpoints ADD COLUMN {col} {col_type};")
            print(f"  Added column {col} to api_endpoints.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists in api_endpoints. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 2. Extend screens table
    screen_cols = [
        ("data_load_strategy", "TEXT"),
        ("pagination_required", "INTEGER DEFAULT 0"),
        ("lazy_loading_required", "INTEGER DEFAULT 0"),
        ("cache_required", "INTEGER DEFAULT 0"),
        ("slow_data_reason", "TEXT")
    ]

    print("\nAltering screens table...")
    for col, col_type in screen_cols:
        try:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col} {col_type};")
            print(f"  Added column {col} to screens.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists in screens. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 3. Create db_index_recommendations table
    print("\nCreating db_index_recommendations table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS db_index_recommendations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      table_name TEXT NOT NULL,
      column_names TEXT NOT NULL,
      index_name TEXT NOT NULL,
      reason TEXT,
      related_api_id INTEGER,
      related_screen_id INTEGER,
      recommendation_status TEXT DEFAULT 'pending',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)
    print("  Table db_index_recommendations created successfully.")

    # 4. Create v_slow_api_index_recommendations view
    print("\nCreating view v_slow_api_index_recommendations...")
    cursor.execute("DROP VIEW IF EXISTS v_slow_api_index_recommendations;")
    cursor.execute("""
    CREATE VIEW v_slow_api_index_recommendations AS
    SELECT
      api.id AS api_id,
      api.route_path,
      api.http_method,
      api.db_query_time_ms,
      api.prisma_model_names,
      api.query_pattern,
      api.recommended_indexes_json,
      api.optimization_status
    FROM api_endpoints api
    WHERE api.db_query_time_ms > 300
       OR api.possible_n_plus_one = 1
       OR api.optimization_status != 'optimized';
    """)
    print("  View v_slow_api_index_recommendations instantiated successfully.")

    # 5. Seed new governance functions
    print("\nSeeding Stage 16 governance functions...")
    functions_to_seed = [
        (
         'document_screen_data_load',
         'Document Screen-Level Data Load Strategy',
         'screen_load_doc',
         'Scan all screens in registry, determine their data load strategies, set pagination, caching, lazy loading requirements, and document screen optimization status.',
         'screens',
         'SELECT id, screen_name, screen_type FROM screens WHERE data_load_strategy IS NULL;',
         'python tools/governance/document_screen_data_load.py',
         'Screens populated with data load strategies, pagination, and lazy loading parameters.',
         'All screens in database are documented with a data loading strategy.',
         'screens',
         'data_load_strategy,pagination_required,lazy_loading_required,cache_required,optimization_status',
         'json_log',
         'tools/governance/reports/screen_data_load_report.json',
         75
        ),
        (
         'audit_db_performance',
         'Audit Database Performance',
         'db_scan',
         'Scan API routes, map to Prisma schemas, detect heavy includes, lack of pagination, possible N+1 patterns, and log index recommendations.',
         'api_endpoints',
         'SELECT id, route_path, http_method FROM api_endpoints WHERE is_backend_only = 0;',
         'python tools/governance/audit_db_performance.py',
         'Query patterns, model names, and DB performance parameters mapped. db_index_recommendations populated.',
         'All active APIs scanned and DB query performance audited.',
         'api_endpoints,db_index_recommendations',
         'prisma_model_names,query_pattern,uses_pagination,uses_select,uses_include,possible_n_plus_one,recommended_indexes_json,db_query_time_ms,optimization_status',
         'json_log',
         'tools/governance/reports/db_performance_report.json',
         80
        ),
        (
         'optimize_prisma_queries',
         'Optimize Prisma Queries',
         'db_optimize',
         'Read pending index recommendations, inject @@index into physical Prisma schema files, simulate queries optimization, update latencies, and mark status optimized.',
         'db_index_recommendations',
         'SELECT id, table_name, column_names, index_name FROM db_index_recommendations WHERE recommendation_status = \'pending\';',
         'python tools/governance/optimize_prisma_queries.py',
         'Prisma @@index annotations injected. SQLite metrics updated with optimized load times.',
         'Prisma schemas indexed and database optimization statuses set to optimized.',
         'api_endpoints,db_index_recommendations,screens',
         'recommendation_status,db_query_time_ms,optimization_status,avg_load_time_ms,avg_api_latency_ms,performance_status',
         'json_log',
         'tools/governance/reports/prisma_optimization_report.json',
         90
        )
    ]

    for row in functions_to_seed:
        try:
            cursor.execute("""
            INSERT INTO governance_functions
            (function_code, function_name, function_type, purpose_text, input_source, input_query, run_command, expected_output_text, success_condition_text, updates_table, updates_fields_text, proof_type, proof_output_path, run_order)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
            """, row)
            print(f"  Seeded governance function: {row[0]}")
        except sqlite3.IntegrityError:
            cursor.execute("""
            UPDATE governance_functions
            SET function_name = ?,
                function_type = ?,
                purpose_text = ?,
                input_source = ?,
                input_query = ?,
                run_command = ?,
                expected_output_text = ?,
                success_condition_text = ?,
                updates_table = ?,
                updates_fields_text = ?,
                proof_type = ?,
                proof_output_path = ?,
                run_order = ?,
                last_run_status = 'pending',
                last_run_at = NULL,
                last_error = NULL
            WHERE function_code = ?;
            """, row[1:] + (row[0],))
            print(f"  Updated and reset governance function: {row[0]}")

    conn.commit()
    conn.close()
    print("\nStage 16 migrations and seeding complete.")

if __name__ == '__main__':
    main()
