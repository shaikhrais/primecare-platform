import sqlite3
import sys
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

if not os.path.exists(db_path):
    print("DB not found")
    sys.exit(1)

def usage():
    print("Usage: python filter_screens.py <stage_or_status>")
    print("Available stages: FOUND, DEFAULT_CODE, PARTIAL_UI, DATA_CONNECTED, VALIDATED, FINAL_FURNISHED")
    print("Available status: MISSING_FILE, DEFAULT_CODE, NEEDS_UI, NEEDS_API, NEEDS_VALIDATION, READY_FOR_QA, FINAL_FURNISHED")
    sys.exit(1)

if len(sys.argv) < 2:
    usage()

filter_val = sys.argv[1].upper()

conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

# Query by stage or status
cursor.execute("""
    SELECT id, screen_name, route_path, file_path, current_stage, status, notes 
    FROM screen_governance 
    WHERE UPPER(current_stage) = ? OR UPPER(status) = ?
    ORDER BY id
""", (filter_val, filter_val))

rows = cursor.fetchall()
print(f"Found {len(rows)} screens matching '{filter_val}':")
print("-" * 100)
for r in rows:
    print(f"ID: {r['id']} | Name: {r['screen_name']} | Stage: {r['current_stage']} | Status: {r['status']}")
    print(f"  Route: {r['route_path']}")
    print(f"  File: {r['file_path']}")
    if r['notes']:
        print(f"  Notes: {r['notes']}")
    print("-" * 100)

conn.close()
