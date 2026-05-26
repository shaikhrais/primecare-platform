# scripts/test_kpi_performance.py
import os
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("=== RUNNING: 541 Screens Performance SLAs Compliance Testing ===")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Query screens that do not meet performance criteria
    cursor.execute("""
        SELECT COUNT(*) FROM screens 
        WHERE performance_status = 'slow' OR avg_load_time_ms > 120 OR avg_render_time_ms > 20;
    """)
    slow_count = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM screens;")
    total_screens = cursor.fetchone()[0]

    passed = (slow_count == 0)
    print(f"Total Screens audited: {total_screens}")
    print(f"Screens failing performance SLAs (slow or latencies high): {slow_count}")

    output = {
        "test_suite": "test_kpi_performance",
        "overall_passed": passed,
        "timestamp": datetime.now().isoformat(),
        "total_screens": total_screens,
        "slow_count": slow_count,
    }

    with open(os.path.join(PROJECT_ROOT, "kpi_performance_result.json"), "w", encoding="utf-8") as out_f:
        json.dump(output, out_f, indent=2)
    print("Saved results to kpi_performance_result.json")
    
    conn.close()
    if not passed:
        sys.exit(1)

if __name__ == '__main__':
    main()
