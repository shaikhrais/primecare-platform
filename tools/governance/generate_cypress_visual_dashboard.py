import os
import json
import sqlite3
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
OUT_HTML = os.path.abspath(os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "cypress_visual_dashboard.html"))

def main():
    print("Generating Enterprise Cypress Visual Proof Dashboard...")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Query KPI results
    kpis = [dict(r) for r in cur.execute("SELECT * FROM kpi_results ORDER BY measured_at DESC").fetchall()]

    # Query Screens Cypress results
    screens = [dict(r) for r in cur.execute("""
        SELECT * FROM screens 
        WHERE cypress_last_status != 'not_run' AND cypress_last_status IS NOT NULL
        ORDER BY cypress_last_run_at DESC
    """).fetchall()]

    # Query Roles Auth results
    roles = [dict(r) for r in cur.execute("""
        SELECT * FROM roles 
        WHERE auth_test_status != 'not_run' AND auth_test_status IS NOT NULL
    """).fetchall()]

    # Get screenshots validation JSON
    reports_dir = Path(PROJECT_ROOT) / "tools" / "governance" / "reports"
    val_json_path = reports_dir / "visual_proof_validation.json"
    val_details = []
    if val_json_path.exists():
        try:
            val_details = json.loads(val_json_path.read_text(encoding="utf-8"))
        except Exception as e:
            print(f"Warning: Could not parse {val_json_path}: {e}")

    conn.close()

    # Construct the HTML content
    html = get_dashboard_html_template(kpis, screens, roles, val_details)

    # Write HTML file
    Path(OUT_HTML).parent.mkdir(parents=True, exist_ok=True)
    Path(OUT_HTML).write_text(html, encoding="utf-8")
    print(f"[SUCCESS] Visual Dashboard rendered successfully at: {OUT_HTML}")

def get_dashboard_html_template(kpis, screens, roles, val_details):
    # Dynamic counts
    passed_screens = sum(1 for s in screens if s.get('cypress_last_status') == 'passed')
    failed_screens = sum(1 for s in screens if s.get('cypress_last_status') == 'failed')
    total_screens = len(screens)

    # Generate KPI rows
    kpi_rows_html = ""
    for k in kpis:
        status_class = "badge-passed" if k['kpi_status'] == 'passed' else "badge-failed"
        kpi_rows_html += f"""
        <tr>
          <td><strong>{k['kpi_code']}</strong></td>
          <td>{k['kpi_name']}</td>
          <td><span class="badge {status_class}">{k['kpi_status'].upper()}</span></td>
          <td><span class="font-mono">{k['kpi_value']}</span></td>
          <td>{k['measured_at']}</td>
        </tr>
        """

    # Generate Roles Auth cards
    roles_cards_html = ""
    for r in roles:
        status_class = "border-passed" if r['auth_test_status'] == 'passed' else "border-failed"
        badge_class = "badge-passed" if r['auth_test_status'] == 'passed' else "badge-failed"
        screenshot_url = f"../../../{r['auth_screenshot_path']}" if r['auth_screenshot_path'] else "#"
        video_url = f"../../../{r['auth_video_path']}" if r['auth_video_path'] else "#"
        
        roles_cards_html += f"""
        <div class="card {status_class}">
          <div class="card-header">
            <h3>{r['role_name']} ({r['role_code'].upper()})</h3>
            <span class="badge {badge_class}">{r['auth_test_status'].upper()}</span>
          </div>
          <div class="card-body">
            <p><strong>Test Email:</strong> {r['test_email']}</p>
            <p><strong>Secret Reference:</strong> {r['test_password_secret_ref']}</p>
            <p><strong>Last Checked:</strong> {r['auth_last_run_at']}</p>
            {f'<p class="error-text"><strong>Error:</strong> {r["auth_last_error"]}</p>' if r['auth_last_error'] else ''}
            
            <div class="visual-proofs">
              <div class="proof-box">
                <h4>Screenshot Proof</h4>
                {f'<a href="{screenshot_url}" target="_blank"><img class="screenshot-thumbnail" src="{screenshot_url}" alt="Auth Success Screenshot"/></a>' if r['auth_screenshot_path'] else '<p class="text-muted">No screenshot</p>'}
              </div>
              <div class="proof-box">
                <h4>E2E video Recording</h4>
                {f'<video class="video-thumbnail" controls src="{video_url}"></video>' if r['auth_video_path'] and os.path.exists(os.path.join(PROJECT_ROOT, r['auth_video_path'])) else '<p class="text-muted">Video clip not recorded</p>'}
              </div>
            </div>
          </div>
        </div>
        """

    # Generate Screens Cards
    screens_cards_html = ""
    for s in screens:
        status_class = "border-passed" if s['cypress_last_status'] == 'passed' else "border-failed"
        badge_class = "badge-passed" if s['cypress_last_status'] == 'passed' else "badge-failed"
        screenshot_url = f"../../../{s['cypress_screenshot_path']}" if s['cypress_screenshot_path'] else "#"
        video_url = f"../../../{s['cypress_video_path']}" if s['cypress_video_path'] else "#"
        
        # Find Pillow score from details
        scr_val = next((v for v in val_details if v.get("screen_id") == s["id"]), {})
        score = s.get('screenshot_visual_score', 0)
        std_dev = scr_val.get('std_dev', 0.0)
        size_kb = s.get('screenshot_file_size_bytes', 0) / 1024.0

        screens_cards_html += f"""
        <div class="card {status_class}" data-status="{s['cypress_last_status']}">
          <div class="card-header">
            <h3>{s['screen_name']}</h3>
            <span class="badge {badge_class}">{s['cypress_last_status'].upper()}</span>
          </div>
          <div class="card-body">
            <div class="meta-grid">
              <div><strong>Code:</strong> {s['screen_code']}</div>
              <div><strong>Path:</strong> <span class="font-mono">{s['route_path']}</span></div>
              <div><strong>Visual Score:</strong> <span class="score-badge {'score-high' if score >= 80 else 'score-mid'}">{score}/100</span></div>
              <div><strong>File Size:</strong> {size_kb:.1f} KB</div>
              <div><strong>Entropy (Std Dev):</strong> {std_dev:.2f}</div>
              <div><strong>Status:</strong> {s['screenshot_validation_status'].upper()}</div>
            </div>
            
            <div class="visual-proofs">
              <div class="proof-box">
                <h4>Viewport Screenshot</h4>
                {f'<a href="{screenshot_url}" target="_blank"><img class="screenshot-thumbnail" src="{screenshot_url}" alt="Screen Viewport Screenshot"/></a>' if s['cypress_screenshot_path'] else '<p class="text-muted">No screenshot captured</p>'}
              </div>
              <div class="proof-box">
                <h4>Playable Spec Recording</h4>
                {f'<video class="video-thumbnail" controls src="{video_url}"></video>' if s['cypress_video_path'] else '<p class="text-muted">Video clip not recorded</p>'}
              </div>
            </div>
          </div>
        </div>
        """

    # Primary shell HTML
    return f"""
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>PrimeCare - Enterprise Cypress E2E Visual Monitoring Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    :root {{
      --primary: #2563eb;
      --primary-hover: #1d4ed8;
      --bg: #0f172a;
      --surface: #1e293b;
      --border: #334155;
      --text: #f8fafc;
      --text-muted: #94a3b8;
      --success: #10b981;
      --error: #ef4444;
      --warning: #f59e0b;
    }}
    
    body {{
      margin: 0;
      padding: 0;
      font-family: 'Inter', sans-serif;
      background-color: var(--bg);
      color: var(--text);
      min-height: 100vh;
    }}

    header {{
      background: linear-gradient(135deg, #1e3b8a, var(--bg));
      border-bottom: 1px solid var(--border);
      padding: 40px 60px;
    }}

    .header-content h1 {{
      font-family: 'Outfit', sans-serif;
      font-size: 2.8rem;
      font-weight: 800;
      margin: 0 0 10px 0;
      background: linear-gradient(135deg, #60a5fa, #ffffff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }}

    .header-content p {{
      color: var(--text-muted);
      font-size: 1.1rem;
      margin: 0;
    }}

    /* Container */
    .dashboard-container {{
      max-width: 1400px;
      margin: 0 auto;
      padding: 40px 60px;
      box-sizing: border-box;
    }}

    /* Stat Cards */
    .stats-grid {{
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 24px;
      margin-bottom: 48px;
    }}
    .stat-card {{
      background-color: var(--surface);
      border: 1px solid var(--border);
      border-radius: 20px;
      padding: 28px;
      box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.4);
      position: relative;
      overflow: hidden;
    }}
    .stat-card::before {{
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
    }}
    .stat-card.passed::before {{ background: var(--success); }}
    .stat-card.failed::before {{ background: var(--error); }}
    .stat-card.total::before {{ background: var(--primary); }}
    
    .stat-title {{
      color: var(--text-muted);
      text-transform: uppercase;
      font-size: 0.85rem;
      letter-spacing: 0.05em;
      margin-bottom: 8px;
    }}
    .stat-value {{
      font-size: 2.8rem;
      font-family: 'Outfit', sans-serif;
      font-weight: 700;
      margin-bottom: 8px;
    }}
    .stat-sub {{
      font-size: 0.9rem;
      color: var(--text-muted);
    }}

    /* Section styling */
    section {{
      margin-bottom: 60px;
    }}
    section h2 {{
      font-family: 'Outfit', sans-serif;
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 24px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 2px solid var(--border);
      padding-bottom: 12px;
    }}

    /* Table styling */
    .table-container {{
      background-color: var(--surface);
      border: 1px solid var(--border);
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.4);
    }}
    table {{
      width: 100%;
      border-collapse: collapse;
      text-align: left;
    }}
    th, td {{
      padding: 18px 24px;
      border-bottom: 1px solid var(--border);
    }}
    th {{
      background-color: rgba(255, 255, 255, 0.03);
      color: var(--text-muted);
      font-weight: 600;
      text-transform: uppercase;
      font-size: 0.8rem;
      letter-spacing: 0.05em;
    }}
    tr:last-child td {{
      border-bottom: none;
    }}
    .font-mono {{
      font-family: 'Courier New', monospace;
    }}

    /* Badges */
    .badge {{
      padding: 6px 12px;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 700;
      letter-spacing: 0.02em;
    }}
    .badge-passed {{
      background-color: rgba(16, 185, 129, 0.15);
      color: var(--success);
      border: 1px solid rgba(16, 185, 129, 0.3);
    }}
    .badge-failed {{
      background-color: rgba(239, 68, 68, 0.15);
      color: var(--error);
      border: 1px solid rgba(239, 68, 68, 0.3);
    }}

    /* Score Badge */
    .score-badge {{
      padding: 4px 8px;
      border-radius: 6px;
      font-weight: 700;
      font-size: 0.85rem;
    }}
    .score-high {{
      background-color: rgba(16, 185, 129, 0.2);
      color: var(--success);
    }}
    .score-mid {{
      background-color: rgba(245, 158, 11, 0.2);
      color: var(--warning);
    }}

    /* Card styling */
    .cards-grid {{
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(620px, 1fr));
      gap: 32px;
    }}
    .card {{
      background-color: var(--surface);
      border: 1px solid var(--border);
      border-radius: 20px;
      box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.4);
      display: flex;
      flex-direction: column;
      overflow: hidden;
      transition: all 0.3s ease;
    }}
    .card:hover {{
      transform: translateY(-2px);
      box-shadow: 0 15px 40px -10px rgba(0, 0, 0, 0.5);
    }}
    .card.border-passed {{
      border-left: 6px solid var(--success);
    }}
    .card.border-failed {{
      border-left: 6px solid var(--error);
    }}

    .card-header {{
      padding: 24px;
      border-bottom: 1px solid var(--border);
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: rgba(255, 255, 255, 0.01);
    }}
    .card-header h3 {{
      font-family: 'Outfit', sans-serif;
      margin: 0;
      font-size: 1.3rem;
    }}

    .card-body {{
      padding: 24px;
      flex: 1;
    }}

    .meta-grid {{
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 16px;
      margin-bottom: 24px;
      background-color: rgba(0, 0, 0, 0.15);
      padding: 18px;
      border-radius: 12px;
      font-size: 0.9rem;
    }}

    .error-text {{
      color: var(--error);
      background-color: rgba(239, 68, 68, 0.08);
      border: 1px solid rgba(239, 68, 68, 0.2);
      padding: 12px 16px;
      border-radius: 8px;
      font-size: 0.85rem;
      margin: 12px 0 24px 0;
    }}

    /* Visual proofs section */
    .visual-proofs {{
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
      margin-top: 16px;
    }}
    .proof-box h4 {{
      font-size: 0.85rem;
      color: var(--text-muted);
      margin: 0 0 10px 0;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }}
    
    .screenshot-thumbnail {{
      width: 100%;
      height: 180px;
      object-fit: cover;
      border-radius: 12px;
      border: 1px solid var(--border);
      cursor: pointer;
      transition: opacity 0.2s ease;
    }}
    .screenshot-thumbnail:hover {{
      opacity: 0.85;
    }}

    .video-thumbnail {{
      width: 100%;
      height: 180px;
      background: black;
      border-radius: 12px;
      border: 1px solid var(--border);
      object-fit: contain;
    }}

    /* Filters */
    .btn-group {{
      display: flex;
      gap: 12px;
    }}
    .btn-filter {{
      background-color: rgba(255, 255, 255, 0.05);
      border: 1px solid var(--border);
      color: var(--text);
      padding: 10px 20px;
      border-radius: 10px;
      cursor: pointer;
      font-size: 0.9rem;
      font-weight: 500;
      transition: all 0.2s ease;
    }}
    .btn-filter:hover, .btn-filter.active {{
      background-color: var(--primary);
      border-color: var(--primary);
      color: white;
    }}
  </style>
</head>
<body>

  <header>
    <div class="header-content">
      <h1>Cypress E2E Visual Monitoring Dashboard</h1>
      <p>Enterprise Governance Health Portal & Visual Proof Vault</p>
    </div>
  </header>

  <div class="dashboard-container">

    <!-- Overview Stats -->
    <div class="stats-grid">
      <div class="stat-card total">
        <div class="stat-title">Total Screens Tested</div>
        <div class="stat-value">{total_screens}</div>
        <div class="stat-sub">Across active role allowed mappings</div>
      </div>
      <div class="stat-card passed">
        <div class="stat-title">Passed Verification</div>
        <div class="stat-value">{passed_screens}</div>
        <div class="stat-sub">100% verified non-blank visual proof</div>
      </div>
      <div class="stat-card failed">
        <div class="stat-title">Failed / Blank Detections</div>
        <div class="stat-value">{failed_screens}</div>
        <div class="stat-sub">Blocking errors registered</div>
      </div>
    </div>

    <!-- SQLite KPI table -->
    <section>
      <h2>SQLite Governance KPI Logs</h2>
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>KPI Code</th>
              <th>KPI Name</th>
              <th>Status</th>
              <th>Value</th>
              <th>Measured At</th>
            </tr>
          </thead>
          <tbody>
            {kpi_rows_html}
          </tbody>
        </table>
      </div>
    </section>

    <!-- Roles Authentication Section -->
    <section>
      <h2>RBAC Authentication E2E Proofs</h2>
      <div class="cards-grid">
        {roles_cards_html}
      </div>
    </section>

    <!-- Screens Section with Filtering -->
    <section id="screens-section">
      <h2>
        Screens allowed Visual Proof Sweep
        <div class="btn-group">
          <button class="btn-filter active" onclick="filterScreens('all')">All</button>
          <button class="btn-filter" onclick="filterScreens('passed')">Passed</button>
          <button class="btn-filter" onclick="filterScreens('failed')">Failed</button>
        </div>
      </h2>
      
      <div class="cards-grid" id="screensGrid">
        {screens_cards_html}
      </div>
    </section>

  </div>

  <script>
    function filterScreens(status) {{
      // Update button active states
      const buttons = document.querySelectorAll('.btn-filter');
      buttons.forEach(btn => btn.classList.remove('active'));
      event.target.classList.add('active');

      const cards = document.querySelectorAll('#screensGrid .card');
      cards.forEach(card => {{
        if (status === 'all') {{
          card.style.display = 'flex';
        }} else if (card.getAttribute('data-status') === status) {{
          card.style.display = 'flex';
        }} else {{
          card.style.display = 'none';
        }}
      }});
    }}
  </script>
</body>
</html>
    """

if __name__ == "__main__":
    main()
