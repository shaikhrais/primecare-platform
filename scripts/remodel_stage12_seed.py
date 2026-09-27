import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("SEEDING STAGE 12 GOVERNANCE FUNCTIONS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Define the 10 new stored functions
    new_funcs = [
        ('test_all_public_urls', 'Test All Deployed Public URLs', 'kpi_update',
         'Fetch and SLA-verify all 10 Page app modules and public routing over the live internet.',
         'node scripts/test_all_public_urls.js',
         'All public Pages subdomains return HTTP 200 and load within limit.',
         'kpi_results'),

        ('test_all_api_endpoints_real', 'Test All API Endpoints Real', 'api_test',
         'Make real public fetch requests to the 13 deployed Cloudflare Worker gateway subdomains without local emulation.',
         'node scripts/test_all_api_endpoints_real.js',
         'All 13 Worker API subdomains return valid JSON edge health headers.',
         'kpi_results'),

        ('test_seeded_role_login', 'Test Seeded Role Logins', 'api_test',
         'Perform live credential login checks on the auth_api edge worker for all 17 seeded role accounts.',
         'node scripts/test_seeded_role_login.js',
         'All 17 seeded role logins successfully authorize and return security tokens.',
         'kpi_results'),

        ('test_role_access_matrix', 'Test Role Access Matrix Permissions', 'agent_fix',
         'Validate permission boundaries and security blocks on restricted dashboard routes across active user roles.',
         'python scripts/test_role_access_matrix.py',
         'Security access blocks return appropriate 403 or redirect codes for non-cleared roles.',
         'kpi_results'),

        ('test_screen_endpoint_mapping', 'Test Screen Endpoint Mappings', 'db_update',
         'Verify that the database views confirm exactly 0 unmapped or mismatching screen API endpoint references.',
         'python scripts/test_screen_endpoint_mapping.py',
         'v_screen_endpoint_readiness has exactly 0 unready mapping rows.',
         'kpi_results'),

        ('test_backend_only_apis', 'Test Backend-Only APIs', 'db_update',
         'Audit the 245 backend-only APIs, asserting that none are used in public screens and all have valid test cases.',
         'python scripts/test_backend_only_apis.py',
         '0 backend-only APIs are leaked to screens, and all have registered test cases.',
         'kpi_results'),

        ('test_crud_persistence', 'Test CRUD Persistence & Integrity', 'agent_fix',
         'Verify double-entry persistence, transaction registries, and foreign key constraints on the database.',
         'python scripts/test_crud_persistence.py',
         'SQLite tables assert perfect transactional consistency and foreign key compliance.',
         'kpi_results'),

        ('test_kpi_performance', 'Test KPI Screen Performance SLAs', 'kpi_update',
         'Verify that all 541 platform visual screens are verified and meet load time and rendering SLAs.',
         'python scripts/test_kpi_performance.py',
         '0 screens are marked slow, and load/render times align with high performance metrics.',
         'kpi_results'),

        ('test_release_readiness', 'Test Release Readiness', 'report_generate',
         'Compute overall quality, security, and performance index scores to certify the platform is ready for production.',
         'python scripts/test_release_readiness.py',
         'Compliance indexes are fully populated and overall health matches production release metrics.',
         'kpi_results'),

        ('generate_html_governance_report', 'Generate Visual HTML Governance Report', 'report_generate',
         'Compile visual dashboards, metrics tables, and logs into a high-fidelity visual HTML report.',
         'python scripts/kpi_db_updater.py',
         'visual HTML report successfully generated at reports/governance/primecare_governance_kpi_dashboard.html.',
         'governance_reports')
    ]

    # Deleting old redundant functions if they overlap to keep table clean
    cursor.execute("""
        DELETE FROM governance_functions 
        WHERE function_code IN ('test_public_urls', 'test_api_endpoints');
    """)

    # Seed the 10 new functions (using INSERT OR REPLACE or ON CONFLICT)
    for code, name, ftype, purpose, cmd, success, target_table in new_funcs:
        cursor.execute("""
            INSERT INTO governance_functions 
            (function_code, function_name, function_type, purpose_text, run_command, success_condition_text, stores_result_in_table, app_id, last_run_status)
            VALUES (?, ?, ?, ?, ?, ?, ?, 1, 'not_run')
            ON CONFLICT(function_code) DO UPDATE SET
                function_name=excluded.function_name,
                function_type=excluded.function_type,
                purpose_text=excluded.purpose_text,
                run_command=excluded.run_command,
                success_condition_text=excluded.success_condition_text,
                stores_result_in_table=excluded.stores_result_in_table,
                last_run_status='not_run';
        """, (code, name, ftype, purpose, cmd, success, target_table))

    # Also reset the run state of other existing functions so everything sweeps fresh
    cursor.execute("UPDATE governance_functions SET last_run_status = 'not_run';")
    
    conn.commit()
    conn.close()
    print("SUCCESS: Stage 12 functions registered and seeded in 'governance_functions' table!")

if __name__ == '__main__':
    main()
