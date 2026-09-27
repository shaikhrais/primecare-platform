import os
import re
import shutil
import sqlite3
from collections import Counter

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
BACKUP_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db.pre_import_backup")
SQL_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "d1_schema.sql")

def backup_db():
    print(f"Creating database backup...")
    if os.path.exists(DB_PATH):
        shutil.copy2(DB_PATH, BACKUP_PATH)
        print(f"Backup created at: {BACKUP_PATH}")
    else:
        print("Warning: Database to backup does not exist yet.")

def ensure_columns(cur, table_name, columns):
    cur.execute(f"PRAGMA table_info({table_name});")
    existing = {row[1] for row in cur.fetchall()}
    for col_name, col_type in columns:
        if col_name == 'id':
            continue
        if col_name not in existing:
            plain_type = col_type.split('PRIMARY')[0].split('DEFAULT')[0].strip()
            plain_type = re.sub(r'[\s,]+$', '', plain_type)
            print(f"  Adding missing column: {table_name}.{col_name} ({plain_type})...")
            cur.execute(f"ALTER TABLE {table_name} ADD COLUMN {col_name} {plain_type};")

def parse_create_table_cols(create_table_str):
    match = re.search(r'CREATE TABLE \w+\s*\((.*?)\);', create_table_str, re.DOTALL)
    if not match:
        return []
    
    inner = match.group(1)
    
    parts = []
    current = []
    depth = 0
    in_string = False
    string_char = None
    
    for char in inner:
        if char in ("'", '"'):
            if not in_string:
                in_string = True
                string_char = char
            elif string_char == char:
                in_string = False
        elif char == '(' and not in_string:
            depth += 1
        elif char == ')' and not in_string:
            depth -= 1
        elif char == ',' and depth == 0 and not in_string:
            parts.append("".join(current).strip())
            current = []
            continue
        current.append(char)
    if current:
        parts.append("".join(current).strip())
        
    columns = []
    for p in parts:
        tokens = p.split()
        if not tokens:
            continue
        
        # Check if this line is a constraint instead of a column
        first_token = tokens[0].upper()
        if first_token in ('FOREIGN', 'CONSTRAINT', 'UNIQUE', 'CHECK'):
            continue
        if len(tokens) >= 2 and first_token == 'PRIMARY' and tokens[1].upper() == 'KEY':
            continue
            
        col_name = tokens[0].replace('"', '').replace('`', '').strip()
        col_type = " ".join(tokens[1:]).strip()
        columns.append((col_name, col_type))
    return columns

def fix_insert_statement(ins):
    if 'INSERT INTO screens' in ins:
        match = re.match(r'INSERT INTO screens\s*\((.*?)\)\s*VALUES\s*\((.*?)\);', ins, re.DOTALL)
        if match:
            cols_str = match.group(1)
            vals_str = match.group(2)
            
            cols = [c.strip().replace('"', '') for c in cols_str.split(',')]
            
            vals = []
            current = []
            in_string = False
            string_char = None
            for char in vals_str:
                if char in ("'", '"'):
                    if not in_string:
                        in_string = True
                        string_char = char
                    elif string_char == char:
                        in_string = False
                elif char == ',' and not in_string:
                    vals.append("".join(current).strip())
                    current = []
                    continue
                current.append(char)
            if current:
                vals.append("".join(current).strip())
                
            if len(cols) == len(vals):
                row = dict(zip(cols, vals))
                route = row.get('route_path', 'NULL')
                if route == 'NULL' or route == "''" or route == '""':
                    scr_id = row['id']
                    scr_code = row.get('screen_code', '').replace("'", "").replace('"', '').strip()
                    if scr_code:
                        clean_route = f"/generated/{scr_code.replace('_', '-')}"
                    else:
                        clean_route = f"/generated/screen-{scr_id}"
                    row['route_path'] = f"'{clean_route}'"
                    
                    # Reconstruct statement
                    new_vals = [row[c] for c in cols]
                    new_vals_str = ", ".join(new_vals)
                    return f'INSERT INTO screens ({cols_str}) VALUES ({new_vals_str});'
    return ins

def import_data():
    print("Connecting to SQLite database...")
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    
    print(f"Reading SQL file from {SQL_PATH}...")
    with open(SQL_PATH, 'r', encoding='utf-8') as f:
        sql_content = f.read()

    # Parse column schemas directly from d1_schema.sql
    print("Checking schemas and adding missing columns dynamically...")
    for table_name in ('orgs', 'apps', 'roles', 'screens'):
        pattern = r'CREATE TABLE ' + table_name + r'\s*\(.*?\);'
        match = re.search(pattern, sql_content, re.DOTALL)
        if match:
            columns = parse_create_table_cols(match.group(0))
            print(f"Table '{table_name}': found {len(columns)} columns in SQL schema.")
            ensure_columns(cur, table_name, columns)
            
    # Disable foreign keys temporarily for clean insertion
    cur.execute("PRAGMA foreign_keys = OFF;")
    
    # Clear tables
    print("Clearing tables orgs, apps, roles, screens and dependent registries...")
    tables_to_clear = [
        "screens", "roles", "apps", "orgs",
        "screen_functions", "screen_components", 
        "role_function_permissions", "role_screen_permissions",
        "sidebar_items", "package_files", "artifact_ownership",
        "router_mounts", "layout_bindings"
    ]
    for tbl in tables_to_clear:
        cur.execute(f"DELETE FROM [{tbl}];")
    
    # Find all INSERT INTO statements
    print("Parsing INSERT statements...")
    inserts = re.findall(r'(INSERT INTO (?:screens|roles|apps|orgs) .*?;)', sql_content, re.DOTALL)
    print(f"Found {len(inserts)} INSERT statements to process.")
    
    executed = 0
    errors_by_table = {}
    
    for ins in inserts:
        fixed_ins = fix_insert_statement(ins)
        
        table_match = re.search(r'INSERT INTO (\w+)', fixed_ins)
        table_name = table_match.group(1) if table_match else 'unknown'
        
        try:
            cur.execute(fixed_ins)
            executed += 1
        except Exception as e:
            err_msg = str(e)
            errors_by_table.setdefault(table_name, []).append((err_msg, fixed_ins[:120] + "..."))
            
    print(f"Executed {executed} inserts successfully.")
    
    # Report Errors
    if errors_by_table:
        print("\n--- Error Summary ---")
        for tbl, errs in errors_by_table.items():
            print(f"Table '{tbl}': {len(errs)} failures.")
            msgs = Counter([e[0] for e in errs])
            for msg, cnt in msgs.items():
                print(f"  - {cnt} times: {msg}")
            print("  - Examples of failed statements:")
            for msg, stmt in errs[:2]:
                print(f"    * {stmt} -> {msg}")
    else:
        print("\nNo errors occurred during insertion.")
            
    # Set default values for added columns
    print("\nInitializing is_route_active flag for route-populated screens...")
    cur.execute("""
        UPDATE screens 
        SET is_route_active = 1 
        WHERE route_path IS NOT NULL 
          AND route_path != '' 
          AND route_path != 'NULL'
          AND route_path NOT LIKE '/unmapped/%';
    """)
    print(f"Flagged {cur.rowcount} active routes.")
    
    cur.execute("""
        UPDATE screens 
        SET is_route_active = 0 
        WHERE route_path LIKE '/unmapped/%';
    """)
    print(f"Flagged {cur.rowcount} inactive/unmapped routes.")

    # Resolve default role IDs
    cur.execute("SELECT id FROM roles WHERE role_code = 'guest' LIMIT 1;")
    guest_row = cur.fetchone()
    guest_role_id = guest_row[0] if guest_row else 13

    # Set default role_id for screens where role_id is NULL
    cur.execute("""
        UPDATE screens
        SET role_id = ?
        WHERE role_id IS NULL;
    """, (guest_role_id,))
    print(f"Assigned default role_id to {cur.rowcount} screens.")

    # Populate role_screen_permissions based on screens.role_id
    print("Populating role_screen_permissions for imported screens with role assignments...")
    cur.execute("DELETE FROM role_screen_permissions;")
    cur.execute("""
        INSERT INTO role_screen_permissions (role_id, screen_id, can_view, can_create, can_edit, can_delete, can_export)
        SELECT role_id, id, 1, 1, 1, 1, 1
        FROM screens
        WHERE role_id IS NOT NULL;
    """)
    print(f"Seeded {cur.rowcount} permissions into role_screen_permissions.")
    
    # Re-enable foreign keys and commit
    cur.execute("PRAGMA foreign_keys = ON;")
    conn.commit()
    
    # Verify count
    screens_count = cur.execute("SELECT count(*) FROM screens;").fetchone()[0]
    roles_count = cur.execute("SELECT count(*) FROM roles;").fetchone()[0]
    apps_count = cur.execute("SELECT count(*) FROM apps;").fetchone()[0]
    permissions_count = cur.execute("SELECT count(*) FROM role_screen_permissions;").fetchone()[0]
    
    conn.close()
    print("\nVerification Summary:")
    print(f"  Screens: {screens_count}")
    print(f"  Roles: {roles_count}")
    print(f"  Apps: {apps_count}")
    print(f"  Permissions: {permissions_count}")
    
def main():
    backup_db()
    import_data()

if __name__ == '__main__':
    main()
