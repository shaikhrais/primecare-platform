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
    print("Executing: Configure Application Shells & Branding...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Get orchestrator context
    run_id, function_id = get_or_create_run_context(cur, "configure_app_shells", "python tools/governance/configure_app_shells.py")

    # Fetch all apps
    apps = cur.execute("SELECT id, app_code, app_name FROM apps;").fetchall()
    print(f"Configuring branding and shells for {len(apps)} apps...")

    if function_id:
        cur.execute("DELETE FROM governance_function_results WHERE function_id = ?;", (function_id,))
        conn.commit()

    app_reports = []

    # Premium theme configurations per app category
    THEME_PALETTES = {
        "auth": {"primary": "#0369a1", "secondary": "#0284c7", "theme": "sky_modern"},
        "governance": {"primary": "#4f46e5", "secondary": "#6366f1", "theme": "indigo_sleek"},
        "corporate": {"primary": "#0f172a", "secondary": "#334155", "theme": "slate_premium"},
        "franchise": {"primary": "#1e3a8a", "secondary": "#3b82f6", "theme": "royal_blue"},
        "clinic": {"primary": "#0d9488", "secondary": "#14b8a6", "theme": "teal_clinical"},
        "client": {"primary": "#059669", "secondary": "#10b981", "theme": "emerald_care"},
        "business": {"primary": "#7c3aed", "secondary": "#8b5cf6", "theme": "violet_growth"},
        "marketing": {"primary": "#db2777", "secondary": "#ec4899", "theme": "pink_vibrant"},
        "support": {"primary": "#b45309", "secondary": "#d97706", "theme": "amber_warning"},
        "enterprise": {"primary": "#2563eb", "secondary": "#3b82f6", "theme": "azure_corporate"}
    }

    for app in apps:
        app_id = app["id"]
        code = app["app_code"]
        name = app["app_name"]

        code_lower = code.lower()

        # 1. Determine shell type
        shell_type = "web"
        if "clinic" in code_lower or "admin" in code_lower or "governance" in code_lower:
            shell_type = "admin"
        elif "mobile" in code_lower or "caregiver" in code_lower or "client" in code_lower:
            # Let's say client is web, but some mobile portals can exist. We fallback to "web" or "mobile" based on heuristics.
            shell_type = "mobile" if "mobile" in code_lower else "web"

        layout_key = f"{code_lower}_shell_layout"

        # 2. Determine HSL curated colors and logo configs
        palette = THEME_PALETTES.get("enterprise")
        for key, p in THEME_PALETTES.items():
            if key in code_lower:
                palette = p
                break

        theme_config = {
            "themeMode": "dark" if "governance" in code_lower or "corporate" in code_lower else "light",
            "primaryColor": palette["primary"],
            "secondaryColor": palette["secondary"],
            "fontFamily": "Segoe UI",
            "borderRadius": 8,
            "themeName": palette["theme"]
        }

        branding = {
            "appName": name,
            "logoUrl": f"/assets/branding/{code_lower}_logo.svg",
            "faviconUrl": f"/assets/branding/{code_lower}_favicon.ico",
            "companyName": "PrimeCare Platform Inc.",
            "copyrightYear": 2026
        }

        # 3. Update SQLite apps table
        cur.execute("""
            UPDATE apps
            SET default_layout_key = ?,
                app_shell_type = ?,
                theme_config_json = ?,
                branding_json = ?
            WHERE id = ?;
        """, (
            layout_key,
            shell_type,
            json.dumps(theme_config),
            json.dumps(branding),
            app_id
        ))

        # Log row-level findings in governance_function_results
        before_state = {"theme_config_json": None, "branding_json": None}
        after_state = {
            "default_layout_key": layout_key,
            "app_shell_type": shell_type,
            "theme_name": palette["theme"],
            "primary_color": palette["primary"]
        }
        cur.execute("""
            INSERT INTO governance_function_results (
                run_id, function_id, target_table, target_id, target_name, 
                result_status, result_summary, before_json, after_json, 
                suggested_fix, created_at
            ) VALUES (?, ?, 'apps', ?, ?, 'passed', ?, ?, ?, NULL, ?);
        """, (
            run_id,
            function_id,
            app_id,
            code,
            f"App shell and brand configured for '{name}'. Primary: '{palette['primary']}', Shell: '{shell_type}'.",
            json.dumps(before_state),
            json.dumps(after_state),
            now()
        ))

        app_reports.append({
            "app_id": app_id,
            "app_code": code,
            "app_name": name,
            "default_layout_key": layout_key,
            "app_shell_type": shell_type,
            "theme_config": theme_config,
            "branding": branding
        })

    conn.commit()

    # Save proof JSON
    with open(os.path.join(REPORT_DIR, "app_shells_report.json"), "w", encoding="utf-8") as f:
        json.dump(app_reports, f, indent=2)

    conn.close()
    print(f"[SUCCESS] Configured shells and branding for {len(apps)} apps. Saved proof to reports/app_shells_report.json")

if __name__ == "__main__":
    main()
