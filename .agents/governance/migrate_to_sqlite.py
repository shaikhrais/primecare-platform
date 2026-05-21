import yaml
import sys
import os
import json

# Add local directory to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def migrate():
    print("=====================================================")
    print("Starting PrimeCare Registries to SQLite Migration")
    print("=====================================================")

    # Initialize SQLite schemas (with force reset to ensure a clean database)
    governance_db.init_db(force_reset=True)
    conn = governance_db.get_connection()
    cursor = conn.cursor()

    gov_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance"
    
    # 1. Migrate Sidebar Inventories
    sidebar_yaml = os.path.join(gov_dir, "sidebar_inventory.yaml")
    if os.path.exists(sidebar_yaml):
        print("Migrating sidebar_inventory.yaml...")
        with open(sidebar_yaml, 'r', encoding='utf-8') as f:
            sidebar_data = yaml.safe_load(f) or {}
        
        sidebars = sidebar_data.get('sidebars', [])
        for sb in sidebars:
            screen_id = sb.get('screen_id')
            screen_name = sb.get('screen_name')
            path = sb.get('path')
            requires_sidebar = 1 if sb.get('requires_sidebar') else 0
            
            # Extract category from file path
            parts = path.split('/')
            category = parts[5] if len(parts) >= 6 else "common"
            
            cursor.execute("""
            INSERT OR REPLACE INTO dashboards (screen_id, screen_name, path, requires_sidebar, category, layout_compliant)
            VALUES (?, ?, ?, ?, ?, 1)
            """, (screen_id, screen_name, path, requires_sidebar, category))
            
            sidebar_items = sb.get('sidebar_items', [])
            for item in sidebar_items:
                item_id = item.get('id')
                label = item.get('label')
                type_ = item.get('type', 'quick_action')
                expected_handler = item.get('expected_handler', '')
                status = item.get('status', 'pending')
                
                cursor.execute("""
                INSERT OR REPLACE INTO sidebar_items (screen_id, item_id, label, type, expected_handler, status)
                VALUES (?, ?, ?, ?, ?, ?)
                """, (screen_id, item_id, label, type_, expected_handler, status))
        print(f"[OK] Migrated {len(sidebars)} dashboards successfully.")
    else:
        print("[WARN] sidebar_inventory.yaml not found, skipping sidebars migration.")

    # 2. Migrate Intents
    intents_yaml = os.path.join(gov_dir, "intent_register.yaml")
    if os.path.exists(intents_yaml):
        print("Migrating intent_register.yaml...")
        with open(intents_yaml, 'r', encoding='utf-8') as f:
            intents_data = yaml.safe_load(f) or {}
            
        intents = intents_data.get('intents', [])
        # Fallback if structure is a flat list
        if not intents and isinstance(intents_data, list):
            intents = intents_data
            
        for it in intents:
            intent_id = it.get('id')
            business_goal = it.get('business_goal', '')
            status = it.get('implementation_status', 'pending')
            
            cursor.execute("""
            INSERT OR REPLACE INTO intents (intent_id, business_goal, status)
            VALUES (?, ?, ?)
            """, (intent_id, business_goal, status))
        print(f"[OK] Migrated {len(intents)} business intents successfully.")
    else:
        print("[WARN] intent_register.yaml not found, skipping intents migration.")

    # 3. Migrate Pages
    pages_yaml = os.path.join(gov_dir, "page_inventory.yaml")
    if os.path.exists(pages_yaml):
        print("Migrating page_inventory.yaml...")
        with open(pages_yaml, 'r', encoding='utf-8') as f:
            pages_data = yaml.safe_load(f) or {}
            
        pages = pages_data.get('pages', [])
        if not pages and isinstance(pages_data, list):
            pages = pages_data
            
        for pg in pages:
            page_id = pg.get('id')
            route = pg.get('route')
            name = pg.get('name')
            label = pg.get('label')
            route_var = pg.get('route_var')
            icon_var = pg.get('icon_var')
            section = pg.get('section')
            role_allowed = json.dumps(pg.get('role_allowed') or [])
            actions = json.dumps(pg.get('actions') or [])
            labels = json.dumps(pg.get('labels') or {})
            
            linked_intent = pg.get('linked_intent')
            if not linked_intent:
                linked_intent = None
            else:
                cursor.execute("SELECT 1 FROM intents WHERE intent_id = ?", (linked_intent,))
                if not cursor.fetchone():
                    print(f"[WARN] Page {page_id} links to non-existent intent '{linked_intent}'. Creating stub intent.")
                    cursor.execute("""
                    INSERT INTO intents (intent_id, business_goal, status)
                    VALUES (?, ?, 'pending_stub')
                    """, (linked_intent, f"Stub created for missing intent referenced by page {page_id}"))
            
            status = pg.get('implementation_status', 'pending')
            
            cursor.execute("""
            INSERT OR REPLACE INTO pages (page_id, route, name, label, route_var, icon_var, section, role_allowed, actions, labels, linked_intent, implementation_status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (page_id, route, name, label, route_var, icon_var, section, role_allowed, actions, labels, linked_intent, status))
        print(f"[OK] Migrated {len(pages)} pages successfully.")
    else:
        print("[WARN] page_inventory.yaml not found, skipping pages migration.")

    # 4. Migrate Fields
    fields_yaml = os.path.join(gov_dir, "data_entry_map.yaml")
    if os.path.exists(fields_yaml):
        print("Migrating data_entry_map.yaml...")
        with open(fields_yaml, 'r', encoding='utf-8') as f:
            fields_data = yaml.safe_load(f) or {}
            
        fields = fields_data.get('fields', [])
        if not fields and isinstance(fields_data, list):
            fields = fields_data
            
        for fd in fields:
            field_id = fd.get('id')
            page_id = fd.get('page')
            if not page_id:
                page_id = None
            else:
                cursor.execute("SELECT 1 FROM pages WHERE page_id = ?", (page_id,))
                if not cursor.fetchone():
                    print(f"[WARN] Field {field_id} links to non-existent page '{page_id}'. Creating stub page.")
                    cursor.execute("""
                    INSERT INTO pages (page_id, linked_intent, implementation_status)
                    VALUES (?, NULL, 'pending_stub')
                    """, (page_id,))

            linked_intent = fd.get('linked_intent')
            if not linked_intent:
                linked_intent = None
            else:
                cursor.execute("SELECT 1 FROM intents WHERE intent_id = ?", (linked_intent,))
                if not cursor.fetchone():
                    print(f"[WARN] Field {field_id} links to non-existent intent '{linked_intent}'. Creating stub intent.")
                    cursor.execute("""
                    INSERT INTO intents (intent_id, business_goal, status)
                    VALUES (?, ?, 'pending_stub')
                    """, (linked_intent, f"Stub for missing intent referenced by field {field_id}"))

            validation = fd.get('validation', '')
            api_endpoint = fd.get('api_endpoint', '')
            service_method = fd.get('service_method', '')
            database_table = fd.get('database_table', '')
            database_column = fd.get('database_column', '')
            status = fd.get('implementation_status', 'pending')
            
            cursor.execute("""
            INSERT OR REPLACE INTO fields (field_id, page_id, linked_intent, validation, api_endpoint, service_method, database_table, database_column, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (field_id, page_id, linked_intent, validation, api_endpoint, service_method, database_table, database_column, status))
        print(f"[OK] Migrated {len(fields)} fields successfully.")
    else:
        print("[WARN] data_entry_map.yaml not found, skipping fields migration.")

    conn.commit()
    
    # Run absolute validation counts
    cursor.execute("SELECT COUNT(*) FROM dashboards;")
    d_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM sidebar_items;")
    s_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM intents;")
    i_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM pages;")
    p_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM fields;")
    f_count = cursor.fetchone()[0]
    
    conn.close()

    print("=====================================================")
    print("Migration Verification Complete:")
    print(f"  - Dashboards Inserted: {d_count}")
    print(f"  - Sidebar Items Inserted: {s_count}")
    print(f"  - Business Intents Inserted: {i_count}")
    print(f"  - Pages Inserted: {p_count}")
    print(f"  - Data Entry Fields Inserted: {f_count}")
    print("=====================================================")
    print("[OK] SUCCESS: Relational SQLite Governance Database is seeded!")
    print("=====================================================")

if __name__ == "__main__":
    migrate()
