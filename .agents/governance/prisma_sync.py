import os
import sys
import re

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def sync():
    print("Starting SQL-Backed Prisma Sync into Governance Engine...")
    
    schema_path = 'packages/database/generated/client/schema.prisma'
    
    if not os.path.exists(schema_path):
        print(f"Error: Could not locate schema.prisma at {schema_path}")
        sys.exit(1)
        
    with open(schema_path, 'r', encoding='utf-8') as f:
        schema_lines = f.readlines()
        
    conn = governance_db.get_connection()
    cursor = conn.cursor()
    
    # 1. Ensure referential integrity stubs exist if needed
    # Check/insert stub intent
    cursor.execute("SELECT 1 FROM intents WHERE intent_id = 'UNMAPPED_SYNC';")
    if not cursor.fetchone():
        cursor.execute("""
        INSERT INTO intents (intent_id, business_goal, status)
        VALUES ('UNMAPPED_SYNC', 'Auto-synced pending intent mapping', 'pending_stub');
        """)
        
    # Check/insert stub page
    cursor.execute("SELECT 1 FROM pages WHERE page_id = 'UNMAPPED_SYNC';")
    if not cursor.fetchone():
        cursor.execute("""
        INSERT INTO pages (page_id, linked_intent, implementation_status)
        VALUES ('UNMAPPED_SYNC', 'UNMAPPED_SYNC', 'pending_stub');
        """)
    
    conn.commit()
    
    current_model = None
    scalar_types = {'String', 'Boolean', 'Int', 'BigInt', 'Float', 'Decimal', 'DateTime', 'Json', 'Bytes'}
    
    synced_count = 0
    
    for line in schema_lines:
        trimmed = line.strip()
        if trimmed.startswith('model '):
            current_model = trimmed.split(' ')[1]
        elif trimmed.startswith('}') and current_model is not None:
            current_model = None
        elif current_model is not None and trimmed and not trimmed.startswith('//') and not trimmed.startswith('@@'):
            parts = re.split(r'\s+', trimmed)
            if len(parts) >= 2:
                field_name = parts[0]
                field_type = parts[1]
                
                # Remove modifiers
                base_type = field_type.replace('?', '').replace('[]', '')
                
                if base_type in scalar_types or '@db.' in field_type:
                    entry_id = f"{current_model.lower()}_{field_name}_input"
                    
                    # Check if this field_id already exists in fields table
                    cursor.execute("SELECT 1 FROM fields WHERE field_id = ?;", (entry_id,))
                    if not cursor.fetchone():
                        cursor.execute("""
                        INSERT INTO fields (
                            field_id, page_id, linked_intent, validation, 
                            api_endpoint, service_method, database_table, database_column, status
                        ) VALUES (?, 'UNMAPPED_SYNC', 'UNMAPPED_SYNC', ?, 'SYNC PENDING', 'SYNC PENDING', ?, ?, 'pending');
                        """, (entry_id, f"auto_sync_type_{base_type}", current_model, field_name))
                        synced_count += 1
                        
    if synced_count > 0:
        conn.commit()
        print(f"[OK] Successfully synced {synced_count} schema fields into the SQL Fields Table.")
    else:
        print("No new fields to sync.")
        
    conn.close()

if __name__ == "__main__":
    sync()
