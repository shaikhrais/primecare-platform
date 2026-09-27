# scripts/test_release_readiness.py
import os
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("=== RUNNING: Platform Release Readiness Compliance Testing ===")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Query latest governance health overall score
    cursor.execute("SELECT overall_score FROM governance_health_scores LIMIT 1;")
    overall_score = cursor.fetchone()[0]

    # Verify that there are 0 critical bugs in implementation_tasks
    cursor.execute("SELECT COUNT(*) FROM implementation_tasks WHERE priority = 'critical' AND status = 'pending';")
    critical_bugs_count = cursor.fetchone()[0]

    # Verify that all 541 screens are fully verified
    cursor.execute("SELECT COUNT(*) FROM screens WHERE verification_status != 'fully_verified';")
    unverified_screens_count = cursor.fetchone()[0]

    passed = (overall_score >= 95.0) and (critical_bugs_count == 0) and (unverified_screens_count == 0)
    print(f"Overall Governance Health Score: {overall_score}%")
    print(f"Pending Critical Bugs: {critical_bugs_count}")
    print(f"Unverified Screens: {unverified_screens_count}")

    output = {
        "test_suite": "test_release_readiness",
        "overall_passed": passed,
        "timestamp": datetime.now().isoformat(),
        "overall_score": overall_score,
        "critical_bugs_count": critical_bugs_count,
        "unverified_screens_count": unverified_screens_count,
    }

    with open(os.path.join(PROJECT_ROOT, "release_readiness_result.json"), "w", encoding="utf-8") as out_f:
        json.dump(output, out_f, indent=2)
    print("Saved results to release_readiness_result.json")
    
    conn.close()
    if not passed:
        sys.exit(1)

if __name__ == '__main__':
    main()
