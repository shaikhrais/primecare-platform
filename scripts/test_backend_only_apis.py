# scripts/test_backend_only_apis.py
import os
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("=== RUNNING: 245 Backend-Only APIs Verification & Leaks Audit ===")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Count backend-only APIs
    cursor.execute("SELECT COUNT(*) FROM api_endpoints WHERE is_backend_only = 1;")
    backend_only_count = cursor.fetchone()[0]

    # 2. Check for leaks in screens view
    cursor.execute("""
        SELECT COUNT(*) FROM v_screen_endpoint_refs ref
        JOIN api_endpoints api ON api.route_path = ref.normalized_api_route AND api.http_method = ref.screen_api_method
        WHERE api.is_backend_only = 1;
    """)
    leaks_count = cursor.fetchone()[0]

    # 3. Check for linked test cases
    cursor.execute("""
        SELECT COUNT(DISTINCT api.id) FROM api_endpoints api
        LEFT JOIN test_cases tc ON tc.related_api_id = api.id
        WHERE api.is_backend_only = 1 AND tc.id IS NOT NULL;
    """)
    tested_backend_count = cursor.fetchone()[0]

    passed = (leaks_count == 0) and (backend_only_count == 245)
    print(f"Backend-Only APIs total count in registry: {backend_only_count}")
    print(f"Backend-Only APIs leaked to visual screens: {leaks_count}")
    print(f"Backend-Only APIs with automated test cases: {tested_backend_count}")

    output = {
        "test_suite": "test_backend_only_apis",
        "overall_passed": passed,
        "timestamp": datetime.now().isoformat(),
        "backend_only_count": backend_only_count,
        "leaks_count": leaks_count,
        "tested_backend_count": tested_backend_count,
    }

    with open(os.path.join(PROJECT_ROOT, "backend_only_apis_result.json"), "w", encoding="utf-8") as out_f:
        json.dump(output, out_f, indent=2)
    print("Saved results to backend_only_apis_result.json")
    
    conn.close()
    if not passed:
        sys.exit(1)

if __name__ == '__main__':
    main()
