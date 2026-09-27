import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

tables = [
    'themes', 'design_tokens', 'apps', 'roles', 'screens',
    'sidebar_items', 'topbar_items', 'screen_sections',
    'screen_section_elements', 'features', 'screen_feature_map',
    'api_registry', 'screen_api_map', 'screen_theme_map', 'sidebar_route_map', 'topbar_action_map'
]

for table in tables:
    try:
        c.execute(f"PRAGMA table_info({table})")
        columns = [row[1] for row in c.fetchall()]
        print(f"Table '{table}':")
        print(f"  Columns: {', '.join(columns)}")
    except Exception as e:
        print(f"Error reading '{table}': {e}")

conn.close()
