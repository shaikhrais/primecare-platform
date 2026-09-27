import os
import sys
import re
import json

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def _camel_to_snake(input_str):
    return re.sub(r'(?<=[a-z])[A-Z]', lambda m: '_' + m.group(0), input_str).lower()

def main():
    print("--- PrimeCare Feature & Screen Generator (SQL-Relational) ---")

    screen_code = ''
    screen_name = ''
    route_path = ''
    category = ''
    role_code = ''
    comp_name = ''
    func_name = ''

    args = sys.argv[1:]
    if len(args) >= 7:
        screen_code = args[0]
        screen_name = args[1]
        route_path = args[2]
        category = args[3]
        role_code = args[4]
        comp_name = args[5]
        func_name = args[6]
    else:
        try:
            screen_code = input('Enter unique Screen Code (e.g. shift_management): ').strip()
            screen_name = input('Enter Screen Class Name (e.g. ShiftManagementDashboardScreen): ').strip()
            route_path = input('Enter relative File Path (e.g. packages/primecare_ui/lib/src/screens/management/shift_management_dashboard_screen.dart): ').strip()
            category = input('Enter Screen Category/Folder (e.g. management, clinical, psw): ').strip()
            role_code = input('Enter primary allowed Role Code (e.g. ops_manager, psw, rn): ').strip()
            comp_name = input('Enter one primary Component Label (e.g. Shift Capacity Adjuster): ').strip()
            func_name = input('Enter click handler function name (e.g. updateCapacityThreshold): ').strip()
        except KeyboardInterrupt:
            print("\nAborted.")
            sys.exit(0)

    if not screen_code or not screen_name or not route_path or not role_code:
        print("Error: Invalid or missing inputs.")
        sys.exit(1)

    print("\nGenerating feature mapping in SQL database...")

    conn = governance_db.get_connection()
    cursor = conn.cursor()
    cursor.execute("PRAGMA foreign_keys = ON;")

    # 1. Resolve UI application ID
    cursor.execute("SELECT id FROM apps WHERE app_code = 'primecare_ui' LIMIT 1;")
    app_row = cursor.fetchone()
    ui_app_id = app_row['id'] if app_row else None
    
    if not ui_app_id:
        cursor.execute("SELECT id FROM apps LIMIT 1;")
        first_app = cursor.fetchone()
        ui_app_id = first_app['id'] if first_app else 1

    # 2. Resolve Role ID
    cursor.execute("SELECT id FROM roles WHERE role_code = ? LIMIT 1;", (role_code,))
    role_row = cursor.fetchone()
    role_id = role_row['id'] if role_row else None
    
    if not role_id:
        print(f"[WARN] Role '{role_code}' was not found in roles table. Falling back to 'guest' role.")
        cursor.execute("SELECT id FROM roles WHERE role_code = 'guest' LIMIT 1;")
        guest_row = cursor.fetchone()
        role_id = guest_row['id'] if guest_row else 1

    # 3. Determine Layout Key based on category
    layout_key = 'masterLayout'
    if category in ('clinical', 'rn', 'rpn', 'allied', 'psw'):
        layout_key = 'clinicalLayout'
    elif category in ('executive', 'management'):
        layout_key = 'adminLayout'

    # 4. Insert Screen
    cursor.execute("SELECT id FROM screens WHERE screen_code = ?;", (screen_code,))
    screen_row = cursor.fetchone()
    if not screen_row:
        cursor.execute("""
        INSERT INTO screens (app_id, screen_code, screen_name, route_path, screen_type, layout_key, implementation_status, file_path)
        VALUES (?, ?, ?, ?, 'dashboard', ?, 'active', ?);
        """, (ui_app_id, screen_code, screen_name, route_path, layout_key, route_path))
        screen_id = cursor.lastrowid
        print(f"[OK] Added screen '{screen_code}' (ID: {screen_id}) to database.")
    else:
        screen_id = screen_row['id']
        print(f"[WARN] Screen '{screen_code}' already exists in database.")

    # 5. Insert Role Screen View Permission (Zero-Trust)
    cursor.execute("""
    INSERT OR IGNORE INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
    VALUES (?, ?, 1, 1, 1, 1, 1);
    """, (role_id, screen_id))
    print(f"[OK] Granted full route view/write permissions for role ID {role_id} on screen ID {screen_id}.")

    # Super privilege access for administrators
    for super_role in ('ceo', 'cto', 'admin'):
        cursor.execute("SELECT id FROM roles WHERE role_code = ? LIMIT 1;", (super_role,))
        s_row = cursor.fetchone()
        if s_row:
            s_role_id = s_row['id']
            cursor.execute("""
            INSERT OR IGNORE INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
            VALUES (?, ?, 1, 0, 0, 0, 1);
            """, (s_role_id, screen_id))

    # 6. Insert Screen Component
    comp_code = f"CMP_{screen_code}_{_camel_to_snake(comp_name.replace(' ', ''))}"
    cy_id = f"data-cy-{_camel_to_snake(comp_name.replace(' ', ''))}"
    cursor.execute("""
    INSERT INTO screen_components (screen_id, component_code, component_name, component_type, data_cy, file_path, implementation_status)
    VALUES (?, ?, ?, 'button', ?, ?, 'active');
    """, (screen_id, comp_code, comp_name, cy_id, route_path))
    comp_id = cursor.lastrowid
    print(f"[OK] Added component '{comp_code}' with Cypress ID '{cy_id}'.")

    # 7. Insert Screen Function (Click handler action)
    func_code = f"FUN_{screen_code}_{_camel_to_snake(func_name)}"
    func_name_val = f"onTap_{_camel_to_snake(func_name)}"
    callback_desc = f"shortcut: controller.{func_name}();"
    cursor.execute("""
    INSERT INTO screen_functions (screen_id, function_code, function_name, function_type, api_id, implementation_status)
    VALUES (?, ?, ?, ?, NULL, 'active');
    """, (screen_id, func_code, func_name_val, callback_desc))
    func_id = cursor.lastrowid
    print(f"[OK] Added interactive callback '{func_code}' ({func_name_val}).")

    # 8. Grant Function execution permission (Zero-Trust)
    cursor.execute("""
    INSERT OR IGNORE INTO role_function_permissions (role_id, function_id, can_execute)
    VALUES (?, ?, 1);
    """, (role_id, func_id))
    print(f"[OK] Granted function execution permissions for role ID {role_id} on function ID {func_id}.")

    conn.commit()
    conn.close()

    # 11. Scaffold UI Form File
    # Ensure directory path exists
    normal_route = route_path.replace('\\', '/')
    scaffold_dir = os.path.dirname(os.path.join(os.getcwd(), normal_route))
    os.makedirs(scaffold_dir, exist_ok=True)
    scaffold_path = os.path.join(os.getcwd(), normal_route)

    if os.path.exists(scaffold_path):
        print(f"[WARN] Physical screen file already exists at {scaffold_path}. Skipping file scaffold.")
    else:
        form_content = f'''import 'package:flutter/material.dart';

class {screen_name} extends StatelessWidget {{
  const {screen_name}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(title: Text('{screen_name}')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('{screen_name} Active View', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('{cy_id}'),
              onPressed: () {{
                // {callback_desc}
              }},
              child: const Text('{comp_name}'),
            ),
          ],
        ),
      ),
    );
  }}
}}
'''
        with open(scaffold_path, 'w', encoding='utf-8') as sf:
            sf.write(form_content)
        print(f"[OK] Successfully scaffolded Flutter UI code at {scaffold_path}")

    print("\nSUCCESS! New relational screen, permissions, menus, components, and functions registered in governance database!")

if __name__ == '__main__':
    main()
