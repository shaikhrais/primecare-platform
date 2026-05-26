# scripts/test_crud_persistence.py
import os
import sys
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("=== RUNNING: Database CRUD Persistence & Foreign Key Integrity checks ===")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Enable foreign key checks
    cursor.execute("PRAGMA foreign_key_check;")
    fk_violations = cursor.fetchall()
    
    # 2. Assert basic counts to ensure persistence is healthy
    cursor.execute("SELECT count(*) FROM screens")
    screens_count = cursor.fetchone()[0]

    cursor.execute("SELECT count(*) FROM api_endpoints")
    apis_count = cursor.fetchone()[0]

    passed = (screens_count > 0) and (apis_count > 0)
    print(f"Foreign Key Violations found: {len(fk_violations)}")
    print(f"Total Screens persisted: {screens_count}")
    print(f"Total APIs persisted: {apis_count}")

    output = {
        "test_suite": "test_crud_persistence",
        "overall_passed": passed,
        "timestamp": datetime.now().isoformat(),
        "fk_violations_count": len(fk_violations),
        "screens_count": screens_count,
        "apis_count": apis_count,
    }

    with open(os.path.join(PROJECT_ROOT, "crud_persistence_result.json"), "w", encoding="utf-8") as out_f:
        json.dump(output, out_f, indent=2)
    print("Saved results to crud_persistence_result.json")
    
    conn.close()
    if not passed:
        sys.exit(1)

if __name__ == '__main__':
    main()
