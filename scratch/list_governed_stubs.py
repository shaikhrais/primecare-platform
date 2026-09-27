import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

print("=== DATA_CONNECTED STAGE SCREENS ===")
cursor.execute("SELECT id, screen_name, file_path, current_stage, status FROM screen_governance WHERE current_stage = 'DATA_CONNECTED'")
for r in cursor.fetchall():
    print(f"ID: {r['id']} | Name: {r['screen_name']} | Path: {r['file_path']} | Stage: {r['current_stage']} | Status: {r['status']}")

print("\n=== PARTIAL_UI STAGE SCREENS ===")
cursor.execute("SELECT id, screen_name, file_path, current_stage, status FROM screen_governance WHERE current_stage = 'PARTIAL_UI'")
for r in cursor.fetchall():
    print(f"ID: {r['id']} | Name: {r['screen_name']} | Path: {r['file_path']} | Stage: {r['current_stage']} | Status: {r['status']}")

print("\n=== DEFAULT_CODE STAGE SCREENS ===")
cursor.execute("SELECT id, screen_name, file_path, current_stage, status FROM screen_governance WHERE current_stage = 'DEFAULT_CODE'")
for r in cursor.fetchall():
    print(f"ID: {r['id']} | Name: {r['screen_name']} | Path: {r['file_path']} | Stage: {r['current_stage']} | Status: {r['status']}")

conn.close()
