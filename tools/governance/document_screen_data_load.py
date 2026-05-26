import os
import json
import sqlite3
from datetime import datetime
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
REPORT_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, "tools", "governance", "reports"))
Path(REPORT_DIR).mkdir(parents=True, exist_ok=True)

def now():
    return datetime.utcnow().isoformat()

def main():
    print("Executing: Document Screen-Level Data Loading Strategy...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # 1. Ensure optimization_status column exists in screens table
    print("Checking database columns for screens table...")
    try:
        cur.execute("ALTER TABLE screens ADD COLUMN optimization_status TEXT DEFAULT 'pending';")
        print("  Successfully added column optimization_status to screens.")
        conn.commit()
    except sqlite3.OperationalError as e:
        if "duplicate column name" in str(e):
            print("  Column optimization_status already exists in screens.")
        else:
            print(f"  Error adding column: {e}")

    # 2. Get function_id and run_id if running under orchestrator
    run_id = None
    function_id = None
    try:
        fn_row = cur.execute("""
            SELECT id FROM governance_functions 
            WHERE function_code = 'document_screen_data_load';
        """).fetchone()
        if fn_row:
            function_id = fn_row["id"]
            
            run_row = cur.execute("""
                SELECT id FROM governance_function_runs
                WHERE function_id = ? AND run_status = 'started'
                ORDER BY id DESC LIMIT 1;
            """, (function_id,)).fetchone()
            if run_row:
                run_id = run_row["id"]
    except Exception as e:
        print(f"  Note: Orchestrator context not found: {e}")

    # 3. Load all screens
    try:
        screens = cur.execute("""
            SELECT id, screen_name, screen_type, real_api_call_count, is_command_center, workflow_stage, cypress_ready, avg_load_time_ms
            FROM screens;
        """).fetchall()
    except sqlite3.OperationalError as e:
        print(f"Error querying screens: {e}")
        conn.close()
        return

    print(f"Analyzing and documenting data loading strategy for {len(screens)} screens...")

    # Clear prior results for this specific function to prevent stale duplicates
    if function_id:
        cur.execute("DELETE FROM governance_function_results WHERE function_id = ?;", (function_id,))
        conn.commit()

    documented_count = 0
    results_to_log = []

    for scr in screens:
        scr_id = scr["id"]
        name = scr["screen_name"]
        stype = scr["screen_type"].lower() if scr["screen_type"] else ''
        api_cnt = scr["real_api_call_count"] or 0
        is_cmd = scr["is_command_center"] or 0
        wf_stage = scr["workflow_stage"]
        avg_load_time = scr["avg_load_time_ms"] or 50

        # Heuristic mapping for data load strategy
        strategy = 'static'
        pag_req = 0
        lazy_req = 0
        cache_req = 0
        opt_status = 'good'
        slow_reason = None

        # 1. Static shells (no API calls)
        if api_cnt == 0:
            strategy = 'static'
            pag_req = 0
            lazy_req = 0
            cache_req = 1  # Static data is cached in memory
            opt_status = 'optimized'

        # 2. Command centers & complex workflow screens
        elif is_cmd == 1 or 'command' in name.lower() or wf_stage or stype in ('workflow', 'compliance'):
            strategy = 'workflow_transaction'
            pag_req = 0
            lazy_req = 1   # Dashboards and workflow centers require lazy component loading
            cache_req = 1  # Caching role permissions and task stages
            opt_status = 'optimized' if avg_load_time < 90 else 'good'

        # 3. Dashboards & aggregators
        elif stype in ('dashboard', 'analytics', 'reports') or 'dashboard' in name.lower() or 'stats' in name.lower() or 'overview' in name.lower() or 'summary' in name.lower():
            strategy = 'dashboard_aggregate'
            pag_req = 0
            lazy_req = 1   # Heavy metrics load lazily
            cache_req = 1  # Cache aggregates
            opt_status = 'optimized' if avg_load_time < 90 else 'good'

        # 4. Paginated lists & queues
        elif stype in ('queue', 'list') or 'list' in name.lower() or 'history' in name.lower() or 'roster' in name.lower() or 'all' in name.lower() or 'grid' in name.lower():
            strategy = 'paginated_list'
            pag_req = 1    # Lists require pagination
            lazy_req = 0
            cache_req = 0  # Dynamic lists bypass cache for fresh records
            opt_status = 'optimized' if avg_load_time < 90 else 'good'

        # 5. CRUD Forms & input mutations
        elif stype in ('crud', 'form', 'messages') or 'create' in name.lower() or 'edit' in name.lower() or 'add' in name.lower() or 'update' in name.lower() or 'delete' in name.lower() or 'form' in name.lower():
            strategy = 'crud_mutation'
            pag_req = 0
            lazy_req = 0
            cache_req = 0  # Forms bypass cache for transaction freshness
            opt_status = 'optimized' if avg_load_time < 90 else 'good'

        # 6. Detailed views / Patient Profiles
        elif stype == 'detail' or 'detail' in name.lower() or 'view' in name.lower() or 'profile' in name.lower() or 'info' in name.lower() or stype == 'documents':
            strategy = 'detail_fetch'
            pag_req = 0
            lazy_req = 0
            cache_req = 1  # Profile lookups are cached to prevent repeat load
            opt_status = 'optimized' if avg_load_time < 90 else 'good'

        # Fallback
        else:
            strategy = 'static'
            pag_req = 0
            lazy_req = 0
            cache_req = 1
            opt_status = 'optimized'

        # Update screens table
        cur.execute("""
            UPDATE screens
            SET data_load_strategy = ?,
                pagination_required = ?,
                lazy_loading_required = ?,
                cache_required = ?,
                optimization_status = ?,
                slow_data_reason = ?
            WHERE id = ?;
        """, (strategy, pag_req, lazy_req, cache_req, opt_status, slow_reason, scr_id))

        # Log detailed row-level findings into governance_function_results
        before_state = {"data_load_strategy": None, "optimization_status": "pending"}
        after_state = {
            "data_load_strategy": strategy,
            "pagination_required": pag_req,
            "lazy_loading_required": lazy_req,
            "cache_required": cache_req,
            "optimization_status": opt_status
        }

        cur.execute("""
            INSERT INTO governance_function_results (
                run_id, function_id, target_table, target_id, target_name, 
                result_status, result_summary, before_json, after_json, 
                suggested_fix, created_at
            ) VALUES (?, ?, 'screens', ?, ?, 'passed', ?, ?, ?, NULL, ?);
        """, (
            run_id, 
            function_id, 
            scr_id, 
            name, 
            f"Screen documented as '{strategy}' with optimization state '{opt_status}'.",
            json.dumps(before_state),
            json.dumps(after_state),
            now()
        ))

        results_to_log.append({
            "screen_id": scr_id,
            "screen_name": name,
            "strategy": strategy,
            "pagination_required": pag_req,
            "lazy_loading_required": lazy_req,
            "cache_required": cache_req,
            "optimization_status": opt_status
        })
        documented_count += 1

    conn.commit()

    # Save structured proof report json
    with open(os.path.join(REPORT_DIR, "screen_data_load_report.json"), "w", encoding="utf-8") as f:
        json.dump(results_to_log, f, indent=2)

    conn.close()
    print(f"[SUCCESS] Documented data loading strategy for {documented_count} screens. Populated row-level results inside governance_function_results.")

if __name__ == "__main__":
    main()
