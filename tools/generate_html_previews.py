import sqlite3
import os
import json

def main():
    db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
    out_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\html_screen_previews"
    
    if not os.path.exists(db_path):
        print(f"Error: Database not found at {db_path}")
        return
        
    os.makedirs(out_dir, exist_ok=True)
    os.makedirs(os.path.join(out_dir, "assets"), exist_ok=True)
    os.makedirs(os.path.join(out_dir, "roles"), exist_ok=True)
    os.makedirs(os.path.join(out_dir, "reports"), exist_ok=True)
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # helper query function
    def q(sql, args=()):
        try:
            cursor.execute(sql, args)
            return cursor.fetchall()
        except sqlite3.OperationalError as e:
            print(f"Query warning: {e} for SQL: {sql}")
            return []

    # 1. Fetch tables
    apps_raw = q("SELECT id, app_code, app_name FROM apps")
    roles_raw = q("SELECT id, role_code, role_name, role_type, test_email, test_password, primary_app_code FROM roles WHERE active=1")
    screens_raw = q("SELECT id, app_id, role_id, screen_code, screen_name, route_path, actual_file_path, stage, active FROM screens")
    role_screen_map_raw = q("SELECT id, role_id, screen_id, can_view, can_edit FROM role_screen_map")
    sidebar_raw = q("SELECT id, app_id, role_id, screen_id, sidebar_group, sidebar_label, sidebar_icon, route_path, display_order, visible, enabled FROM sidebar_items")
    topbar_raw = q("SELECT id, app_id, role_id, item_label, icon, action_type, display_order FROM topbar_items")
    app_shells_raw = q("SELECT id, shell_code, shell_name FROM app_shells")
    sections_raw = q("SELECT id, screen_id, section_code, section_name, section_type, section_order, purpose FROM screen_sections")
    elements_raw = q("SELECT id, section_id, screen_id, element_key, element_type, label, element_order, required, action_required, api_usage FROM screen_section_elements")
    features_raw = q("SELECT id, feature_code, feature_name, description FROM features")
    screen_features_raw = q("SELECT id, screen_id, feature_id, required, implementation_status FROM screen_feature_map")
    api_endpoints_raw = q("SELECT id, api_code, endpoint_path, method, request_schema_json, response_schema_json FROM api_registry")
    screen_api_raw = q("SELECT id, screen_id, api_id FROM screen_api_map")
    theme_profiles_raw = q("SELECT id, theme_name FROM theme_profiles")
    theme_tokens_raw = q("SELECT id, token_code, token_value, token_type FROM theme_design_tokens")
    
    # Resolve primecare UI components
    ui_components_raw = q("SELECT id, dart_class_name FROM primecare_ui_component_registry")
    ui_components = {item[0]: item[1] for item in ui_components_raw}
    element_component_raw = q("SELECT id, element_id, primecare_component_id FROM element_primecare_component_map")

    # Group data
    apps = {a[0]: {"code": a[1], "name": a[2]} for a in apps_raw}
    
    roles = {}
    for r in roles_raw:
        roles[r[0]] = {
            "id": r[0],
            "code": r[1],
            "name": r[2],
            "type": r[3],
            "email": r[4],
            "password": r[5],
            "app_code": r[6],
            "screens": []
        }
        
    screens = {}
    for s in screens_raw:
        screens[s[0]] = {
            "id": s[0],
            "app_id": s[1],
            "role_id": s[2],
            "code": s[3],
            "name": s[4],
            "route": s[5],
            "file": s[6],
            "stage": s[7],
            "active": s[8],
            "sections": [],
            "apis": [],
            "features": []
        }
        
    role_screen_map = []
    for rsm in role_screen_map_raw:
        role_screen_map.append({
            "id": rsm[0],
            "role_id": rsm[1],
            "screen_id": rsm[2],
            "can_view": rsm[3],
            "can_edit": rsm[4]
        })
        # Map screens to role
        if rsm[1] in roles and rsm[2] in screens:
            roles[rsm[1]]["screens"].append(rsm[2])
            
    sidebar_items_by_role = {}
    for s in sidebar_raw:
        role_id = s[2]
        sidebar_items_by_role.setdefault(role_id, []).append({
            "id": s[0],
            "app_id": s[1],
            "screen_id": s[3],
            "group": s[4],
            "label": s[5],
            "icon": s[6],
            "route": s[7],
            "order": s[8],
            "visible": s[9],
            "enabled": s[10]
        })
        
    topbar_items_by_role = {}
    for t in topbar_raw:
        role_id = t[2]
        topbar_items_by_role.setdefault(role_id, []).append({
            "id": t[0],
            "app_id": t[1],
            "label": t[3],
            "icon": t[4],
            "action_type": t[5],
            "order": t[6]
        })
        
    app_shells = {ash[0]: {"code": ash[1], "name": ash[2]} for ash in app_shells_raw}
    
    sections = {}
    for s in sections_raw:
        sections[s[0]] = {
            "id": s[0],
            "screen_id": s[1],
            "code": s[2],
            "name": s[3],
            "type": s[4],
            "order": s[5],
            "purpose": s[6],
            "elements": []
        }
        if s[1] in screens:
            screens[s[1]]["sections"].append(sections[s[0]])
            
    element_component = {ec[1]: ui_components.get(ec[2], None) for ec in element_component_raw}
    
    for e in elements_raw:
        sec_id = e[1]
        elem_id = e[0]
        el = {
            "id": elem_id,
            "key": e[3],
            "type": e[4],
            "label": e[5],
            "order": e[6],
            "required": e[7],
            "action_required": e[8],
            "api_usage": e[9],
            "primecare_component": element_component.get(elem_id, None)
        }
        if sec_id in sections:
            sections[sec_id]["elements"].append(el)
            
    features = {f[0]: {"code": f[1], "name": f[2], "desc": f[3]} for f in features_raw}
    
    for sf in screen_features_raw:
        screen_id = sf[1]
        feature_id = sf[2]
        if screen_id in screens and feature_id in features:
            screens[screen_id]["features"].append({
                "code": features[feature_id]["code"],
                "name": features[feature_id]["name"],
                "required": sf[3],
                "implementation_status": sf[4]
            })
            
    apis = {a[0]: {"code": a[1], "path": a[2], "method": a[3], "request": a[4], "response": a[5]} for a in api_endpoints_raw}
    
    for sa in screen_api_raw:
        screen_id = sa[1]
        api_id = sa[2]
        if screen_id in screens and api_id in apis:
            screens[screen_id]["apis"].append(apis[api_id])

    theme_profiles = {tp[0]: tp[1] for tp in theme_profiles_raw}
    theme_tokens = {}
    for tt in theme_tokens_raw:
        theme_tokens[tt[1]] = {"value": tt[2], "category": tt[3]}
        
    print(f"Loaded {len(roles)} roles, {len(screens)} screens, {len(sections)} sections, {len(apis)} apis.")

    # Write CSS file
    css_content = """
:root {
    --primary-color: #6366f1;
    --primary-glow: rgba(99, 102, 241, 0.15);
    --bg-dark: #090d16;
    --bg-surface: #101625;
    --border-color: rgba(255, 255, 255, 0.08);
    --text-main: #f8fafc;
    --text-muted: #64748b;
    --text-secondary: #94a3b8;
    --card-bg: rgba(255, 255, 255, 0.02);
    --card-hover: rgba(255, 255, 255, 0.05);
    --radius-lg: 0.75rem;
    --radius-md: 0.5rem;
    --spacing-lg: 2rem;
    --spacing-md: 1rem;
    --danger: #ef4444;
    --warning: #f59e0b;
    --success: #10b981;
}

body {
    font-family: 'Outfit', sans-serif;
    background-color: var(--bg-dark);
    color: var(--text-main);
    margin: 0;
}
    """
    for k, t in theme_tokens.items():
        css_content += f"\n/* DB Token: {k} */\n:root {{ --db-{k.replace('.', '-')}: {t['value']}; }}"
        
    with open(os.path.join(out_dir, "assets", "primecare_theme.css"), "w", encoding="utf-8") as f:
        f.write(css_content)

    # 2. Write preview_data.json
    preview_data = {
        "roles": [r for r in roles.values()],
        "apps": apps,
        "screens": [s for s in screens.values()],
        "role_screen_map": role_screen_map,
        "app_shells": app_shells,
        "theme_tokens": theme_tokens
    }
    with open(os.path.join(out_dir, "assets", "preview_data.json"), "w", encoding="utf-8") as f:
        json.dump(preview_data, f, indent=2)

    # 3. Create index.html (Main Role Selector Page)
    index_html = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrimeCare Role Navigator</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg-dark: #090d16;
            --surface: #101625;
            --accent: #6366f1;
            --accent-glow: rgba(99, 102, 241, 0.15);
            --border: rgba(255, 255, 255, 0.08);
            --text-main: #f8fafc;
            --text-sec: #94a3b8;
            --card-bg: rgba(255, 255, 255, 0.02);
            --card-hover: rgba(255, 255, 255, 0.05);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Outfit', sans-serif; background: var(--bg-dark); color: var(--text-main); padding: 3rem; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { display: flex; align-items: center; gap: 1rem; margin-bottom: 3rem; }
        .header i { font-size: 2.5rem; color: var(--accent); }
        .header h1 { font-size: 2.25rem; font-weight: 700; letter-spacing: -0.03em; }
        
        .stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 3rem; }
        .stat-card { background: var(--surface); border: 1px solid var(--border); padding: 1.5rem; border-radius: 0.75rem; }
        .stat-card .label { font-size: 0.85rem; color: var(--text-sec); text-transform: uppercase; letter-spacing: 0.05em; }
        .stat-card .val { font-size: 2.5rem; font-weight: 700; margin-top: 0.5rem; }
        
        .search-section { margin-bottom: 2rem; }
        .search-box { width: 100%; padding: 1rem 1.5rem; background: var(--surface); border: 1px solid var(--border); border-radius: 0.5rem; color: white; font-family: inherit; font-size: 1rem; outline: none; transition: border-color 0.2s; }
        .search-box:focus { border-color: var(--accent); }
        
        .roles-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1.5rem; }
        .role-card { background: var(--surface); border: 1px solid var(--border); border-radius: 0.75rem; padding: 1.5rem; transition: all 0.2s ease; cursor: pointer; text-decoration: none; color: inherit; display: flex; flex-direction: column; justify-content: space-between; }
        .role-card:hover { transform: translateY(-2px); border-color: var(--accent); background: var(--card-hover); }
        .role-card h3 { font-size: 1.2rem; font-weight: 600; margin-bottom: 0.5rem; }
        .role-card .meta { font-size: 0.75rem; color: var(--text-sec); margin-bottom: 1.5rem; text-transform: uppercase; }
        .role-card .footer { display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem; color: var(--text-sec); border-top: 1px solid var(--border); padding-top: 1rem; }
        .role-card .screen-count { background: var(--accent-glow); color: var(--accent); font-weight: 600; padding: 0.25rem 0.5rem; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <i class="bi bi-shield-check"></i>
            <div>
                <h1>PrimeCare Screen Simulator</h1>
                <p style="color: var(--text-sec); margin-top: 0.25rem;">Select a role to inspect navigation and screen previews from the database.</p>
            </div>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card"><div class="label">Total Apps</div><div class="val">__TOTAL_APPS__</div></div>
            <div class="stat-card"><div class="label">Total Roles</div><div class="val">__TOTAL_ROLES__</div></div>
            <div class="stat-card"><div class="label">Total Screens</div><div class="val">__TOTAL_SCREENS__</div></div>
        </div>
        
        <div class="search-section">
            <input type="text" id="search" class="search-box" placeholder="Search roles by name or code...">
        </div>
        
        <div class="roles-grid" id="roles-grid">
            __ROLES_CARDS__
        </div>
    </div>
    
    <script>
        const searchInput = document.getElementById('search');
        const cards = document.querySelectorAll('.role-card');
        
        searchInput.addEventListener('input', (e) => {
            const filter = e.target.value.toLowerCase();
            cards.forEach(card => {
                const name = card.getAttribute('data-name').toLowerCase();
                const code = card.getAttribute('data-code').toLowerCase();
                if (name.includes(filter) || code.includes(filter)) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
    """
    
    total_apps = len(apps_raw)
    total_roles = len(roles_raw)
    total_screens = len(screens_raw)
    
    role_cards = []
    for r in roles.values():
        role_cards.append(f"""
        <a class="role-card" href="roles/{r['code']}/index.html" data-name="{r['name']}" data-code="{r['code']}">
            <div>
                <h3>{r['name']}</h3>
                <div class="meta">{r['code'].upper()} • {r['type']}</div>
            </div>
            <div class="footer">
                <span>Assigned Screens</span>
                <span class="screen-count">{len(r['screens'])}</span>
            </div>
        </a>
        """)
        
    index_html = index_html.replace("__TOTAL_APPS__", str(total_apps))\
                           .replace("__TOTAL_ROLES__", str(total_roles))\
                           .replace("__TOTAL_SCREENS__", str(total_screens))\
                           .replace("__ROLES_CARDS__", "\n".join(role_cards))
                           
    with open(os.path.join(out_dir, "index.html"), "w", encoding="utf-8") as f:
        f.write(index_html)

    # 4. Templates for Role Index and Screen Preview
    role_index_template = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ROLE_NAME}} - Screen Index</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg-dark: #090d16;
            --surface: #101625;
            --accent: #6366f1;
            --accent-glow: rgba(99, 102, 241, 0.15);
            --border: rgba(255, 255, 255, 0.08);
            --text-main: #f8fafc;
            --text-sec: #94a3b8;
            --danger: #ef4444;
            --warning: #f59e0b;
            --success: #10b981;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Outfit', sans-serif; background: var(--bg-dark); color: var(--text-main); padding: 3rem; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 3rem; border-bottom: 1px solid var(--border); padding-bottom: 1.5rem; }
        .header-title { display: flex; align-items: center; gap: 1rem; }
        .header-title i { font-size: 2.25rem; color: var(--accent); }
        .header-title h1 { font-size: 2rem; font-weight: 700; }
        .btn { padding: 0.5rem 1rem; border-radius: 0.375rem; font-size: 0.875rem; font-weight: 600; text-decoration: none; cursor: pointer; display: inline-flex; align-items: center; gap: 0.5rem; }
        .btn-secondary { background: rgba(255, 255, 255, 0.05); color: var(--text-main); border: 1px solid var(--border); }
        .btn-secondary:hover { background: rgba(255, 255, 255, 0.08); }
        
        .role-meta-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 3rem; }
        .meta-card { background: var(--surface); border: 1px solid var(--border); padding: 1.5rem; border-radius: 0.75rem; }
        .meta-card .label { font-size: 0.85rem; color: var(--text-sec); text-transform: uppercase; letter-spacing: 0.05em; }
        .meta-card .val { font-size: 1.25rem; font-weight: 600; margin-top: 0.5rem; }
        
        .table-card { background: var(--surface); border: 1px solid var(--border); border-radius: 0.75rem; padding: 1.5rem; overflow: hidden; }
        .table-title { font-size: 1.2rem; font-weight: 600; margin-bottom: 1.5rem; }
        .screen-table { width: 100%; border-collapse: collapse; text-align: left; }
        .screen-table th { padding: 0.75rem 1rem; border-bottom: 1px solid var(--border); font-size: 0.75rem; text-transform: uppercase; color: var(--text-sec); }
        .screen-table td { padding: 1rem; border-bottom: 1px solid var(--border); font-size: 0.875rem; }
        .screen-table tr:hover td { background: rgba(255, 255, 255, 0.01); }
        .badge { display: inline-flex; align-items: center; padding: 0.125rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600; }
        .badge.warning { background: rgba(245, 158, 11, 0.1); color: var(--warning); }
        .badge.danger { background: rgba(239, 68, 68, 0.1); color: var(--danger); }
        .badge.success { background: rgba(16, 185, 129, 0.1); color: var(--success); }
        
        .warn-banner { background: rgba(245, 158, 11, 0.05); border: 1px dashed var(--warning); border-radius: 0.5rem; padding: 1rem 1.5rem; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.75rem; color: var(--warning); font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-title">
                <i class="bi bi-person-workspace"></i>
                <div>
                    <h1>{{ROLE_NAME}} Screens Index</h1>
                    <p style="color: var(--text-sec); font-size: 0.9rem; margin-top: 0.25rem;">Workspace details and assigned screens preview directory.</p>
                </div>
            </div>
            <a href="../../index.html" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back to Roles</a>
        </div>
        
        {{SIDEBAR_WARNING_BANNER}}
        
        <div class="role-meta-grid">
            <div class="meta-card"><div class="label">Role Code</div><div class="val">{{ROLE_CODE}}</div></div>
            <div class="meta-card"><div class="label">Workspace App</div><div class="val">{{ROLE_APP}}</div></div>
            <div class="meta-card"><div class="label">Assigned Screens</div><div class="val">{{SCREENS_COUNT}}</div></div>
        </div>
        
        <div class="table-card">
            <div class="table-title">Screens Checklist</div>
            <table class="screen-table">
                <thead>
                    <tr>
                        <th>Screen Name</th>
                        <th>Route Path</th>
                        <th>Sections</th>
                        <th>Elements</th>
                        <th>APIs</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {{TABLE_ROWS}}
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
"""

    screen_template = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{SCREEN_NAME}} - Preview</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../../../assets/primecare_theme.css">
    <style>
        :root {
            --bg-dark: #090d16;
            --sidebar-bg: #101625;
            --accent: #6366f1;
            --accent-glow: rgba(99, 102, 241, 0.15);
            --border: rgba(255, 255, 255, 0.08);
            --text-main: #f8fafc;
            --text-sec: #94a3b8;
            --danger: #ef4444;
            --warning: #f59e0b;
            --success: #10b981;
            --card-bg: rgba(255, 255, 255, 0.02);
            --card-hover: rgba(255, 255, 255, 0.05);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Outfit', sans-serif; background: var(--bg-dark); color: var(--text-main); height: 100vh; overflow: hidden; display: flex; flex-direction: column; }
        
        /* App Layout Shell */
        .app-topbar { height: 60px; background: var(--sidebar-bg); border-bottom: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; padding: 0 2rem; }
        .topbar-brand { display: flex; align-items: center; gap: 0.5rem; font-weight: 700; font-size: 1.1rem; }
        .topbar-brand i { color: var(--accent); }
        .topbar-items { display: flex; align-items: center; gap: 1.25rem; font-size: 1.2rem; color: var(--text-sec); }
        .topbar-items i { cursor: pointer; transition: color 0.2s; }
        .topbar-items i:hover { color: var(--text-main); }
        
        .app-body { flex: 1; display: flex; height: calc(100% - 60px); overflow: hidden; }
        
        .app-sidebar { width: 240px; background: var(--sidebar-bg); border-right: 1px solid var(--border); padding: 1.5rem 1rem; overflow-y: auto; }
        .sidebar-section-title { font-size: 0.7rem; text-transform: uppercase; color: var(--text-sec); margin: 1rem 0 0.5rem 0.5rem; letter-spacing: 0.05em; }
        .sidebar-link { display: flex; align-items: center; gap: 0.75rem; padding: 0.6rem 0.75rem; border-radius: 0.375rem; color: var(--text-sec); text-decoration: none; font-size: 0.9rem; margin-bottom: 0.25rem; transition: all 0.2s; }
        .sidebar-link:hover { background: var(--card-hover); color: var(--text-main); }
        .sidebar-link.active { background: rgba(255, 255, 255, 0.05); color: var(--accent); border-left: 3px solid var(--accent); padding-left: calc(0.75rem - 3px); }
        
        .app-main { flex: 1; display: flex; overflow: hidden; }
        
        .app-viewport { flex: 1; padding: 2rem; overflow-y: auto; background: #0d121f; position: relative; }
        .app-inspector { width: 320px; background: var(--sidebar-bg); border-left: 1px solid var(--border); padding: 1.5rem; overflow-y: auto; display: flex; flex-direction: column; gap: 1.5rem; }
        
        /* Render components */
        .screen-header-section { margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 1rem; }
        .header-title h2 { font-size: 1.5rem; font-weight: 700; }
        .header-title .breadcrumb { font-size: 0.8rem; color: var(--text-sec); margin-top: 0.25rem; }
        .header-actions { display: flex; gap: 0.5rem; }
        .btn { padding: 0.5rem 1rem; border-radius: 0.375rem; font-size: 0.875rem; font-weight: 600; cursor: pointer; outline: none; border: none; display: inline-flex; align-items: center; gap: 0.5rem; text-decoration: none; }
        .btn-primary { background: var(--accent); color: white; }
        .btn-secondary { background: rgba(255, 255, 255, 0.05); color: var(--text-main); border: 1px solid var(--border); }
        .btn-secondary:hover { background: var(--card-hover); }
        
        .content-card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 0.5rem; padding: 1.25rem; margin-bottom: 1.5rem; }
        .card-title { font-size: 1rem; font-weight: 600; margin-bottom: 1rem; }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; }
        
        /* Form fields */
        .mock-form { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem; }
        .form-group-full { grid-column: span 2; }
        .form-label { display: block; font-size: 0.8rem; color: var(--text-sec); margin-bottom: 0.25rem; }
        .form-control { width: 100%; padding: 0.6rem 0.75rem; background: rgba(0, 0, 0, 0.2); border: 1px solid var(--border); border-radius: 0.375rem; color: white; font-family: inherit; outline: none; }
        
        /* Table */
        .table-responsive { width: 100%; overflow-x: auto; }
        .mock-table { width: 100%; border-collapse: collapse; text-align: left; }
        .mock-table th { padding: 0.5rem 0.75rem; border-bottom: 1px solid var(--border); font-size: 0.7rem; text-transform: uppercase; color: var(--text-sec); }
        .mock-table td { padding: 0.75rem; border-bottom: 1px solid var(--border); font-size: 0.85rem; }
        
        .metrics-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 1rem; }
        .metric-card { background: rgba(255,255,255,0.01); border: 1px solid var(--border); padding: 1rem; border-radius: 0.375rem; }
        .metric-card .metric-header { display: flex; justify-content: space-between; color: var(--text-sec); font-size: 0.75rem; margin-bottom: 0.5rem; }
        .metric-card .metric-value { font-size: 1.5rem; font-weight: 700; }
        .metric-card .metric-subtext { font-size: 0.7rem; margin-top: 0.25rem; }
        
        /* Warnings & Banners */
        .warning-banner { background: rgba(245, 158, 11, 0.05); border: 1px dashed var(--warning); border-radius: 0.5rem; padding: 0.75rem 1rem; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem; color: var(--warning); font-size: 0.85rem; }
        .warning-section { background: rgba(239, 68, 68, 0.03); border: 1px dashed var(--danger); border-radius: 0.5rem; padding: 1.5rem; display: flex; align-items: center; gap: 1rem; color: var(--danger); margin-bottom: 1.5rem; }
        .warning-section h3 { font-size: 1rem; font-weight: 600; margin-bottom: 0.25rem; }
        .warning-section p { font-size: 0.8rem; color: var(--text-sec); }
        .warning-section.potential-api { color: var(--warning); border-color: var(--warning); background: rgba(245, 158, 11, 0.02); }
        
        .warning-badge { display: inline-flex; align-items: center; gap: 0.25rem; background: rgba(245, 158, 11, 0.1); color: var(--warning); padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.7rem; font-weight: 600; margin-bottom: 0.25rem; }
        .warning-badge.danger { background: rgba(239, 68, 68, 0.1); color: var(--danger); }
        
        /* Inspector styles */
        .inspector-title { font-size: 0.8rem; text-transform: uppercase; color: var(--text-sec); letter-spacing: 0.05em; font-weight: 600; border-bottom: 1px solid var(--border); padding-bottom: 0.5rem; }
        .inspector-section { display: flex; flex-direction: column; gap: 0.5rem; }
        .api-card { background: rgba(0, 0, 0, 0.2); border: 1px solid var(--border); border-radius: 0.375rem; padding: 0.75rem; margin-bottom: 0.5rem; font-size: 0.8rem; }
        .api-method { display: inline-block; padding: 0.125rem 0.375rem; border-radius: 3px; font-size: 0.65rem; font-weight: 700; margin-bottom: 0.25rem; }
        .api-method.get { background: rgba(16, 185, 129, 0.15); color: #10b981; }
        .api-method.post { background: rgba(99, 102, 241, 0.15); color: #6366f1; }
        .api-method.put { background: rgba(245, 158, 11, 0.15); color: #f59e0b; }
        .api-method.delete { background: rgba(239, 68, 68, 0.15); color: #ef4444; }
        .api-path { font-family: monospace; font-size: 0.75rem; word-break: break-all; }
        
        /* State preview modes */
        .viewport-state { display: none; height: 200px; justify-content: center; align-items: center; flex-direction: column; gap: 0.5rem; color: var(--text-sec); }
        .viewport-state i { font-size: 2.5rem; color: var(--accent); }
        
        /* Toast style */
        .toast { position: absolute; bottom: 1rem; right: 1rem; background: #1e1b4b; border: 1px solid var(--accent); padding: 0.75rem 1.25rem; border-radius: 0.375rem; font-size: 0.8rem; display: flex; align-items: center; gap: 0.5rem; box-shadow: 0 4px 12px rgba(0,0,0,0.5); z-index: 999; opacity: 0; pointer-events: none; transition: opacity 0.2s; }
        .toast.show { opacity: 1; }
    </style>
</head>
<body>
    <!-- Topbar -->
    <div class="app-topbar">
        <div class="topbar-brand">
            <i class="bi bi-shield-check"></i>
            <span>PrimeCare Portal</span>
        </div>
        {{TOPBAR_HTML}}
    </div>
    
    <div class="app-body">
        <!-- Sidebar -->
        <div class="app-sidebar">
            {{SIDEBAR_HTML}}
        </div>
        
        <!-- Main Content -->
        <div class="app-main">
            <!-- Viewport -->
            <div class="app-viewport" id="viewport">
                <!-- Top warnings -->
                {{SIDEBAR_WARNING_BANNER}}
                {{TOPBAR_WARNING_BANNER}}
                
                <!-- Main viewport dynamic content container -->
                <div id="viewport-active-content">
                    {{VIEWPORT_SECTIONS_HTML}}
                </div>
                
                <!-- UI States previews -->
                <div id="state-loading" class="viewport-state">
                    <i class="bi bi-arrow-repeat spin" style="display:inline-block; animation: spin 1s linear infinite;"></i>
                    <p>Loading screen contents...</p>
                </div>
                <div id="state-empty" class="viewport-state">
                    <i class="bi bi-inbox"></i>
                    <p>No records found</p>
                </div>
                <div id="state-error" class="viewport-state" style="color: var(--danger);">
                    <i class="bi bi-exclamation-circle"></i>
                    <p>Failed to load data. Please retry.</p>
                </div>
                <div id="state-success" class="viewport-state" style="color: var(--success);">
                    <i class="bi bi-check-circle"></i>
                    <p>Operation completed successfully!</p>
                </div>
                
                <div class="toast" id="toast">
                    <i class="bi bi-info-circle-fill" style="color: var(--accent);"></i>
                    <span id="toast-text">Toast message</span>
                </div>
            </div>
            
            <!-- Inspector Side-Drawer -->
            <div class="app-inspector">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:0.5rem;">
                    <span class="inspector-title" style="border:none; padding:0;">Screen Inspector</span>
                    <a href="../index.html" class="btn btn-secondary" style="font-size:0.75rem; padding:0.25rem 0.5rem;"><i class="bi bi-list"></i> Index</a>
                </div>
                
                <div class="inspector-section">
                    <div class="inspector-title">Warnings / Gaps</div>
                    <div style="display:flex; flex-direction:column; gap:0.25rem; margin-top:0.25rem;">
                        {{WARNINGS_HTML}}
                    </div>
                </div>
                
                <div class="inspector-section">
                    <div class="inspector-title">Linked APIs</div>
                    <div style="margin-top:0.5rem;">
                        {{APIS_HTML}}
                    </div>
                </div>
                
                <div class="inspector-section">
                    <div class="inspector-title">Mapped Features</div>
                    <div style="margin-top:0.5rem;">
                        {{FEATURES_HTML}}
                    </div>
                </div>
                
                <div class="inspector-section">
                    <div class="inspector-title">UI State Previews</div>
                    <div style="display:grid; grid-template-columns: repeat(2, 1fr); gap:0.5rem; margin-top:0.5rem;">
                        <button class="btn btn-secondary" onclick="toggleState('active')" style="font-size:0.7rem; justify-content:center;">Active</button>
                        <button class="btn btn-secondary" onclick="toggleState('loading')" style="font-size:0.7rem; justify-content:center;">Loading</button>
                        <button class="btn btn-secondary" onclick="toggleState('empty')" style="font-size:0.7rem; justify-content:center;">Empty</button>
                        <button class="btn btn-secondary" onclick="toggleState('error')" style="font-size:0.7rem; justify-content:center;">Error</button>
                        <button class="btn btn-secondary" onclick="toggleState('success')" style="font-size:0.7rem; justify-content:center;">Success</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        const activeContent = document.getElementById('viewport-active-content');
        const states = {
            loading: document.getElementById('state-loading'),
            empty: document.getElementById('state-empty'),
            error: document.getElementById('state-error'),
            success: document.getElementById('state-success')
        };
        const toast = document.getElementById('toast');
        const toastText = document.getElementById('toast-text');
        
        function toggleState(mode) {
            activeContent.style.display = 'none';
            Object.values(states).forEach(el => el.style.display = 'none');
            
            if (mode === 'active') {
                activeContent.style.display = 'block';
            } else if (states[mode]) {
                states[mode].style.display = 'flex';
            }
        }
        
        function showToast(msg) {
            toastText.textContent = msg;
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 3000);
        }
    </script>
    <style>
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
    </style>
</body>
</html>
"""

    gaps_roles_zero_screens = []
    gaps_roles_zero_sidebar = []
    gaps_screens_missing_sections = []
    gaps_screens_missing_elements = []
    gaps_screens_missing_api = []
    gaps_screens_fallback_sidebar = []
    gaps_screens_fallback_topbar = []
    
    total_html_files_created = 1 # index.html
    
    for r_id, r in roles.items():
        role_code = r["code"]
        role_dir = os.path.join(out_dir, "roles", role_code)
        screens_dir = os.path.join(role_dir, "screens")
        os.makedirs(screens_dir, exist_ok=True)
        
        role_screens = [screens[sid] for sid in r["screens"] if sid in screens]
        if not role_screens:
            gaps_roles_zero_screens.append(r["name"])
            
        role_sidebar_items = sidebar_items_by_role.get(r_id, [])
        if not role_sidebar_items:
            gaps_roles_zero_sidebar.append(r["name"])
            
        # Create table rows for role index page
        table_rows = []
        for sc in role_screens:
            sec_count = len(sc["sections"])
            elem_count = sum(len(sec["elements"]) for sec in sc["sections"])
            api_count = len(sc["apis"])
            
            if sec_count == 0:
                gaps_screens_missing_sections.append(f"{role_code}/{sc['code']}")
            if elem_count == 0:
                gaps_screens_missing_elements.append(f"{role_code}/{sc['code']}")
            if api_count == 0:
                gaps_screens_missing_api.append(f"{role_code}/{sc['code']}")
                
            sec_badge = f"<span class='badge success'>{sec_count} sections</span>" if sec_count > 0 else "<span class='badge danger'><i class='bi bi-x-circle'></i> 0 sections</span>"
            elem_badge = f"<span class='badge success'>{elem_count} elements</span>" if elem_count > 0 else "<span class='badge danger'><i class='bi bi-x-circle'></i> 0 elements</span>"
            api_badge = f"<span class='badge success'>{api_count} apis</span>" if api_count > 0 else "<span class='badge warning'><i class='bi bi-exclamation-triangle'></i> 0 apis</span>"
            
            table_rows.append(f"""
                    <tr>
                        <td><strong>{sc['name'].replace('Screen', '')}</strong><br><span style='color: var(--text-sec); font-size: 0.75rem;'>{sc['code']}</span></td>
                        <td style='font-family: monospace; font-size: 0.8rem; color: var(--text-sec);'>{sc['route']}</td>
                        <td>{sec_badge}</td>
                        <td>{elem_badge}</td>
                        <td>{api_badge}</td>
                        <td><a href="screens/{sc['code']}.html" class="btn btn-secondary btn-sm" style="font-size: 0.75rem; padding: 0.25rem 0.5rem;"><i class="bi bi-eye"></i> Preview</a></td>
                    </tr>
            """)
            
            # SIDEBAR PREVIEW BUILD
            sidebar_warning_banner = ""
            sidebar_warning = ""
            sidebar_html = ""
            if not role_sidebar_items:
                gaps_screens_fallback_sidebar.append(f"{role_code}/{sc['code']}")
                sidebar_warning = "WARNING: Sidebar generated from role_screen_map fallback because sidebar_items missing."
                sidebar_warning_banner = f'<div class="warning-banner"><i class="bi bi-exclamation-triangle"></i><span>{sidebar_warning}</span></div>'
                sidebar_html = '<div class="sidebar-section-title">Fallback Sidebar (Map)</div>'
                for side_sc in role_screens:
                    active_class = "active" if side_sc["id"] == sc["id"] else ""
                    sidebar_html += f'<a href="{side_sc["code"]}.html" class="sidebar-link {active_class}"><i class="bi bi-file-earmark-richtext"></i><span>{side_sc["name"].replace("Screen", "")}</span></a>'
            else:
                groups = {}
                for s_item in role_sidebar_items:
                    groups.setdefault(s_item["group"], []).append(s_item)
                for g_name, g_items in groups.items():
                    sidebar_html += f'<div class="sidebar-section-title">{g_name or "Navigation"}</div>'
                    for s_item in g_items:
                        active_class = "active" if s_item["screen_id"] == sc["id"] else ""
                        item_screen = screens.get(s_item["screen_id"])
                        target_url = f"{item_screen['code']}.html" if item_screen else "#"
                        sidebar_html += f'<a href="{target_url}" class="sidebar-link {active_class}"><i class="bi bi-file-earmark-text"></i><span>{s_item["label"].replace("Screen", "")}</span></a>'

            # TOPBAR PREVIEW BUILD
            topbar_warning_banner = ""
            topbar_html = ""
            role_topbar_items = topbar_items_by_role.get(r_id, [])
            if not role_topbar_items:
                gaps_screens_fallback_topbar.append(f"{role_code}/{sc['code']}")
                topbar_warning = "WARNING: Default topbar fallback used because topbar_items missing."
                topbar_warning_banner = f'<div class="warning-banner"><i class="bi bi-exclamation-triangle"></i><span>{topbar_warning}</span></div>'
                topbar_html = """
                <div class="topbar-items">
                    <i class="bi bi-search" title="Global Search"></i>
                    <i class="bi bi-chat-left-text" title="Chat"></i>
                    <i class="bi bi-bell" title="Notifications"></i>
                    <i class="bi bi-question-circle" title="Help"></i>
                    <i class="bi bi-person-circle" title="Profile"></i>
                    <i class="bi bi-box-arrow-right" title="Logout" style="color: var(--danger);"></i>
                </div>
                """
            else:
                topbar_html = '<div class="topbar-items">'
                for t_item in role_topbar_items:
                    topbar_html += f'<i class="bi bi-{t_item["icon"]}" title="{t_item["label"]}"></i>'
                topbar_html += '</div>'

            # VIEWPORT RENDER
            viewport_sections_html = ""
            if not sc["sections"]:
                viewport_sections_html += """
                <div class="warning-section missing-sections">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <div>
                        <h3>Missing screen_sections data</h3>
                        <p>No layout panels are defined in screen_sections table for this screen.</p>
                    </div>
                </div>
                """
            else:
                for sec in sc["sections"]:
                    sec_type = sec["type"]
                    if sec_type == 'header':
                        actions_html = ""
                        for el in sec["elements"]:
                            if el["type"] == 'button':
                                actions_html += f'<button class="btn btn-primary" onclick="showToast(\'{el["label"]} clicked!\')">{el["label"]}</button>'
                        viewport_sections_html += f"""
                        <div class="screen-header-section">
                            <div class="header-title">
                                <h2>{sc['name'].replace('Screen', '')}</h2>
                                <div class="breadcrumb">PrimeCare / {r['name']} / {sc['name']}</div>
                            </div>
                            <div class="header-actions">
                                {actions_html}
                            </div>
                        </div>
                        """
                    elif sec_type in ('metrics', 'summary_cards'):
                        grid_html = '<div class="metrics-grid">'
                        for index, el in enumerate(sec["elements"]):
                            mock_values = ["1,248", "94.2%", "28 mins", "4.8", "12", "88%"]
                            mock_subtext = ["+12% from last week", "+0.4% vs target", "-3m response", "+0.1 rating", "Pending review", "Optimal"]
                            val = mock_values[index % len(mock_values)]
                            sub = mock_subtext[index % len(mock_subtext)]
                            
                            grid_html += f"""
                            <div class="metric-card">
                                <div class="metric-header">
                                    <span>{el['label']}</span>
                                    <i class="bi bi-activity"></i>
                                </div>
                                <div class="metric-value">{val}</div>
                                <div class="metric-subtext metric-trend-up">
                                    <i class="bi bi-graph-up-arrow"></i>
                                    <span>{sub}</span>
                                </div>
                                <div style="font-size:0.7rem; color:var(--text-muted); margin-top:0.25rem;">Component: {el['primecare_component'] or 'N/A'}</div>
                            </div>
                            """
                        grid_html += '</div>'
                        viewport_sections_html += f"""
                        <div class="content-card">
                            <div class="card-title">{sec['name']}</div>
                            {grid_html}
                        </div>
                        """
                    elif sec_type in ('table', 'list'):
                        headers = "".join(f"<th>{el['label']}</th>" for el in sec["elements"]) or "<th>ID</th><th>Description</th><th>Status</th>"
                        rows = ""
                        for idx in range(1, 4):
                            cols = "".join(f"<td>Mock {el['label']} {idx}</td>" for el in sec["elements"]) or f"<td>#PC-10{idx}</td><td>Mock table row</td><td><span class='badge success'>completed</span></td>"
                            rows += f"<tr>{cols}</tr>"
                        viewport_sections_html += f"""
                        <div class="content-card">
                            <div class="card-header">
                                <div class="card-title">{sec['name']}</div>
                            </div>
                            <div class="table-responsive">
                                <table class="mock-table">
                                    <thead><tr>{headers}</tr></thead>
                                    <tbody>{rows}</tbody>
                                </table>
                            </div>
                        </div>
                        """
                    elif sec_type == 'form':
                        fields = ""
                        for el in sec["elements"]:
                            if el["type"] == 'button': continue
                            fields += f"""
                            <div style="margin-bottom: 0.75rem;">
                                <label class="form-label">{el['label']}</label>
                                <input type="text" class="form-control" placeholder="Enter {el['label']}...">
                                <div style="font-size:0.7rem; color:var(--text-muted); margin-top:0.25rem;">Component: {el['primecare_component'] or 'N/A'}</div>
                            </div>
                            """
                        submit_btn = "".join(f'<button class="btn btn-primary" onclick="showToast(\'Form action: {el["label"]}\')">{el["label"]}</button>' for el in sec["elements"] if el["type"] == 'button') or '<button class="btn btn-primary">Submit</button>'
                        viewport_sections_html += f"""
                        <div class="content-card">
                            <div class="card-title">{sec['name']}</div>
                            <form class="mock-form" onsubmit="event.preventDefault();">
                                {fields}
                                <div class="form-group-full" style="margin-top:1rem; display:flex; gap:0.5rem;">
                                    {submit_btn}
                                </div>
                            </form>
                        </div>
                        """
                    else:
                        elems_html = "".join(f"<li><i class='bi bi-dot'></i> {el['label']} <span style='font-size:0.7rem; color:var(--text-muted);'>({el['type']})</span></li>" for el in sec["elements"])
                        viewport_sections_html += f"""
                        <div class="content-card">
                            <div class="card-title">{sec['name']}</div>
                            <p style="font-size: 0.9rem; color: var(--text-sec); margin-bottom: 1rem;">{sec['purpose'] or ''}</p>
                            <ul style="list-style: none; padding-left: 0;">{elems_html}</ul>
                        </div>
                        """

            # WARNINGS & BADGES
            warnings_html = ""
            if not role_sidebar_items:
                warnings_html += '<span class="warning-badge"><i class="bi bi-exclamation-triangle"></i> Fallback Sidebar</span>'
            if not role_topbar_items:
                warnings_html += '<span class="warning-badge"><i class="bi bi-exclamation-triangle"></i> Fallback Topbar</span>'
            if len(sc["sections"]) == 0:
                warnings_html += '<span class="warning-badge danger"><i class="bi bi-exclamation-triangle"></i> Missing Sections</span>'
            else:
                has_elements = any(len(sec["elements"]) > 0 for sec in sc["sections"])
                if not has_elements:
                    warnings_html += '<span class="warning-badge danger"><i class="bi bi-exclamation-triangle"></i> Missing Elements</span>'
            if len(sc["apis"]) == 0:
                warnings_html += '<span class="warning-badge"><i class="bi bi-exclamation-triangle"></i> Missing API Mapping</span>'
            if sc["stage"] != "verified":
                warnings_html += '<span class="warning-badge"><i class="bi bi-exclamation-triangle"></i> Not Production Ready</span>'

            # APIS
            apis_html = ""
            if not sc["apis"]:
                apis_html = '<div class="warning-section potential-api"><i class="bi bi-exclamation-circle"></i> Potential missing API mapping</div>'
            else:
                for api in sc["apis"]:
                    apis_html += f"""
                    <div class="api-card">
                        <div class="api-method {api['method'].lower()}">{api['method'].upper()}</div>
                        <div class="api-path">{api['path']}</div>
                        <div style="font-size:0.7rem; color:var(--text-sec); margin-top:0.25rem;">Code: {api['code']}</div>
                    </div>
                    """

            # FEATURES
            features_html = ""
            if not sc["features"]:
                features_html = '<div class="warning-section"><i class="bi bi-info-circle"></i> No features mapped to this screen.</div>'
            else:
                for f_item in sc["features"]:
                    features_html += f"""
                    <div class="api-card">
                        <strong>{f_item['name']}</strong>
                        <div style="font-size:0.75rem; color:var(--text-sec); margin-top:0.125rem;">Code: {f_item['code']} • Mapped: {f_item['required']}</div>
                    </div>
                    """

            # Screen replace
            s_html = screen_template.replace("{{SCREEN_NAME}}", sc["name"])\
                                    .replace("{{TOPBAR_HTML}}", topbar_html)\
                                    .replace("{{SIDEBAR_HTML}}", sidebar_html)\
                                    .replace("{{SIDEBAR_WARNING_BANNER}}", sidebar_warning_banner)\
                                    .replace("{{TOPBAR_WARNING_BANNER}}", topbar_warning_banner)\
                                    .replace("{{VIEWPORT_SECTIONS_HTML}}", viewport_sections_html)\
                                    .replace("{{WARNINGS_HTML}}", warnings_html)\
                                    .replace("{{APIS_HTML}}", apis_html)\
                                    .replace("{{FEATURES_HTML}}", features_html)

            screen_file_name = f"{sc['code']}.html"
            with open(os.path.join(screens_dir, screen_file_name), "w", encoding="utf-8") as f:
                f.write(s_html)
            total_html_files_created += 1

        # Role Index replace
        role_app_name = apps[r["screens"][0]]["name"] if r["screens"] and r["screens"][0] in apps else "PrimeCare App"
        sidebar_banner = "<div class='warn-banner'><i class='bi bi-exclamation-triangle-fill'></i><span><strong>WARNING:</strong> Sidebar items missing. Fallback sidebar will be generated from role_screen_map.</span></div>" if not role_sidebar_items else ""
        
        r_html = role_index_template.replace("{{ROLE_NAME}}", r["name"])\
                                    .replace("{{ROLE_CODE}}", role_code.upper())\
                                    .replace("{{ROLE_APP}}", role_app_name)\
                                    .replace("{{SCREENS_COUNT}}", str(len(role_screens)))\
                                    .replace("{{SIDEBAR_WARNING_BANNER}}", sidebar_banner)\
                                    .replace("{{TABLE_ROWS}}", "\n".join(table_rows))
                                    
        with open(os.path.join(role_dir, "index.html"), "w", encoding="utf-8") as f:
            f.write(r_html)
        total_html_files_created += 1

    # 5. Generate JavaScript logic for search & quick navigation
    js_content = """
// preview_app.js - Handles role navigation and filtering in selector portal
console.log("PrimeCare Screen Simulator loaded.");
    """
    with open(os.path.join(out_dir, "assets", "preview_app.js"), "w", encoding="utf-8") as f:
        f.write(js_content)

    # 6. Generate the Reports
    # Report A: HTML_PREVIEW_GENERATION_REPORT.md
    preview_gen_report = f"""# HTML Preview Generation Report

This report summarizes the outcome of the automated database-driven screen simulator generation run.

## Summary Metrics
* **Total Roles Processed**: {total_roles}
* **Total Screens Rendered**: {total_screens}
* **Total HTML Files Created**: {total_html_files_created}

## Roles with Zero Screens
{chr(10).join(f"- {r}" for r in gaps_roles_zero_screens) if gaps_roles_zero_screens else "*None*"}

## Roles with Zero Sidebar Items
{chr(10).join(f"- {r}" for r in gaps_roles_zero_sidebar) if gaps_roles_zero_sidebar else "*None*"}

## Screens Missing Section Data
{chr(10).join(f"- `{s}`" for s in gaps_screens_missing_sections) if gaps_screens_missing_sections else "*None*"}

## Screens Missing Element Data
{chr(10).join(f"- `{s}`" for s in gaps_screens_missing_elements) if gaps_screens_missing_elements else "*None*"}

## Screens Missing API Mapping
{chr(10).join(f"- `{s}`" for s in gaps_screens_missing_api) if gaps_screens_missing_api else "*None*"}
"""
    with open(os.path.join(out_dir, "reports", "HTML_PREVIEW_GENERATION_REPORT.md"), "w", encoding="utf-8") as f:
        f.write(preview_gen_report)

    # Report B: ROLE_SCREEN_HTML_INDEX.md
    index_md_content = "# Role-by-Role Screen Preview Directory\n\n"
    index_md_content += "| Role | Code | Screens Count | Index Link |\n"
    index_md_content += "|------|------|---------------|------------|\n"
    for r in roles.values():
        index_md_content += f"| {r['name']} | `{r['code']}` | {len(r['screens'])} | [View Index](../roles/{r['code']}/index.html) |\n"
        
    with open(os.path.join(out_dir, "reports", "ROLE_SCREEN_HTML_INDEX.md"), "w", encoding="utf-8") as f:
        f.write(index_md_content)

    # Report C: MISSING_PREVIEW_DATA_REPORT.md
    missing_report = f"""# Database Integrity Gaps Report

This report lists the exact data definitions missing in `governance.db` that prevented rendering realistic interactive screens.

## Gaps Breakdown

### 1. Missing Sidebar Definitions
These roles do not have `sidebar_items` records and loaded a fallback:
{chr(10).join(f"- Role: `{r}`" for r in gaps_roles_zero_sidebar) if gaps_roles_zero_sidebar else "*None*"}

### 2. Missing Topbar Definitions
Screens loading fallback topbars because `topbar_items` were missing:
{len(gaps_screens_fallback_topbar)} screen instances.

### 3. Missing Screen Layout Sections
These screens have zero `screen_sections` records and render empty viewports:
{chr(10).join(f"- `{s}`" for s in gaps_screens_missing_sections) if gaps_screens_missing_sections else "*None*"}

### 4. Missing Screen Layout Section Elements
These screens have sections but zero `screen_section_elements` inside:
{chr(10).join(f"- `{s}`" for s in gaps_screens_missing_elements) if gaps_screens_missing_elements else "*None*"}

### 5. Missing API Endpoint Mappings
These screens have zero `screen_api_map` records (potential missing API connection):
{chr(10).join(f"- `{s}`" for s in gaps_screens_missing_api) if gaps_screens_missing_api else "*None*"}
"""
    with open(os.path.join(out_dir, "reports", "MISSING_PREVIEW_DATA_REPORT.md"), "w", encoding="utf-8") as f:
        f.write(missing_report)

    print(f"Generated {total_html_files_created} HTML files and reports successfully in {out_dir}")

if __name__ == "__main__":
    main()
