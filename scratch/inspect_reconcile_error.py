import os
import sys
import sqlite3

# Add governance path
sys.path.append(os.path.abspath(".agents/governance"))
import reconcile_db
import governance_db

def main():
    conn = governance_db.get_connection()
    cursor = conn.cursor()
    
    # Let's inspect roles table
    cursor.execute("SELECT id, role_code FROM roles")
    roles = {r['role_code']: r['id'] for r in cursor.fetchall()}
    print(f"Total roles in DB: {len(roles)}")
    
    # Primary UI application ID
    cursor.execute("SELECT id FROM apps WHERE app_code = 'primecare_ui' LIMIT 1;")
    app_row = cursor.fetchone()
    ui_app_db_id = app_row['id'] if app_row else 1

    cursor.execute("SELECT id, app_code FROM apps;")
    apps_mapping = {row['app_code']: row['id'] for row in cursor.fetchall()}
    
    screens_dir = r"packages\primecare_ui\lib\src\screens"
    files = reconcile_db.find_dashboard_files(screens_dir)
    print(f"Discovered {len(files)} dashboard files")
    
    cursor.execute("SELECT screen_code FROM screens WHERE screen_type = 'dashboard';")
    db_dashboards = {row['screen_code'] for row in cursor.fetchall()}
    
    for file_path in files:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # simple camel to snake
        import re
        class_name = None
        screen_match = re.search(r'class (\w+Screen) extends', content)
        if screen_match:
            class_name = screen_match.group(1)
        else:
            widget_match = re.search(r'class (\w+) extends GovernedConsumerWidget', content)
            if widget_match:
                class_name = widget_match.group(1)
            else:
                class_match = re.search(r'class (\w+) extends', content)
                if class_match:
                    class_name = class_match.group(1)
        if not class_name:
            continue
            
        screen_code = reconcile_db._camel_to_snake(class_name)
        if screen_code.endswith('_screen'):
            screen_code = screen_code[:-7]
            
        if screen_code not in db_dashboards:
            role_code = reconcile_db.resolve_role_id(screen_code)
            app_code_for_screen = reconcile_db.resolve_app_code_for_role(role_code)
            app_db_id = apps_mapping.get(app_code_for_screen, ui_app_db_id)
            
            parsed = {
                'screen_name': class_name,
                'path': os.path.relpath(file_path, os.getcwd()).replace('\\', '/'),
                'has_physical_sidebar': ' GovernedConsumerWidget' in content, # simplified
            }
            
            role_db_id = roles.get(role_code, roles.get('guest'))
            
            # Let's perform the actual inserts inside a try block to see which one fails
            layout_key = 'clinicalLayout' if parsed['has_physical_sidebar'] else 'masterLayout'
            try:
                # print(f"Inserting screen: app_db_id={app_db_id}, screen_code={screen_code}, route={parsed['path']}")
                # check if app_db_id exists in apps
                cursor.execute("SELECT id FROM apps WHERE id = ?", (app_db_id,))
                if not cursor.fetchone():
                    print(f"ERROR: app_db_id {app_db_id} does not exist in apps table!")
                    
                cursor.execute("""
                INSERT OR IGNORE INTO screens (app_id, screen_code, screen_name, route_path, screen_type, layout_key, implementation_status)
                VALUES (?, ?, ?, ?, 'dashboard', ?, 'active')
                """, (app_db_id, screen_code, parsed['screen_name'], parsed['path'], layout_key))
                
                screen_db_id = cursor.lastrowid
                if not screen_db_id:
                    cursor.execute("SELECT id FROM screens WHERE app_id = ? AND screen_code = ?;", (app_db_id, screen_code))
                    row_scr = cursor.fetchone()
                    if row_scr:
                        screen_db_id = row_scr[0]
                
                if screen_db_id and role_db_id:
                    # check if screen_db_id exists in screens
                    cursor.execute("SELECT id FROM screens WHERE id = ?", (screen_db_id,))
                    if not cursor.fetchone():
                        print(f"ERROR: screen_db_id {screen_db_id} does not exist in screens table before inserting perm!")
                        
                    # check if role_db_id exists in roles
                    cursor.execute("SELECT id FROM roles WHERE id = ?", (role_db_id,))
                    if not cursor.fetchone():
                        print(f"ERROR: role_db_id {role_db_id} does not exist in roles table before inserting perm!")

                    cursor.execute("""
                    INSERT OR IGNORE INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
                    VALUES (?, ?, 1, 0, 0, 0, 1)
                    """, (role_db_id, screen_db_id))
            except sqlite3.IntegrityError as e:
                print(f"FAIL: screen_code={screen_code}, role_code={role_code}, role_db_id={role_db_id}, screen_db_id={screen_db_id}, app_db_id={app_db_id}")
                print(f"Error: {e}")
                
    conn.rollback()
    conn.close()

if __name__ == '__main__':
    main()
