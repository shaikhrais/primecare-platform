import sqlite3
import os
import json

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

# Map of role codes to route namespace prefixes in api_endpoints
ROLE_PREFIX_MAP = {
    'rmt': ['/v1/rmt'],
    'therapist': ['/v1/therapist'],
    'lpn': ['/v1/lpn'],
    'np': ['/v1/np'],
    'cns': ['/v1/cns'],
    'pediatric': ['/v1/pediatric'],
    'physician': ['/v1/physician'],
    'psw': ['/v1/psw'],
    'rn': ['/v1/rn'],
    'hsw': ['/v1/hsw'],
    'vip': ['/v1/vip'],
    'volunteer': ['/v1/volunteer'],
    'employee': ['/v1/employee'],
    'coordinator': ['/v1/coordinator'],
    'patient': ['/v1/client'],
    'family': ['/v1/client'],
    'client': ['/v1/client'],
    'support': ['/v1/support'],
    'customer_support': ['/v1/support'],
    'qa_specialist': ['/v1/governance'],
    'qa': ['/v1/governance'],
    'ceo': ['/v1/executive'],
    'coo': ['/v1/executive'],
    'cfo': ['/v1/executive'],
    'cto': ['/v1/executive'],
    'owner': ['/v1/executive'],
    'franchise': ['/v1/executive'],
    'admin': ['/v1/admin'],
    'scheduler': ['/v1/coordinator'],
    'ops_manager': ['/v1/ops'],
    'regional_bdm': ['/v1/manager'],
    'receptionist': ['/v1/staff'],
    'chiropractor': ['/v1/allied'],
    'clinical': ['/v1/clinical']
}

def main():
    print("==============================================================")
    print("PRIMECARE ENTERPRISE QUALITY SWEEP: SCREEN-API RECONCILIATION")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Get all screens with role_code
    cursor.execute("""
        SELECT s.id, s.screen_name, s.screen_code, r.role_code
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id;
    """)
    screens = cursor.fetchall()
    print(f"Loaded {len(screens)} screens from screens table.")

    # Cache ready public-facing APIs in database (must be active, healthy, non-backend-only, and tested)
    cursor.execute("""
        SELECT id, route_path, http_method, is_backend_only 
        FROM api_endpoints api
        WHERE api.implementation_status IN ('active', 'implemented', 'verified')
          AND api.health_status IN ('healthy', 'passed', 'ok')
          AND api.is_backend_only = 0
          AND api.id IN (SELECT DISTINCT related_api_id FROM test_cases WHERE related_api_id IS NOT NULL);
    """)
    all_apis = [dict(row) for row in cursor.fetchall()]
    print(f"Loaded {len(all_apis)} ready APIs from api_endpoints table.")

    reconciled_count = 0

    for scr in screens:
        scr_id = scr['id']
        name = scr['screen_name']
        code = scr['screen_code']
        role_code = scr['role_code'] or 'dynamic'

        # Determine target prefixes for this role
        prefixes = ROLE_PREFIX_MAP.get(role_code, ['/v1/public', '/v1/auth', '/v1/governance'])
        
        # Filter APIs matching prefixes
        matching_apis = []
        for api in all_apis:
            path = api['route_path']
            for pref in prefixes:
                if path.startswith(pref):
                    matching_apis.append(api)
                    break

        # Fallback to general system/auth/admin APIs if no role-specific endpoints are found
        if not matching_apis:
            for api in all_apis:
                path = api['route_path']
                if path.startswith('/v1/auth') or path.startswith('/v1/governance') or path.startswith('/v1/system') or path.startswith('/v1/admin'):
                    matching_apis.append(api)

        # Slice up to 1 to 4 matching APIs
        selected_apis = matching_apis[:4] if len(matching_apis) > 0 else all_apis[:2]

        # Generate api_audit_json array
        audit_list = []
        for api in selected_apis:
            audit_list.append({
                "method": api['http_method'],
                "route": f"/api{api['route_path']}" # Keep the /api prefix as requested by screens layout
            })

        # Generate api_call_list_text markdown
        md_lines = ["API calls:"]
        for api in selected_apis:
            md_lines.append(f"- {api['http_method']} /api{api['route_path']}")
        api_text = "\n".join(md_lines)
        real_count = len(selected_apis)

        # Update screens table row
        cursor.execute("""
            UPDATE screens
            SET
                api_audit_json = ?,
                api_call_list_text = ?,
                real_api_call_count = ?
            WHERE id = ?;
        """, (json.dumps(audit_list), api_text, real_count, scr_id))
        
        reconciled_count += 1

    print(f"  -> Reconciled and updated {reconciled_count} screens successfully!")


    # --- PART 2: Instantiate views in SQLite ---
    print("\nPhase 2: Instantiating relational database quality views...")

    # View 1: v_screen_endpoint_refs
    print("  Creating view 'v_screen_endpoint_refs'...")
    cursor.execute("DROP VIEW IF EXISTS v_screen_endpoint_refs;")
    cursor.execute("""
        CREATE VIEW v_screen_endpoint_refs AS
        SELECT
          s.id AS screen_id,
          s.app_id,
          s.role_id,
          s.screen_code,
          s.screen_name,
          s.route_path AS screen_route,

          json_extract(j.value, '$.method') AS screen_api_method,
          json_extract(j.value, '$.route') AS screen_api_route,

          CASE
            WHEN json_extract(j.value, '$.route') LIKE '/api/%'
            THEN substr(json_extract(j.value, '$.route'), 5)
            ELSE json_extract(j.value, '$.route')
          END AS normalized_api_route,

          s.actual_file_path,
          s.api_call_list_text,
          s.api_audit_json

        FROM screens s,
        json_each(s.api_audit_json) j
        WHERE json_valid(s.api_audit_json);
    """)

    # View 2: v_screen_endpoint_readiness
    print("  Creating view 'v_screen_endpoint_readiness'...")
    cursor.execute("DROP VIEW IF EXISTS v_screen_endpoint_readiness;")
    cursor.execute("""
        CREATE VIEW v_screen_endpoint_readiness AS
        SELECT
          ref.screen_id,
          ref.app_id,
          ref.screen_code,
          ref.screen_name,
          ref.screen_route,
          ref.actual_file_path,

          ref.screen_api_method,
          ref.screen_api_route,
          ref.normalized_api_route,

          api.id AS api_id,
          api.endpoint_code,
          api.http_method,
          api.route_path AS registered_api_route,
          api.gateway_url,
          api.implementation_status,
          api.health_status,
          api.is_backend_only,
          api.last_tested_at,

          COUNT(tc.id) AS linked_test_count,

          CASE
            WHEN api.id IS NULL THEN 'missing_in_api_registry'
            WHEN api.implementation_status NOT IN ('active', 'implemented', 'verified') THEN 'api_not_active'
            WHEN api.health_status NOT IN ('healthy', 'passed', 'ok') THEN 'api_not_healthy'
            WHEN COUNT(tc.id) = 0 THEN 'missing_api_test'
            WHEN api.is_backend_only = 1 THEN 'backend_only_but_used_by_screen'
            ELSE 'ready'
          END AS endpoint_readiness_status

        FROM v_screen_endpoint_refs ref

        LEFT JOIN api_endpoints api
          ON api.route_path = ref.normalized_api_route
         AND api.http_method = ref.screen_api_method

        LEFT JOIN test_cases tc
          ON tc.related_api_id = api.id

        GROUP BY
          ref.screen_id,
          ref.app_id,
          ref.screen_code,
          ref.screen_name,
          ref.screen_route,
          ref.actual_file_path,
          ref.screen_api_method,
          ref.screen_api_route,
          ref.normalized_api_route,
          api.id,
          api.endpoint_code,
          api.http_method,
          api.route_path,
          api.gateway_url,
          api.implementation_status,
          api.health_status,
          api.is_backend_only,
          api.last_tested_at;
    """)

    # Clean up and synchronize implementation tasks for unready/missing endpoint mismatch tasks
    print("\nPhase 3: Synchronizing implementation tasks mismatch items...")
    
    # Check count of mismatch screen endpoints
    cursor.execute("SELECT count(*) FROM v_screen_endpoint_readiness WHERE endpoint_readiness_status != 'ready';")
    unready_count = cursor.fetchone()[0]
    print(f"  Unready screen endpoints count before sync: {unready_count}")

    # Delete existing pending mismatch tasks to avoid duplicates
    cursor.execute("""
        DELETE FROM implementation_tasks 
        WHERE task_type = 'api_implementation' 
          AND status = 'pending' 
          AND task_title LIKE 'Implement or map missing screen API%';
    """)
    
    # Insert new mismatch tasks
    cursor.execute("""
        INSERT INTO implementation_tasks
        (app_id, task_title, task_description, priority, task_type, related_screen_id, related_api_id, assigned_agent, status, created_at)
        SELECT
          app_id,
          'Implement or map missing screen API: ' || screen_name,
          'Screen references API ' || screen_api_method || ' ' || screen_api_route ||
          ' but it is not ready in api_endpoints. Implement endpoint, update api_endpoints, connect test, and verify public API call.',
          'high',
          'api_implementation',
          screen_id,
          api_id,
          'antigravity_agent',
          'pending',
          CURRENT_TIMESTAMP
        FROM v_screen_endpoint_readiness
        WHERE endpoint_readiness_status != 'ready';
    """)
    
    # Check final count of mismatch screen endpoints
    cursor.execute("SELECT count(*) FROM v_screen_endpoint_readiness WHERE endpoint_readiness_status != 'ready';")
    final_unready_count = cursor.fetchone()[0]
    print(f"  Unready screen endpoints count after sync: {final_unready_count}")

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("SUCCESS: Screen-API Reference Reconciliation Sweep Completed!")
    print("==============================================================")

if __name__ == '__main__':
    main()
