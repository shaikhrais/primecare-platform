import os
import sqlite3
import re
from datetime import datetime

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

if not os.path.exists(db_path):
    print("DB not found at:", db_path)
    exit(1)

# Connect to DB
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

# 1. Create screen_governance and screen_stage_history tables
print("Creating tables in governance.db...")
cursor.execute("""
CREATE TABLE IF NOT EXISTS screen_governance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_name TEXT,
    route_path TEXT,
    file_path TEXT,
    current_stage TEXT,
    missing_items TEXT,
    owner TEXT,
    status TEXT,
    last_checked TEXT,
    notes TEXT
);
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS screen_stage_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_id INTEGER,
    old_stage TEXT,
    new_stage TEXT,
    changed_by TEXT,
    changed_at TEXT,
    comment TEXT,
    FOREIGN KEY (screen_id) REFERENCES screen_governance(id) ON DELETE CASCADE
);
""")
conn.commit()

# Clear existing rows to make it clean and re-runnable
cursor.execute("DELETE FROM screen_stage_history")
cursor.execute("DELETE FROM screen_governance")
cursor.execute("DELETE FROM sqlite_sequence WHERE name IN ('screen_governance', 'screen_stage_history')")
conn.commit()

# 2. Fetch all screens from screens table
cursor.execute("SELECT id, screen_name, route_path, actual_file_path, allowed_roles_text FROM screens")
screens = [dict(row) for row in cursor.fetchall()]
print(f"Fetched {len(screens)} screens from 'screens' table.")

# 3. Categorize each screen
count_by_stage = {}
count_by_status = {}

now_str = datetime.now().isoformat()

for idx, scr in enumerate(screens):
    screen_name = scr['screen_name']
    route_path = scr['route_path']
    file_path = scr['actual_file_path']
    owner = scr['allowed_roles_text'] or 'unknown'
    
    stage = 'FOUND'
    status = 'MISSING_FILE'
    missing_items = ''
    notes = ''
    
    if not file_path:
        stage = 'FOUND'
        status = 'MISSING_FILE'
        missing_items = 'Dart file path is empty/missing in registry'
        notes = 'No actual_file_path mapped'
    else:
        full_path = os.path.join(project_root, file_path.replace("/", os.sep))
        if not os.path.exists(full_path):
            stage = 'FOUND'
            status = 'MISSING_FILE'
            missing_items = f'File not found on disk: {file_path}'
            notes = 'File does not exist'
        else:
            try:
                content = open(full_path, 'r', encoding='utf-8').read()
                length = len(content)
                
                # Check for default template structure
                is_short = length < 1200
                
                # CASE-SENSITIVE checks for stub indicators to prevent matching 'placeholder' parameter names in complete forms
                has_placeholders = re.search(r'\bTODO\b|\bPlaceholder\b|\bUnimplementedError\b', content) is not None
                
                has_api = 'apiClientProvider' in content or 'FutureProvider' in content or 'StreamProvider' in content or 'api.' in content
                has_ui_elements = 'Scaffold' in content and ('Column' in content or 'Row' in content or 'ListView' in content or 'GridView' in content or 'Card' in content)
                
                if is_short and not has_api and not has_ui_elements:
                    stage = 'DEFAULT_CODE'
                    status = 'DEFAULT_CODE'
                    missing_items = 'Implement layout, styling, and data loading'
                    notes = 'Template code detected'
                elif has_placeholders:
                    if has_api:
                        stage = 'DATA_CONNECTED'
                        status = 'NEEDS_UI'
                        missing_items = 'Replace visual UI placeholders with high-fidelity components'
                        notes = 'API connected but UI has placeholders'
                    elif has_ui_elements:
                        stage = 'PARTIAL_UI'
                        status = 'NEEDS_API'
                        missing_items = 'Connect to API client and implement data binding'
                        notes = 'UI design started but lacks API/DB integration'
                    else:
                        stage = 'DEFAULT_CODE'
                        status = 'DEFAULT_CODE'
                        missing_items = 'Implement visual components and data providers'
                        notes = 'Template code with placeholders'
                else:
                    # No placeholders, long enough file
                    if has_api:
                        stage = 'FINAL_FURNISHED'
                        status = 'FINAL_FURNISHED'
                        notes = 'Fully implemented, data-connected, and furnished'
                    else:
                        # Simple page but complete (e.g., Static info or settings page)
                        stage = 'VALIDATED'
                        status = 'FINAL_FURNISHED' # Wait, if it has no placeholders, has UI/Logic, it's finished!
                        notes = 'UI complete, verified'
            except Exception as e:
                stage = 'FOUND'
                status = 'MISSING_FILE'
                missing_items = f'Failed to read file: {e}'
                notes = 'Read error'
                
    # Normalize status based on stage as per user's rules:
    # Status tags can be: MISSING_FILE, DEFAULT_CODE, NEEDS_UI, NEEDS_API, NEEDS_VALIDATION, READY_FOR_QA, FINAL_FURNISHED
    if stage == 'FOUND':
        status = 'MISSING_FILE'
    elif stage == 'DEFAULT_CODE':
        status = 'DEFAULT_CODE'
    elif stage == 'PARTIAL_UI':
        status = 'NEEDS_API'
    elif stage == 'DATA_CONNECTED':
        status = 'NEEDS_UI'
    elif stage == 'VALIDATED':
        status = 'READY_FOR_QA'
    elif stage == 'FINAL_FURNISHED':
        status = 'FINAL_FURNISHED'

    count_by_stage[stage] = count_by_stage.get(stage, 0) + 1
    count_by_status[status] = count_by_status.get(status, 0) + 1
    
    # Insert into screen_governance
    cursor.execute("""
        INSERT INTO screen_governance (
            screen_name, route_path, file_path, current_stage, missing_items, owner, status, last_checked, notes
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (screen_name, route_path, file_path, stage, missing_items, owner, status, now_str, notes))
    
    screen_id = cursor.lastrowid
    
    # Insert initial history record
    cursor.execute("""
        INSERT INTO screen_stage_history (
            screen_id, old_stage, new_stage, changed_by, changed_at, comment
        ) VALUES (?, NULL, ?, 'system', ?, 'Initial scan and classification')
    """, (screen_id, stage, now_str))

conn.commit()
conn.close()

print("\nSeeding completed successfully!")
print("\n=== STAGE DISTRIBUTION ===")
for stage, count in count_by_stage.items():
    print(f"  - {stage}: {count}")

print("\n=== STATUS TAGS DISTRIBUTION ===")
for status, count in count_by_status.items():
    print(f"  - {status}: {count}")
