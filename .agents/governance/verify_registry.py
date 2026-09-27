import sys
import os
import sqlite3
import re

# Ensure unicode safe terminal output on Windows console
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

print("=====================================================")
print("CI/CD Compliance: Verifying Codebase-to-Database Sync")
print("=====================================================")

gov_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(gov_dir, "governance.db")
screens_dir = os.path.join(os.path.dirname(os.path.dirname(gov_dir)), "packages", "primecare_ui", "lib", "src", "screens")

if not os.path.exists(db_path):
    print(f"[FATAL] SQLite database not found at: {db_path}")
    sys.exit(1)

if not os.path.exists(screens_dir):
    print(f"[FATAL] UI screens directory not found at: {screens_dir}")
    sys.exit(1)

def find_dashboard_files(directory):
    files = []
    for root, _, filenames in os.walk(directory):
        for name in filenames:
            name_lower = name.lower()
            if name_lower.endswith('_dashboard_screen.dart') or name_lower.endswith('_dashboard.dart'):
                files.append(os.path.join(root, name))
    return files

def camel_to_snake(input_str):
    return re.sub(r'(?<=[a-z])[A-Z]', lambda m: '_' + m.group(0), input_str).lower()

# 1. Discover physical dashboard screen files on disk
physical_files = find_dashboard_files(screens_dir)
print(f"Found {len(physical_files)} physical dashboard files on disk.")

# 2. Extract expected screen codes from physical class names
expected_screens = {}
for path in physical_files:
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except Exception as e:
        print(f"[ERROR] Failed to read file {path}: {e}")
        continue

    # Identify class name
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

    if class_name.endswith('Screen'):
        screen_code = camel_to_snake(class_name[:-6])
    elif class_name.endswith('Controller'):
        screen_code = camel_to_snake(class_name[:-10])
    elif class_name.endswith('Notifier'):
        screen_code = camel_to_snake(class_name[:-8])
    else:
        screen_code = camel_to_snake(class_name)

    rel_path = os.path.relpath(path, os.path.dirname(os.path.dirname(gov_dir))).replace('\\', '/')
    expected_screens[screen_code] = {
        'class_name': class_name,
        'rel_path': rel_path
    }

# 3. Connect to Database and query registered screens
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

cursor.execute("SELECT screen_code, screen_name, route_path FROM screens WHERE screen_type = 'dashboard';")
db_screens = {row['screen_code']: dict(row) for row in cursor.fetchall()}
conn.close()

# 4. Compare and find drifts
drifts = []
for code, details in expected_screens.items():
    if code not in db_screens:
        drifts.append(f"MISSING REGISTRATION: Screen class '{details['class_name']}' at '{details['rel_path']}' is not registered in the 'screens' database table (expected code: '{code}').")

if drifts:
    print("\n[🔴 FAILED] SOFTWARE GOVERNANCE REGISTRY DRIFT DETECTED!")
    for d in drifts:
        print(f"  - {d}")
    print("\n[TIP] Please re-run database seeder and sweeps to reconcile automatically:")
    print("  python .agents/governance/migrate_to_sqlite.py")
    print("  python .agents/governance/reconcile_db.py")
    sys.exit(1)

print("\n[🟢 SUCCESS] All physical dashboard screens are 100% synchronized and registered in the database.")
sys.exit(0)
