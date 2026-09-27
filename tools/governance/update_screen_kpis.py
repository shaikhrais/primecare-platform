import os
import re
import json
import sqlite3
from datetime import datetime
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
REPORT_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, "tools", "governance", "reports"))
Path(REPORT_DIR).mkdir(parents=True, exist_ok=True)

def main():
    print("Executing: Update Screen KPI Fields...")
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    screens = cur.execute("""
        SELECT id, screen_name, actual_file_path 
        FROM screens
        WHERE actual_file_path IS NOT NULL AND actual_file_path != '';
    """).fetchall()

    kpi_report = []
    print(f"Calculating dynamic code metrics & KPIs for {len(screens)} screens...")

    for scr in screens:
        abs_path = os.path.join(PROJECT_ROOT, scr["actual_file_path"])
        loc = 0
        complexity = 0
        comp_count = 0
        btn_count = 0
        api_count = 0

        if os.path.exists(abs_path):
            with open(abs_path, 'r', encoding='utf-8', errors='ignore') as f:
                code = f.read()
            
            lines = code.splitlines()
            loc = len([l for l in lines if l.strip()]) # Non-empty lines of code
            
            # Simple complexity: count of control structures
            complexity = len(re.findall(r"\b(if|for|switch|while|catch)\b", code))
            if complexity == 0:
                complexity = 1

            # Component count from our patterns
            comp_count = len(re.findall(r"\b(Container|Column|Row|Card|Text|ElevatedButton|OutlinedButton|TextButton|IconButton)\s*\(", code))
            btn_count = len(re.findall(r"\b(ElevatedButton|OutlinedButton|TextButton|IconButton|GestureDetector|InkWell)\s*\(", code))
            api_count = len(re.findall(r"\b(apiClient|dio|http|repository|service)\b", code))

        # Dynamic maintainability and tech debt scores
        # base maintainability = 100 - loc/8 - complexity*2
        maintainability = 100 - int(loc / 8) - (complexity * 2)
        maintainability = max(30, min(100, maintainability))

        # tech debt = loc * 0.05 + complexity * 0.2
        tech_debt = (loc * 0.05) + (complexity * 0.2)
        tech_debt = round(tech_debt, 1)

        cur.execute("""
            UPDATE screens
            SET estimated_loc = ?,
                complexity_score = ?,
                maintainability_score = ?,
                technical_debt_score = ?,
                real_component_count = ?,
                real_button_count = ?,
                real_api_call_count = ?
            WHERE id = ?
        """, (loc, complexity, maintainability, tech_debt, comp_count, btn_count, api_count, scr["id"]))

        kpi_report.append({
            "screen_id": scr["id"],
            "screen_name": scr["screen_name"],
            "loc": loc,
            "complexity": complexity,
            "maintainability": maintainability,
            "tech_debt_score": tech_debt,
            "real_component_count": comp_count,
            "real_button_count": btn_count,
            "real_api_call_count": api_count
        })

    conn.commit()

    proof_path = os.path.join(REPORT_DIR, "screen_kpi_report.json")
    with open(proof_path, "w", encoding="utf-8") as f:
        json.dump(kpi_report, f, indent=2)

    conn.close()
    print(f"Successfully computed metrics. Saved KPI report to tools/governance/reports/screen_kpi_report.json")

if __name__ == '__main__':
    main()
