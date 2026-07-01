import os
import sqlite3
import json

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("RUNNING GOVERNANCE DATABASE SCHEMA MIGRATION & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. Backup and drop old screen_api_map table if it exists and hasn't been migrated yet
    c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='screen_api_map'")
    has_old_map = c.fetchone()
    
    # Check if the screen_api_map already has api_usage (which would mean it's already migrated)
    is_migrated = False
    if has_old_map:
        c.execute("PRAGMA table_info(screen_api_map)")
        columns = [row["name"] for row in c.fetchall()]
        if "api_usage" in columns:
            is_migrated = True

    if has_old_map and not is_migrated:
        print("Backing up old screen_api_map to screen_api_map_old...")
        c.execute("DROP TABLE IF EXISTS screen_api_map_old")
        c.execute("ALTER TABLE screen_api_map RENAME TO screen_api_map_old")

    # 2. Create the new tables
    print("Creating api_registry table...")
    c.execute("""
    CREATE TABLE IF NOT EXISTS api_registry (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      api_code TEXT UNIQUE NOT NULL,
      api_name TEXT NOT NULL,
      app_id INTEGER,
      domain TEXT,
      method TEXT NOT NULL,
      endpoint_path TEXT NOT NULL,
      full_url TEXT,
      request_schema_json TEXT,
      response_schema_json TEXT,
      auth_required INTEGER DEFAULT 1,
      role_required TEXT,
      status TEXT DEFAULT 'planned',
      owner TEXT,
      notes TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    print("Creating new screen_api_map table...")
    c.execute("""
    CREATE TABLE IF NOT EXISTS screen_api_map (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      api_id INTEGER NOT NULL,
      api_usage TEXT NOT NULL,
      required INTEGER DEFAULT 1,
      fallback_behavior TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (screen_id) REFERENCES screens (id),
      FOREIGN KEY (api_id) REFERENCES api_registry (id)
    );
    """)

    print("Creating api_test_definitions table...")
    c.execute("""
    CREATE TABLE IF NOT EXISTS api_test_definitions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      api_id INTEGER NOT NULL,
      test_code TEXT UNIQUE NOT NULL,
      test_name TEXT NOT NULL,
      test_type TEXT DEFAULT 'smoke',
      enabled INTEGER DEFAULT 1,
      expected_status_code INTEGER DEFAULT 200,
      request_body_json TEXT,
      expected_response_keys_json TEXT,
      forbidden_response_keys_json TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (api_id) REFERENCES api_registry (id)
    );
    """)

    print("Creating api_test_results table...")
    c.execute("""
    CREATE TABLE IF NOT EXISTS api_test_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      api_test_definition_id INTEGER NOT NULL,
      api_id INTEGER NOT NULL,
      run_id TEXT NOT NULL,
      status TEXT NOT NULL,
      status_code INTEGER,
      error_message TEXT,
      response_time_ms INTEGER,
      response_sample_path TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (api_test_definition_id) REFERENCES api_test_definitions (id),
      FOREIGN KEY (api_id) REFERENCES api_registry (id)
    );
    """)
    conn.commit()

    # 3. Migrate old apis to api_registry if apis table exists
    c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='apis'")
    has_apis_table = c.fetchone()
    if has_apis_table:
        print("Migrating records from apis to api_registry...")
        c.execute("SELECT * FROM apis")
        apis_rows = c.fetchall()
        for row in apis_rows:
            api_code = row["api_code"]
            api_name = row["api_name"]
            endpoint = row["endpoint"]
            method = row["method"]
            active = row["active"]
            
            status = 'mocked' if active else 'planned'
            
            c.execute("""
                INSERT OR IGNORE INTO api_registry (
                    id, api_code, api_name, method, endpoint_path, status, auth_required
                ) VALUES (?, ?, ?, ?, ?, ?, 1)
            """, (row["id"], api_code, api_name, method, endpoint, status))
        print(f"Migrated {len(apis_rows)} API records.")
        conn.commit()

    # 4. Migrate old screen_api_map records
    c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='screen_api_map_old'")
    has_old_map_table = c.fetchone()
    if has_old_map_table:
        print("Migrating records from screen_api_map_old to new screen_api_map...")
        c.execute("SELECT * FROM screen_api_map_old")
        old_maps = c.fetchall()
        for row in old_maps:
            c.execute("""
                INSERT INTO screen_api_map (screen_id, api_id, api_usage, required)
                VALUES (?, ?, 'load_list', ?)
            """, (row["screen_id"], row["api_id"], row["required"]))
        print(f"Migrated {len(old_maps)} mapping records.")
        conn.commit()

    # 5. Systematically seed APIs and mappings for all 948 screens
    print("Seeding missing API connections and mappings for all screens...")
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.app_id, s.role_id, r.role_code
        FROM screens s
        LEFT JOIN roles r ON s.role_id = r.id
    """)
    screens = c.fetchall()
    
    apis_seeded_count = 0
    maps_seeded_count = 0
    
    for scr in screens:
        scr_id = scr["id"]
        scr_code = scr["screen_code"]
        scr_name = scr["screen_name"]
        app_id = scr["app_id"]
        role_id = scr["role_id"]
        role_code = scr["role_code"] or "guest"
        
        # Check if this screen already has API mappings
        c.execute("SELECT COUNT(*) FROM screen_api_map WHERE screen_id = ?", (scr_id,))
        existing_maps_count = c.fetchone()[0]
        if existing_maps_count > 0:
            continue
            
        # Determine logical APIs based on role and screen type
        # We will generate a GET list API, a POST create API, and a PATCH update API
        is_public = any(k in scr_code.lower() for k in ["login", "signup", "register", "forgot_password", "reset_password", "mfa"])
        auth_req = 0 if is_public else 1
        
        generated_apis = []
        if is_public:
            # Login/Register operations
            if "login" in scr_code.lower():
                generated_apis.append({
                    "code": f"auth_login_post",
                    "name": "Auth User Login",
                    "method": "POST",
                    "path": "/v1/auth/login",
                    "usage": "login"
                })
            elif "register" in scr_code.lower() or "signup" in scr_code.lower():
                generated_apis.append({
                    "code": f"auth_register_post",
                    "name": "Auth User Registration",
                    "method": "POST",
                    "path": "/v1/auth/register",
                    "usage": "submit_form"
                })
            else:
                generated_apis.append({
                    "code": f"auth_{scr_code}_post",
                    "name": f"Auth {scr_name} API",
                    "method": "POST",
                    "path": f"/v1/auth/{scr_code.replace('_', '-')}",
                    "usage": "submit_form"
                })
        else:
            # Standard data-driven screens
            # 1. GET List
            generated_apis.append({
                "code": f"{role_code}_{scr_code}_get",
                "name": f"Load {scr_name} List Data",
                "method": "GET",
                "path": f"/v1/{role_code}/{scr_code.replace('_', '-')}",
                "usage": "load_list"
            })
            # 2. POST Create
            generated_apis.append({
                "code": f"{role_code}_{scr_code}_post",
                "name": f"Create {scr_name} Record",
                "method": "POST",
                "path": f"/v1/{role_code}/{scr_code.replace('_', '-')}",
                "usage": "create_record"
            })
            # 3. PATCH Update
            generated_apis.append({
                "code": f"{role_code}_{scr_code}_patch",
                "name": f"Update {scr_name} Record",
                "method": "PATCH",
                "path": f"/v1/{role_code}/{scr_code.replace('_', '-')}/:id",
                "usage": "update_record"
            })
            
        for api in generated_apis:
            # Insert into api_registry if it doesn't exist
            c.execute("SELECT id FROM api_registry WHERE api_code = ?", (api["code"],))
            api_row = c.fetchone()
            if api_row:
                api_id = api_row["id"]
            else:
                c.execute("""
                    INSERT INTO api_registry (
                        api_code, api_name, app_id, method, endpoint_path, status, auth_required, role_required
                    ) VALUES (?, ?, ?, ?, ?, 'mocked', ?, ?)
                """, (api["code"], api["name"], app_id, api["method"], api["path"], auth_req, role_code))
                api_id = c.lastrowid
                apis_seeded_count += 1
                
                # Seed a default api_test_definitions for this API
                test_code = f"test_{api['code']}"
                test_name = f"Verify {api['name']}"
                exp_code = 201 if api["method"] == "POST" else 200
                exp_keys = json.dumps(["status", "data"] if api["method"] == "POST" else ["status", "data"])
                c.execute("""
                    INSERT OR IGNORE INTO api_test_definitions (
                        api_id, test_code, test_name, test_type, expected_status_code, expected_response_keys_json
                    ) VALUES (?, ?, ?, 'smoke', ?, ?)
                """, (api_id, test_code, test_name, exp_code, exp_keys))

            # Create mapping
            c.execute("""
                INSERT INTO screen_api_map (screen_id, api_id, api_usage, required)
                VALUES (?, ?, ?, 1)
            """, (scr_id, api_id, api["usage"]))
            maps_seeded_count += 1
            
    conn.commit()
    print(f"Seeded {apis_seeded_count} new APIs and {maps_seeded_count} mappings in the database.")

    # 6. Cleanup deprecated tables
    if has_apis_table:
        print("Cleaning up old apis table...")
        c.execute("DROP TABLE IF EXISTS apis")
    if has_old_map_table:
        print("Cleaning up old screen_api_map_old table...")
        c.execute("DROP TABLE IF EXISTS screen_api_map_old")
    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("SCHEMA MIGRATION & SEEDING COMPLETE!")
    print("==============================================================")

if __name__ == "__main__":
    main()
