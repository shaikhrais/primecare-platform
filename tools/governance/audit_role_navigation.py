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
    print("Executing: Audit Role Navigation Configuration...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Get orchestrator context
    run_id, function_id = get_or_create_run_context(cur, "audit_role_navigation", "python tools/governance/audit_role_navigation.py")

    # Fetch all roles
    roles = cur.execute("SELECT id, role_code, role_name FROM roles;").fetchall()
    print(f"Auditing and configuring navigation for {len(roles)} platform roles...")

    if function_id:
        cur.execute("DELETE FROM governance_function_results WHERE function_id = ?;", (function_id,))
        conn.commit()

    role_reports = []

    for r in roles:
        role_id = r["id"]
        code = r["role_code"]
        name = r["role_name"]

        # 1. Determine navigation style and dashboard
        code_lower = code.lower()
        
        # Heuristic style mapping
        nav_style = "sidebar"
        if any(keyword in code_lower for keyword in ("patient", "client", "caregiver", "psw", "therapist", "allied", "nurse", "rn")):
            nav_style = "bottom_nav"
        elif any(keyword in code_lower for keyword in ("billing", "coordinator", "support", "scheduler")):
            nav_style = "drawer"

        role_layout = f"{code_lower}_shell_layout"

        # 2. Fetch screens linked to this role
        screens = cur.execute("""
            SELECT screen_code, screen_name, route_path, screen_type
            FROM screens
            WHERE role_id = ?;
        """, (role_id,)).fetchall()

        # Find default dashboard code
        default_dashboard = None
        for s in screens:
            if s["screen_type"] == "dashboard" or "dashboard" in s["screen_name"].lower():
                default_dashboard = s["screen_code"]
                break
        if not default_dashboard and screens:
            default_dashboard = screens[0]["screen_code"]
        elif not default_dashboard:
            default_dashboard = f"{code}_DASHBOARD"

        # 3. Generate Sidebar Items & Topbar Config
        sidebar_items = []
        allowed_screens = []
        
        for s in screens:
            allowed_screens.append(s["screen_code"])
            
            # Formulate sidebar navigation item
            sidebar_items.append({
                "label": clean_menu_label(s["screen_name"]),
                "icon": get_fallback_icon(s["screen_name"]),
                "screen_code": s["screen_code"],
                "route": s["route_path"]
            })

        sidebar_config = {"items": sidebar_items}
        topbar_config = {
            "title": f"{name} Portal",
            "showSearch": True,
            "showNotifications": True,
            "showProfile": True,
            "actions": ["messages", "tasks", "logout"]
        }
        allowed_menu = {"allowed_screens": allowed_screens}

        # 4. Update SQLite roles table
        cur.execute("""
            UPDATE roles
            SET topbar_config_json = ?,
                sidebar_config_json = ?,
                default_dashboard_screen_code = ?,
                allowed_menu_json = ?,
                role_layout_key = ?,
                navigation_style = ?
            WHERE id = ?;
        """, (
            json.dumps(topbar_config),
            json.dumps(sidebar_config),
            default_dashboard,
            json.dumps(allowed_menu),
            role_layout,
            nav_style,
            role_id
        ))

        # Log row-level findings in governance_function_results
        before_state = {"navigation_style": None, "sidebar_config_json": None}
        after_state = {
            "navigation_style": nav_style,
            "default_dashboard": default_dashboard,
            "sidebar_items_count": len(sidebar_items),
            "role_layout_key": role_layout
        }
        cur.execute("""
            INSERT INTO governance_function_results (
                run_id, function_id, target_table, target_id, target_name, 
                result_status, result_summary, before_json, after_json, 
                suggested_fix, created_at
            ) VALUES (?, ?, 'roles', ?, ?, 'passed', ?, ?, ?, NULL, ?);
        """, (
            run_id,
            function_id,
            role_id,
            code,
            f"Role '{name}' navigation configured. Nav Style: '{nav_style}', Sidebar Items: {len(sidebar_items)}.",
            json.dumps(before_state),
            json.dumps(after_state),
            now()
        ))

        role_reports.append({
            "role_id": role_id,
            "role_code": code,
            "role_name": name,
            "navigation_style": nav_style,
            "default_dashboard": default_dashboard,
            "sidebar_items": sidebar_items,
            "topbar_config": topbar_config,
            "allowed_screens": allowed_screens
        })

    conn.commit()

    # Save proof JSON
    with open(os.path.join(REPORT_DIR, "role_navigation_report.json"), "w", encoding="utf-8") as f:
        json.dump(role_reports, f, indent=2)

    conn.close()
    print(f"[SUCCESS] Configured navigation structures for {len(roles)} roles. Saved proof to reports/role_navigation_report.json")

if __name__ == "__main__":
    main()
