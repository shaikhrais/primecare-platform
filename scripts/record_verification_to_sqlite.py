import sqlite3
import json
import os
import sys
from datetime import datetime

db_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
results_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\artifacts\render_verification_results.json"
report_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\artifacts\live_render_verification_report.md"

if not os.path.exists(results_path):
    print(f"Error: results file {results_path} not found!")
    sys.exit(1)

with open(results_path, 'r', encoding='utf-8') as f:
    results = json.load(f)

# Connect to SQLite
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

# Start Date
started_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Determine global run status
all_passed = all(r['status'] == 'passed' for r in results)
run_status = 'passed' if all_passed else 'failed'

# Calculate summary JSON
summary_data = {
    "total_apps_checked": len(results),
    "passed_apps": sum(1 for r in results if r['status'] == 'passed'),
    "failed_apps": sum(1 for r in results if r['status'] == 'failed'),
    "total_duration_ms": sum(r['durationMs'] for r in results)
}

# 1. Insert into test_runs (associate global run with primecare_governance app ID 10)
cursor.execute("""
INSERT INTO test_runs (app_id, run_name, run_type, status, started_at, completed_at, summary_json)
VALUES (10, ?, 'live_render_verification', ?, ?, ?, ?);
""", (
    f"Platform Live Render Check - {datetime.now().strftime('%Y-%m-%d %H:%M')}",
    run_status,
    started_at,
    datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    json.dumps(summary_data)
))
test_run_id = cursor.lastrowid
print(f"Registered test_run_id {test_run_id} in SQLite governance DB.")

# 2. Insert into test_cases and test_results for each application
for res in results:
    test_case_name = f"Verify live visual render and DOM integrity for {res['name']}"
    
    # Check or create test_case
    cursor.execute("SELECT id FROM test_cases WHERE test_name = ? AND app_id = ?;", (test_case_name, res['dbAppId']))
    case_row = cursor.fetchone()
    if case_row:
        test_case_id = case_row[0]
        # Update last run status
        cursor.execute("UPDATE test_cases SET last_run_status = ?, last_run_at = ? WHERE id = ?;", (res['status'], started_at, test_case_id))
    else:
        cursor.execute("""
        INSERT INTO test_cases (app_id, test_name, test_type, file_path, status, last_run_status, expected_result, last_run_at, priority)
        VALUES (?, ?, 'e2e_render', 'scripts/verify_render_quality.ts', 'active', ?, 'DOM rendering with active widgets and zero exception console crashes', ?, 'high');
        """, (res['dbAppId'], test_case_name, res['status'], started_at))
        test_case_id = cursor.lastrowid
        
    # Insert test result
    cursor.execute("""
    INSERT INTO test_results (test_run_id, test_case_id, status, error_message, duration_ms, screenshot_path, log_path)
    VALUES (?, ?, ?, ?, ?, ?, ?);
    """, (
        test_run_id,
        test_case_id,
        res['status'],
        res.get('errorMessage'),
        res['durationMs'],
        res['screenshotPath'].replace('\\', '/'),
        res['logPath'].replace('\\', '/')
    ))

# 3. Create detailed Markdown report
md_lines = [
    "# 🩺 Platform-Wide Live Render Visual Verification Audit Report",
    "",
    f"Generated at: **{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}**",
    f"Test Run ID: **{test_run_id}**",
    "",
    "## 📊 Platform Health Summary Dashboard",
    "",
    f"- **Global Verification Status**: {'🟩 **ALL PORTALS OPERATIONAL**' if all_passed else '🟥 **HEALTH DISCREPANCY DETECTED**'}",
    f"- **Total Portals Checked**: **{summary_data['total_apps_checked']}**",
    f"- **Successfully Rendered**: **{summary_data['passed_apps']} / {summary_data['total_apps_checked']}**",
    f"- **Bootstrap Errors Detected**: **{summary_data['failed_apps']}**",
    f"- **Cumulative Verification Duration**: **{(summary_data['total_duration_ms']/1000):.2f} seconds**",
    "",
    "---",
    "",
    "## 🛠️ Verification Methodology & Audit Process",
    "To solve the issue of 'blind assertions' regarding application health, we implemented an autonomous Playwright verification pipeline:",
    "1. **Headless Browser Bootstrap**: Spawns a Chromium instance using Playwright, simulating a standard desktop browser viewport (1440x900).",
    "2. **Flutter Initialization Timeout**: Navigates to each portal's login router (`/login`) and holds execution for 10 seconds to allow the compiled WebAssembly/JS engine to fully mount semantics nodes.",
    "3. **DOM Content & Structure Scan**: Evaluates the live page to verify that:",
    "   - The body is not a blank screen (`innerHTML` content length > 100).",
    "   - Flutter view canvas layers or semantics widgets (`<flt-glass-pane>`, `<flt-semantics>`) are injected.",
    "   - The resilient `AppErrorBoundary` self-healing boundary (`'MECHANICAL FIX IN PROGRESS'`) has not been triggered.",
    "4. **Active Console Telemetry Interceptor**: Catches and logs all unhandled Javascript exceptions and boot crashes via `page.on('pageerror')` and `page.on('console')` hooks.",
    "5. **Visual Evidence Logging**: Captures a visual snapshot of the rendered state, saving it to the artifacts directory as a PNG.",
    "6. **Governance Registry Syncreference**: Automatically records the run, timing data, errors, and files into the SQLite database registry.",
    "",
    "---",
    "",
    "## 📋 Granular Portal Verification Metrics",
    "",
    "| Portal Code | Cloudflare URL | Render Status | Bootstrap (ms) | Active DOM Elements | Error Details |",
    "| :--- | :--- | :--- | :--- | :--- | :--- |"
]

for res in results:
    err_text = res.get('errorMessage') if res.get('errorMessage') else 'None'
    status_label = '✅ Passed' if res['status'] == 'passed' else '❌ Failed'
    line = f"| `{res['name']}` | [{res['url']}]({res['url']}) | **{status_label}** | {res['durationMs']} | {res['domChecks']['domNodeCount']} | {err_text} |"
    md_lines.append(line)

md_lines.append("")
md_lines.append("---")
md_lines.append("")
md_lines.append("## 📸 Visual Verification Carousel & Console Logs")
md_lines.append("The visual evidence captured during this audit run is saved directly in the artifacts registry.")
md_lines.append("")

# Generate a Carousel of rendered screens
md_lines.append("````carousel")
for i, res in enumerate(results):
    clean_p = res['screenshotPath'].replace('\\', '/')
    slide_prefix = "" if i == 0 else "<!-- slide -->\n"
    # To embed image in markdown, we must format the absolute Windows path with leading slash
    win_abs_p = clean_p
    if not win_abs_p.startswith('/'):
        win_abs_p = '/' + win_abs_p
    md_lines.append(f"{slide_prefix}<img src=\"file://{win_abs_p}\" alt=\"Portal: {res['name']}\" width=\"100%\" />")
md_lines.append("````")

md_lines.append("")
md_lines.append("---")
md_lines.append("")
md_lines.append("## 🔬 Verification Logs & SQLite Governance Database Schema Input")
md_lines.append("This entire verification run has been logged into the `governance.db` SQLite database:")
md_lines.append("- **Run Table**: `test_runs` (ID: `" + str(test_run_id) + "`) storing duration, timestamp, and health JSON.")
md_lines.append("- **Results Table**: `test_results` linking screenshots, browser console logs, and render outcome details.")
md_lines.append("- **Reports Table**: `governance_reports` storing this Markdown document for local audit compliance.")

md_content = "\n".join(md_lines)

# Write human-readable markdown file
with open(report_path, 'w', encoding='utf-8') as f:
    f.write(md_content)
print(f"Saved human-readable Markdown verification report to: {report_path}")

# 4. Insert report into governance_reports table
cursor.execute("""
INSERT INTO governance_reports (app_id, report_name, report_type, html_report_path, generated_by)
VALUES (10, ?, 'verification_run_report', ?, 'Render Quality Verification Engine');
""", (
    f"Visual Render Verification Run #{test_run_id}",
    report_path.replace('\\', '/')
))

conn.commit()
conn.close()
print("Successfully synced verification process and detailed metrics to SQLite governance.db!")
