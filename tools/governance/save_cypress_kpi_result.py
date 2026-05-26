import json
import sqlite3
import sys
from datetime import datetime
from pathlib import Path

DB_PATH = ".agents/governance/governance.db"

def main():
    kpi_code = sys.argv[1] if len(sys.argv) > 1 else "cypress_unknown"
    status = sys.argv[2] if len(sys.argv) > 2 else "failed"
    proof_path = sys.argv[3] if len(sys.argv) > 3 else ""

    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    proof = {
        "kpi_code": kpi_code,
        "status": status,
        "proof_path": proof_path,
        "measured_at": datetime.utcnow().isoformat()
    }

    cur.execute("""
        INSERT INTO kpi_results
        (kpi_code, kpi_name, kpi_value, kpi_status, proof_json, proof_log_path, measured_at)
        VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
    """, (
        kpi_code,
        kpi_code.replace("_", " ").title(),
        status,
        status,
        json.dumps(proof),
        proof_path
    ))

    conn.commit()
    conn.close()
    print(f"Saved KPI result: {kpi_code} = {status}")

if __name__ == "__main__":
    main()
