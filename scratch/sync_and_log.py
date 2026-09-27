import os
import re
import sqlite3
import json

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def get_screen_code(cls_name):
    if not cls_name:
        return None
    screen_code = re.sub(r'(?<!^)(?=[A-Z])', '_', cls_name).lower()
    if screen_code == "dynamic_screen_dashboard_view":
        screen_code = "dynamic_screen_dashboard"
    elif screen_code == "screen_audit_view":
        screen_code = "screen_audit"
    elif screen_code == "screen_audit_screen":
        screen_code = "audit"
    elif screen_code == "audit_screen":
        screen_code = "audit"
    elif screen_code == "shared_stubs_screen":
        screen_code = "shared_stubs"
    elif screen_code == "screen_not_implemented_view":
        screen_code = "screen_not_implemented"
    else:
        screen_code = screen_code.replace("_screen", "").replace("_view", "")
    return screen_code

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    # Load roles map (id -> role_code)
    roles = cur.execute("SELECT id, role_code FROM roles;").fetchall()
    role_map = {r["id"]: r["role_code"] for r in roles}
    
    # Load apps map (id -> publish_url)
    apps = cur.execute("SELECT id, publish_url FROM apps;").fetchall()
    app_url_map = {a["id"]: a["publish_url"] for a in apps}
    
    # Load screens using LEFT JOIN to resolve role_id
    db_screens = cur.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, s.app_id, rsp.role_id 
        FROM screens s
        LEFT JOIN role_screen_permissions rsp ON s.id = rsp.screen_id
    """).fetchall()
    print(f"Loaded {len(db_screens)} screens from SQLite.")
    
    # Load extracted screens
    with open(os.path.join(PROJECT_ROOT, "scratch", "extracted_screens.json"), "r", encoding="utf-8") as f:
        extracted = json.load(f)
    print(f"Loaded {len(extracted)} extracted screens from JSON.")
    
    updates = []
    unmatched = []
    
    for ext in extracted:
        builder = ext["builder_class"]
        title = ext["title"]
        route = ext["route_val"]
        file_path = ext["file_path"]
        
        target_code = get_screen_code(builder)
        if not target_code and title:
            target_code = re.sub(r"[^a-zA-Z0-9]+", "_", title.lower()).strip("_")
            
        if not target_code:
            continue
            
        matches = []
        for dbs in db_screens:
            code_match = (dbs["screen_code"] == target_code) or \
                         (dbs["screen_code"] == target_code.replace("_screen", "")) or \
                         (target_code == dbs["screen_code"].replace("_screen", ""))
            
            name_match = title and (dbs["screen_name"].lower() == title.lower())
            
            if code_match or name_match:
                matches.append(dbs)
                
        if not matches:
            unmatched.append(ext)
            continue
            
        matched_db_screen = None
        route_role = None
        role_tokens = ["ceo", "cfo", "coo", "cto", "ciso", "compliance_manager", "head_of_bus_dev", 
                       "head_of_marketing", "training_director", "shareholder", "finance_director",
                       "volunteer_coordinator", "hr_manager", "hr_hiring", "hr_director", "cx_director",
                       "it_admin", "legal", "admin", "scheduler", "customer_support", "training_coordinator",
                       "qa_specialist", "family", "patient", "chiropractor", "physiotherapist", "social_worker",
                       "rmt", "clinical_director", "lpn", "np", "hsw", "pediatric", "physician", "cns", "caregiver", "psw", "rpn"]
        
        for token in role_tokens:
            if f"/roles/{token}/" in route or f"/{token}/" in route or f"_{token}" in file_path or f"/{token}" in file_path:
                route_role = token
                break
                
        if len(matches) == 1:
            matched_db_screen = matches[0]
        else:
            if route_role:
                for m in matches:
                    m_role_code = role_map.get(m["role_id"], "")
                    if m_role_code == route_role or route_role.replace("_", "") in m_role_code.replace("_", ""):
                        matched_db_screen = m
                        break
            if not matched_db_screen:
                matched_db_screen = matches[0]
                
        if matched_db_screen:
            updates.append({
                "id": matched_db_screen["id"],
                "app_id": matched_db_screen["app_id"],
                "screen_code": matched_db_screen["screen_code"],
                "old_route": matched_db_screen["route_path"],
                "new_route": route,
                "role_id": matched_db_screen["role_id"],
                "role_code": role_map.get(matched_db_screen["role_id"], "")
            })
            
    print(f"\nFound {len(updates)} raw screen route updates.")
    
    unique_updates = {}
    for up in updates:
        screen_id = up["id"]
        if screen_id not in unique_updates or (up["role_id"] is not None and unique_updates[screen_id]["role_id"] is None):
            unique_updates[screen_id] = up
            
    updates_list = list(unique_updates.values())
    updated_ids = {up["id"] for up in updates_list}
    
    occupied_routes = set()
    for dbs in db_screens:
        if dbs["id"] not in updated_ids:
            occupied_routes.add((dbs["app_id"], dbs["route_path"]))
            
    final_updates = []
    for up in updates_list:
        app_id = up["app_id"]
        target_route = up["new_route"]
        if not target_route:
            continue
            
        is_duplicate = False
        if (app_id, target_route) in occupied_routes:
            is_duplicate = True
            suffix_idx = 1
            while True:
                modified_route = f"{target_route}-dup-{suffix_idx}"
                if (app_id, modified_route) not in occupied_routes:
                    target_route = modified_route
                    break
                suffix_idx += 1
                
        occupied_routes.add((app_id, target_route))
        final_updates.append({
            "id": up["id"],
            "app_id": up["app_id"],
            "screen_code": up["screen_code"],
            "old_route": up["old_route"],
            "new_route": target_route,
            "role_code": up["role_code"],
            "is_route_active": 0 if is_duplicate else 1
        })
        
    for up in final_updates:
        publish_url = app_url_map.get(up["app_id"], "")
        if publish_url.endswith("/"):
            publish_url = publish_url[:-1]
        
        new_route = up["new_route"]
        if not new_route.startswith("/"):
            new_route = "/" + new_route
            
        new_deep_link = f"{publish_url}{new_route}"
        
        try:
            cur.execute("UPDATE screens SET route_path = ?, deep_link_url = ?, is_route_active = ? WHERE id = ?;", 
                        (up["new_route"], new_deep_link, up["is_route_active"], up["id"]))
            print(f"Success: {up['screen_code']} -> {up['new_route']}")
        except sqlite3.IntegrityError as e:
            print(f"\n*** FAILURE: {up['screen_code']} (id={up['id']}, app_id={up['app_id']}) -> {up['new_route']}")
            print(f"  Error: {e}")
            # Query existing records in database for this app_id and route_path
            conflict_scr = cur.execute("SELECT id, screen_code, route_path FROM screens WHERE app_id = ? AND route_path = ?;", (up["app_id"], up["new_route"])).fetchall()
            for cs in conflict_scr:
                print(f"  Conflicting screen in DB: id={cs[0]}, screen_code={cs[1]}, route_path={cs[2]}")
            conn.close()
            return
            
    conn.commit()
    conn.close()
    print("All synchronized successfully!")

if __name__ == '__main__':
    main()
