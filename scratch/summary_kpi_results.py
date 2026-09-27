import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- LATEST E2E SWEEP RESULTS IN THE DB ---")
    cursor.execute("""
        SELECT kpi_code, kpi_status, max(measured_at) as last_measured
        FROM kpi_results
        GROUP BY kpi_code
        ORDER BY last_measured DESC;
    """)
    rows = cursor.fetchall()
    if not rows:
        print("No E2E results recorded yet.")
    else:
        for r in rows:
            print(f"KPI: {r['kpi_code']:<40} | Status: {r['kpi_status']:<10} | Measured: {r['last_measured']}")
            
    conn.close()

if __name__ == '__main__':
    main()
