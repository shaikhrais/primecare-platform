# scripts/test_screen_endpoint_mapping.py
import os
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("=== RUNNING: Database View Screen-API Endpoint Mappings Validation ===")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Query view for mismatches
    cursor.execute("""
        SELECT COUNT(*) FROM v_screen_endpoint_readiness 
        WHERE endpoint_readiness_status != 'ready';
    """)
    unready_count = cursor.fetchone()[0]

    cursor.execute("""
        SELECT COUNT(*) FROM v_screen_endpoint_refs;
    """)
    total_refs = cursor.fetchone()[0]

    passed = (unready_count == 0)
    print(f"Total screen API references scanned: {total_refs}")
    print(f"Unready/mismatching endpoint mappings: {unready_count}")

    output = {
        "test_suite": "test_screen_endpoint_mapping",
        "overall_passed": passed,
        "timestamp": datetime.now().isoformat(),
        "total_references": total_refs,
        "unready_mappings": unready_count,
    }

    with open(os.path.join(PROJECT_ROOT, "screen_endpoint_mapping_result.json"), "w", encoding="utf-8") as out_f:
        json.dump(output, out_f, indent=2)
    print("Saved results to screen_endpoint_mapping_result.json")
    
    conn.close()
    if not passed:
        sys.exit(1)

if __name__ == '__main__':
    main()
