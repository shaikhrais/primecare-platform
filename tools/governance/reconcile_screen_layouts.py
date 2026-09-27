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

def clean_menu_label(name: str) -> str:
    """Removes standard prefixes/suffixes to create a neat menu label."""
    label = name.replace("Screen", "").replace("Platform", "").replace("Sys", "")
    # Add spaces between camelCase words
    import re
    label = re.sub(r'(?<!^)(?=[A-Z])', ' ', label)
    return label.strip()

def get_fallback_icon(name: str) -> str:
    name_lower = name.lower()
    if "dashboard" in name_lower or "stats" in name_lower or "overview" in name_lower:
        return "dashboard"
    elif "list" in name_lower or "roster" in name_lower or "history" in name_lower or "queue" in name_lower:
        return "assignment"
    elif "profile" in name_lower or "client" in name_lower or "patient" in name_lower or "user" in name_lower:
        return "person"
    elif "chat" in name_lower or "message" in name_lower:
        return "chat"
    elif "setting" in name_lower or "config" in name_lower:
        return "settings"
    elif "workflow" in name_lower or "flow" in name_lower or "step" in name_lower:
        return "trending_up"
    elif "document" in name_lower or "note" in name_lower or "report" in name_lower:
        return "description"
    return "menu"

def get_or_create_run_context(cur, function_code, run_command):
    # Find function
    fn_row = cur.execute("SELECT id FROM governance_functions WHERE function_code = ?;", (function_code,)).fetchone()
    if fn_row:
        function_id = fn_row["id"]
    else:
        cur.execute("""
            INSERT INTO governance_functions (function_code, function_name, function_type, run_command, run_order)
            VALUES (?, ?, 'temp', ?, 999);
        """, (function_code, function_code, run_command))
        function_id = cur.lastrowid
        
    # Check for active run
    run_row = cur.execute("""
        SELECT id FROM governance_function_runs
        WHERE function_id = ? AND run_status = 'started'
        ORDER BY id DESC LIMIT 1;
    """, (function_id,)).fetchone()
    
    if run_row:
        run_id = run_row["id"]
    else:
        cur.execute("""
            INSERT INTO governance_function_runs (function_id, run_status, command_run, started_at)
            VALUES (?, 'started', ?, ?);
        """, (function_id, run_command, datetime.utcnow().isoformat()))
        run_id = cur.lastrowid
        
    return run_id, function_id

def main():
    print("Executing: Reconcile Screen Content Layouts...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Get orchestrator context
    run_id, function_id = get_or_create_run_context(cur, "reconcile_screen_layouts", "python tools/governance/reconcile_screen_layouts.py")

    # Fetch all screens
    screens = cur.execute("""
        SELECT s.id, s.screen_name, s.screen_type, s.route_path, s.data_load_strategy, a.app_code
        FROM screens s
        LEFT JOIN apps a ON s.app_id = a.id;
    """).fetchall()
    print(f"Reconciling visual layouts for {len(screens)} screens...")

    if function_id:
        cur.execute("DELETE FROM governance_function_results WHERE function_id = ?;", (function_id,))
        conn.commit()

    screen_reports = []

    for s in screens:
        scr_id = s["id"]
        name = s["screen_name"]
        stype = s["screen_type"].lower() if s["screen_type"] else ''
        route = s["route_path"]
        strategy = s["data_load_strategy"]
        app_code = s["app_code"] or "auth"

        # 1. Determine content layout type
        layout_type = "standard_scaffold_layout"
        if stype in ("dashboard", "analytics"):
            layout_type = "dashboard_grid_layout"
        elif stype in ("form", "crud"):
            layout_type = "scrollable_form_layout"
        elif stype in ("list", "queue"):
            layout_type = "paginated_table_layout"
        elif stype in ("detail", "documents"):
            layout_type = "split_profile_detail_layout"
        elif stype in ("workflow", "compliance"):
            layout_type = "stepped_workflow_layout"

        # 2. Sidebar/topbar requirements
        req_sidebar = 1
        req_topbar = 1
        
        # Hide topbar/sidebar for landing/auth screens or fullscreens
        route_lower = route.lower()
        if any(keyword in route_lower for keyword in ("login", "auth", "splash", "callback", "landing")):
            req_sidebar = 0
            req_topbar = 0

        parent_layout = f"{app_code.lower()}_shell_layout"

        # 3. Label, Icon, Order
        menu_label = clean_menu_label(name)
        menu_icon = get_fallback_icon(name)
        menu_order = 10 + ((scr_id * 5) % 90)

        # 4. Hide detail or transaction pages in sidebar
        show_sidebar = 1
        if strategy in ("crud_mutation", "detail_fetch") or "create" in route_lower or "edit" in route_lower or "delete" in route_lower:
            show_sidebar = 0

        # Update screens table
        cur.execute("""
            UPDATE screens
            SET content_layout_type = ?,
                requires_sidebar = ?,
                requires_topbar = ?,
                parent_layout_key = ?,
                menu_label = ?,
                menu_icon = ?,
                menu_order = ?,
                show_in_sidebar = ?
            WHERE id = ?;
        """, (
            layout_type,
            req_sidebar,
            req_topbar,
            parent_layout,
            menu_label,
            menu_icon,
            menu_order,
            show_sidebar,
            scr_id
        ))

        # Log row-level findings in governance_function_results
        before_state = {"content_layout_type": None, "requires_sidebar": 1}
        after_state = {
            "content_layout_type": layout_type,
            "requires_sidebar": req_sidebar,
            "requires_topbar": req_topbar,
            "menu_label": menu_label,
            "menu_icon": menu_icon,
            "show_in_sidebar": show_sidebar
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
            f"Screen layout reconciled. Layout: '{layout_type}', Menu: '{menu_label}' ({menu_icon}).",
            json.dumps(before_state),
            json.dumps(after_state),
            now()
        ))

        screen_reports.append({
            "screen_id": scr_id,
            "screen_name": name,
            "content_layout_type": layout_type,
            "requires_sidebar": req_sidebar,
            "requires_topbar": req_topbar,
            "parent_layout_key": parent_layout,
            "menu_label": menu_label,
            "menu_icon": menu_icon,
            "menu_order": menu_order,
            "show_in_sidebar": show_sidebar
        })

    conn.commit()

    # Save proof JSON
    with open(os.path.join(REPORT_DIR, "screen_layouts_report.json"), "w", encoding="utf-8") as f:
        json.dump(screen_reports, f, indent=2)

    conn.close()
    print(f"[SUCCESS] Reconciled screen layouts for {len(screens)} screens. Saved proof to reports/screen_layouts_report.json")

if __name__ == "__main__":
    main()
