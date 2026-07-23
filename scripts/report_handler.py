import os
import sqlite3
import json

class ReportHandler:
    """
    Dedicated handler for querying single source of truth SQLite DB (.agents/governance/governance.db)
    and building the interactive Role-wise and App-wise Screen Gallery web report.
    """

    def __init__(self, db_path=None):
        project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
        self.db_path = db_path or os.path.join(project_root, '.agents', 'governance', 'governance.db')
        self.project_root = project_root

    def get_connection(self):
        return sqlite3.connect(self.db_path)

    def extract_gallery_data(self):
        conn = self.get_connection()
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

        # 1. Fetch Apps
        cursor.execute("SELECT id, app_code, app_name, description FROM apps WHERE active = 1 ORDER BY app_name")
        apps = [dict(r) for r in cursor.fetchall()]

        # 2. Fetch Roles
        cursor.execute("SELECT id, role_code, role_name, primary_app_code FROM roles WHERE active = 1 ORDER BY role_name")
        roles = [dict(r) for r in cursor.fetchall()]

        # 3. Fetch Screens with Requirements
        query = """
            SELECT 
                s.id,
                s.screen_code,
                s.screen_name,
                s.route_path,
                s.actual_file_path,
                s.completeness_score,
                s.implementation_tag,
                s.content_tag,
                s.api_tag,
                s.test_tag,
                s.review_tag,
                s.screenshot_path,
                s.runtime_verified,
                s.cypress_verified,
                s.production_ready,
                a.app_code,
                a.app_name,
                r.role_code,
                r.role_name,
                req.business_purpose,
                req.user_story,
                req.acceptance_criteria
            FROM screens s
            LEFT JOIN apps a ON s.app_id = a.id
            LEFT JOIN roles r ON s.role_id = r.id
            LEFT JOIN screen_requirements req ON s.id = req.screen_id
            WHERE s.active = 1
            ORDER BY a.app_name, r.role_name, s.screen_name
        """
        cursor.execute(query)
        screens = [dict(r) for r in cursor.fetchall()]

        # 4. Fetch Sections per Screen
        cursor.execute("""
            SELECT id as section_id, screen_id, section_name, section_code, section_type, section_order, purpose 
            FROM screen_sections 
            ORDER BY section_order
        """)
        sections_raw = cursor.fetchall()
        sections_by_screen = {}
        for sec in sections_raw:
            sid = sec['screen_id']
            if sid not in sections_by_screen:
                sections_by_screen[sid] = []
            sections_by_screen[sid].append(dict(sec))

        # 5. Fetch Elements per Screen
        cursor.execute("""
            SELECT id as element_id, screen_id, section_id, element_key, element_type, label, test_id 
            FROM screen_section_elements
        """)
        elements_raw = cursor.fetchall()
        elements_by_screen = {}
        for el in elements_raw:
            sid = el['screen_id']
            if sid not in elements_by_screen:
                elements_by_screen[sid] = []
            elements_by_screen[sid].append(dict(el))

        # 6. Fetch APIs per screen
        cursor.execute("""
            SELECT m.screen_id, m.api_id, a.api_name, a.method, a.endpoint_path 
            FROM screen_api_map m
            JOIN api_registry a ON m.api_id = a.id
        """)
        apis_raw = cursor.fetchall()
        apis_by_screen = {}
        for ap in apis_raw:
            sid = ap['screen_id']
            if sid not in apis_by_screen:
                apis_by_screen[sid] = []
            apis_by_screen[sid].append(dict(ap))

        conn.close()

        # Attach details to screens
        for scr in screens:
            sid = scr['id']
            scr['sections'] = sections_by_screen.get(sid, [])
            scr['elements'] = elements_by_screen.get(sid, [])
            scr['apis'] = apis_by_screen.get(sid, [])

        return {
            'apps': apps,
            'roles': roles,
            'screens': screens
        }

    def generate_report_html(self, data):
        screens_json = json.dumps(data['screens'])
        apps_json = json.dumps(data['apps'])
        roles_json = json.dumps(data['roles'])

        total_screens = len(data['screens'])
        total_apps = len(data['apps'])
        total_roles = len(data['roles'])
        avg_score = round(sum(s['completeness_score'] or 0 for s in data['screens']) / max(total_screens, 1), 1)

        html = f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PrimeCare Platform - Role-wise & App-wise Screen Gallery</title>
  <style>
    :root {{
      --bg-dark: #0f172a;
      --bg-card: #1e293b;
      --bg-card-hover: #334155;
      --border-color: #334155;
      --text-main: #f8fafc;
      --text-sub: #94a3b8;
      --accent: #3b82f6;
      --accent-glow: rgba(59, 130, 246, 0.3);
      --success: #10b981;
      --warning: #f59e0b;
      --purple: #8b5cf6;
    }}
    * {{ box-sizing: border-box; margin: 0; padding: 0; }}
    body {{
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background-color: var(--bg-dark);
      color: var(--text-main);
      line-height: 1.5;
      padding-bottom: 60px;
    }}
    header {{
      background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
      border-bottom: 1px solid var(--border-color);
      padding: 24px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 4px 20px rgba(0,0,0,0.4);
    }}
    .brand h1 {{
      font-size: 1.8rem;
      font-weight: 800;
      background: linear-gradient(to right, #60a5fa, #3b82f6, #8b5cf6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }}
    .brand p {{
      color: var(--text-sub);
      font-size: 0.9rem;
      margin-top: 4px;
    }}
    .metrics-bar {{
      display: flex;
      gap: 16px;
    }}
    .metric-chip {{
      background-color: rgba(255,255,255,0.04);
      border: 1px solid var(--border-color);
      padding: 10px 18px;
      border-radius: 12px;
      font-size: 0.85rem;
      color: var(--text-sub);
      text-align: center;
    }}
    .metric-chip strong {{
      display: block;
      font-size: 1.2rem;
      color: var(--text-main);
    }}
    .controls-panel {{
      background-color: rgba(30, 41, 59, 0.7);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid var(--border-color);
      padding: 20px 40px;
      display: flex;
      gap: 16px;
      flex-wrap: wrap;
      align-items: center;
      sticky: top 0;
      z-index: 10;
    }}
    .search-box {{
      flex: 2;
      min-width: 280px;
      background-color: var(--bg-dark);
      border: 1px solid var(--border-color);
      color: var(--text-main);
      padding: 10px 16px;
      border-radius: 8px;
      font-size: 0.95rem;
      outline: none;
      transition: border-color 0.2s;
    }}
    .search-box:focus {{ border-color: var(--accent); }}
    .filter-select {{
      flex: 1;
      min-width: 180px;
      background-color: var(--bg-dark);
      border: 1px solid var(--border-color);
      color: var(--text-main);
      padding: 10px 14px;
      border-radius: 8px;
      font-size: 0.9rem;
      outline: none;
      cursor: pointer;
    }}
    .gallery-container {{
      padding: 30px 40px;
    }}
    .gallery-grid {{
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
      gap: 24px;
    }}
    .screen-card {{
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: 14px;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      transition: transform 0.2s, border-color 0.2s, box-shadow 0.2s;
      cursor: pointer;
    }}
    .screen-card:hover {{
      transform: translateY(-4px);
      border-color: var(--accent);
      box-shadow: 0 10px 25px rgba(0,0,0,0.5), 0 0 15px var(--accent-glow);
    }}
    .thumb-box {{
      height: 180px;
      background-color: #090d16;
      position: relative;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }}
    .thumb-box img {{
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s;
    }}
    .screen-card:hover .thumb-box img {{
      transform: scale(1.05);
    }}
    .no-thumb {{
      color: var(--text-sub);
      font-size: 0.85rem;
      text-align: center;
      padding: 20px;
    }}
    .badge {{
      position: absolute;
      top: 12px;
      right: 12px;
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }}
    .badge-score {{
      background: rgba(16, 185, 129, 0.9);
      color: white;
    }}
    .card-body {{
      padding: 18px;
      flex: 1;
      display: flex;
      flex-direction: column;
    }}
    .tags-row {{
      display: flex;
      gap: 8px;
      margin-bottom: 8px;
      flex-wrap: wrap;
    }}
    .tag {{
      background-color: rgba(255,255,255,0.06);
      border: 1px solid rgba(255,255,255,0.1);
      color: #cbd5e1;
      padding: 2px 8px;
      border-radius: 6px;
      font-size: 0.75rem;
    }}
    .screen-title {{
      font-size: 1.05rem;
      font-weight: 700;
      color: var(--text-main);
      margin-bottom: 6px;
    }}
    .screen-purpose {{
      font-size: 0.85rem;
      color: var(--text-sub);
      line-clamp: 2;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      margin-bottom: 12px;
    }}
    .card-footer {{
      margin-top: auto;
      padding-top: 12px;
      border-top: 1px solid rgba(255,255,255,0.05);
      display: flex;
      justify-content: space-between;
      font-size: 0.8rem;
      color: var(--text-sub);
    }}

    /* MODAL DRAWER */
    .modal-overlay {{
      position: fixed;
      inset: 0;
      background-color: rgba(15, 23, 42, 0.85);
      backdrop-filter: blur(8px);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 1000;
      padding: 30px;
    }}
    .modal-card {{
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: 16px;
      width: 100%;
      max-width: 1200px;
      height: 90vh;
      display: flex;
      flex-direction: column;
      overflow: hidden;
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.7);
    }}
    .modal-header {{
      padding: 20px 28px;
      border-bottom: 1px solid var(--border-color);
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: rgba(15, 23, 42, 0.5);
    }}
    .modal-header h2 {{
      font-size: 1.4rem;
      color: var(--text-main);
    }}
    .close-btn {{
      background: none;
      border: none;
      color: var(--text-sub);
      font-size: 1.8rem;
      cursor: pointer;
      line-height: 1;
    }}
    .close-btn:hover {{ color: var(--text-main); }}
    .modal-body {{
      display: flex;
      flex: 1;
      overflow: hidden;
    }}
    .modal-img-col {{
      flex: 1.2;
      background-color: #080c14;
      padding: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-right: 1px solid var(--border-color);
      overflow: auto;
    }}
    .modal-img-col img {{
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
      border-radius: 8px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    }}
    .modal-info-col {{
      flex: 1;
      padding: 24px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
      gap: 20px;
    }}
    .info-section {{
      background: rgba(255,255,255,0.02);
      border: 1px solid var(--border-color);
      border-radius: 10px;
      padding: 16px;
    }}
    .info-section h3 {{
      font-size: 0.95rem;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      color: var(--accent);
      margin-bottom: 10px;
    }}
    .info-grid {{
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
      font-size: 0.85rem;
    }}
    .info-item label {{
      display: block;
      color: var(--text-sub);
      font-size: 0.75rem;
    }}
    .info-item span {{
      color: var(--text-main);
      font-weight: 600;
    }}
    .text-block {{
      font-size: 0.88rem;
      color: #cbd5e1;
      line-height: 1.6;
    }}
    .chips-list {{
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 8px;
    }}
    .chip-item {{
      background-color: rgba(59, 130, 246, 0.1);
      border: 1px solid rgba(59, 130, 246, 0.3);
      color: #93c5fd;
      padding: 4px 10px;
      border-radius: 6px;
      font-size: 0.8rem;
    }}
  </style>
</head>
<body>

  <header>
    <div class="brand">
      <h1>PrimeCare Screen Gallery</h1>
      <p>Single Source of Truth Governance & Visual Catalog (.agents/governance/governance.db)</p>
    </div>
    <div class="metrics-bar">
      <div class="metric-chip">
        <strong id="stat-total">{total_screens}</strong> Screens
      </div>
      <div class="metric-chip">
        <strong id="stat-apps">{total_apps}</strong> Apps
      </div>
      <div class="metric-chip">
        <strong id="stat-roles">{total_roles}</strong> Roles
      </div>
      <div class="metric-chip">
        <strong id="stat-score">{avg_score}%</strong> Avg Readiness
      </div>
    </div>
  </header>

  <div class="controls-panel">
    <input type="text" id="search-input" class="search-box" placeholder="Search by screen name, code, route, or business function...">
    
    <select id="app-filter" class="filter-select">
      <option value="">All Applications ({total_apps})</option>
    </select>

    <select id="role-filter" class="filter-select">
      <option value="">All User Roles ({total_roles})</option>
    </select>

    <select id="status-filter" class="filter-select">
      <option value="">All Readiness Scores</option>
      <option value="100">Production Ready (100%)</option>
      <option value="80">High Readiness (80%+)</option>
      <option value="50">Partial (50%+)</option>
    </select>
  </div>

  <main class="gallery-container">
    <div id="gallery-grid" class="gallery-grid"></div>
  </main>

  <!-- DETAIL MODAL -->
  <div id="detail-modal" class="modal-overlay" onclick="if(event.target===this) closeModal()">
    <div class="modal-card">
      <div class="modal-header">
        <h2 id="modal-title">Screen Details</h2>
        <button class="close-btn" onclick="closeModal()">&times;</button>
      </div>
      <div class="modal-body">
        <div class="modal-img-col">
          <img id="modal-img" src="" alt="Screen Preview">
        </div>
        <div class="modal-info-col">
          
          <div class="info-section">
            <h3>Overview & Metadata</h3>
            <div class="info-grid">
              <div class="info-item"><label>Application</label><span id="m-app"></span></div>
              <div class="info-item"><label>Target Role</label><span id="m-role"></span></div>
              <div class="info-item"><label>Screen Code</label><span id="m-code"></span></div>
              <div class="info-item"><label>Completeness Score</label><span id="m-score"></span></div>
              <div class="info-item"><label>Route Path</label><span id="m-route"></span></div>
              <div class="info-item"><label>Implementation Tag</label><span id="m-tag"></span></div>
            </div>
          </div>

          <div class="info-section">
            <h3>Business Function & Purpose</h3>
            <p id="m-purpose" class="text-block"></p>
          </div>

          <div class="info-section">
            <h3>User Story</h3>
            <p id="m-story" class="text-block"></p>
          </div>

          <div class="info-section">
            <h3>Screen Sections</h3>
            <div id="m-sections" class="chips-list"></div>
          </div>

          <div class="info-section">
            <h3>Connected Endpoints & APIs</h3>
            <div id="m-apis" class="chips-list"></div>
          </div>

          <div class="info-section">
            <h3>UI Elements & Selectors</h3>
            <div id="m-elements" class="chips-list"></div>
          </div>

        </div>
      </div>
    </div>
  </div>

  <script>
    const screensData = {screens_json};
    const appsData = {apps_json};
    const rolesData = {roles_json};

    // Populate Filters
    const appFilter = document.getElementById('app-filter');
    appsData.forEach(a => {{
      const opt = document.createElement('option');
      opt.value = a.app_code;
      opt.textContent = a.app_name;
      appFilter.appendChild(opt);
    }});

    const roleFilter = document.getElementById('role-filter');
    rolesData.forEach(r => {{
      const opt = document.createElement('option');
      opt.value = r.role_code;
      opt.textContent = r.role_name;
      roleFilter.appendChild(opt);
    }});

    function renderGallery() {{
      const search = document.getElementById('search-input').value.toLowerCase();
      const app = appFilter.value;
      const role = roleFilter.value;
      const status = document.getElementById('status-filter').value;

      const grid = document.getElementById('gallery-grid');
      grid.innerHTML = '';

      const filtered = screensData.filter(s => {{
        const matchesSearch = !search || 
          (s.screen_name && s.screen_name.toLowerCase().includes(search)) ||
          (s.screen_code && s.screen_code.toLowerCase().includes(search)) ||
          (s.route_path && s.route_path.toLowerCase().includes(search)) ||
          (s.business_purpose && s.business_purpose.toLowerCase().includes(search));
        
        const matchesApp = !app || s.app_code === app;
        const matchesRole = !role || s.role_code === role;
        const matchesStatus = !status || (s.completeness_score >= parseInt(status));

        return matchesSearch && matchesApp && matchesRole && matchesStatus;
      }});

      filtered.forEach(s => {{
        const card = document.createElement('div');
        card.className = 'screen-card';
        card.onclick = () => openModal(s);

        const imgSrc = s.screenshot_path ? s.screenshot_path : '';
        const imgHtml = imgSrc 
          ? `<img src="${{imgSrc}}" alt="${{s.screen_name}}" onerror="this.parentNode.innerHTML='<div class=\\'no-thumb\\'>Preview Pending<br><small>${{s.screen_code}}</small></div>'">`
          : `<div class="no-thumb">No Screenshot Recorded<br><small>${{s.screen_code}}</small></div>`;

        card.innerHTML = `
          <div class="thumb-box">
            ${{imgHtml}}
            <span class="badge badge-score">${{s.completeness_score || 0}}%</span>
          </div>
          <div class="card-body">
            <div class="tags-row">
              <span class="tag">${{s.app_name || 'App'}}</span>
              <span class="tag">${{s.role_name || 'Role'}}</span>
            </div>
            <div class="screen-title">${{s.screen_name}}</div>
            <div class="screen-purpose">${{s.business_purpose || 'No purpose detailed in DB.'}}</div>
            <div class="card-footer">
              <span>Route: ${{s.route_path || '/'}}</span>
              <span>Tag: ${{s.implementation_tag || 'none'}}</span>
            </div>
          </div>
        `;
        grid.appendChild(card);
      }});
    }}

    function openModal(s) {{
      document.getElementById('modal-title').textContent = s.screen_name;
      document.getElementById('modal-img').src = s.screenshot_path || '';
      document.getElementById('m-app').textContent = s.app_name || 'N/A';
      document.getElementById('m-role').textContent = s.role_name || 'N/A';
      document.getElementById('m-code').textContent = s.screen_code || 'N/A';
      document.getElementById('m-score').textContent = (s.completeness_score || 0) + '%';
      document.getElementById('m-route').textContent = s.route_path || '/';
      document.getElementById('m-tag').textContent = s.implementation_tag || 'none';

      document.getElementById('m-purpose').textContent = s.business_purpose || 'No purpose recorded in database.';
      document.getElementById('m-story').textContent = s.user_story || 'No user story recorded in database.';

      const secContainer = document.getElementById('m-sections');
      secContainer.innerHTML = '';
      if (s.sections && s.sections.length > 0) {{
        s.sections.forEach(sec => {{
          const chip = document.createElement('span');
          chip.className = 'chip-item';
          chip.textContent = sec.section_name || sec.section_code;
          secContainer.appendChild(chip);
        }});
      }} else {{
        secContainer.innerHTML = '<span style="color:var(--text-sub);font-size:0.8rem">No sections registered in DB</span>';
      }}

      const apiContainer = document.getElementById('m-apis');
      apiContainer.innerHTML = '';
      if (s.apis && s.apis.length > 0) {{
        s.apis.forEach(ap => {{
          const chip = document.createElement('span');
          chip.className = 'chip-item';
          chip.textContent = `${{ap.method || 'GET'}} ${{ap.endpoint_path || ap.api_name}}`;
          apiContainer.appendChild(chip);
        }});
      }} else {{
        apiContainer.innerHTML = '<span style="color:var(--text-sub);font-size:0.8rem">No APIs mapped in DB</span>';
      }}

      const elContainer = document.getElementById('m-elements');
      elContainer.innerHTML = '';
      if (s.elements && s.elements.length > 0) {{
        s.elements.forEach(el => {{
          const chip = document.createElement('span');
          chip.className = 'chip-item';
          chip.textContent = `${{el.label || el.element_key}} (${{el.element_type || 'control'}}) [${{el.test_id || 'no-cy'}}]`;
          elContainer.appendChild(chip);
        }});
      }} else {{
        elContainer.innerHTML = '<span style="color:var(--text-sub);font-size:0.8rem">No elements mapped in DB</span>';
      }}

      document.getElementById('detail-modal').style.display = 'flex';
    }}

    function closeModal() {{
      document.getElementById('detail-modal').style.display = 'none';
    }}

    document.getElementById('search-input').addEventListener('input', renderGallery);
    document.getElementById('app-filter').addEventListener('change', renderGallery);
    document.getElementById('role-filter').addEventListener('change', renderGallery);
    document.getElementById('status-filter').addEventListener('change', renderGallery);

    renderGallery();
  </script>
</body>
</html>
"""
        return html

    def generate_report(self):
        print("[ReportHandler] Extracting gallery data from governance.db...")
        data = self.extract_gallery_data()
        print(f"[ReportHandler] Loaded {len(data['screens'])} screens, {len(data['apps'])} apps, {len(data['roles'])} roles.")

        html_content = self.generate_report_html(data)

        # 1. Write to regression_report.html
        report_path_1 = os.path.join(self.project_root, 'regression_report.html')
        with open(report_path_1, 'w', encoding='utf-8') as f:
            f.write(html_content)
        print(f"[ReportHandler] Updated {report_path_1}")

        # 2. Write to docs/gallery/index.html
        docs_gallery_dir = os.path.join(self.project_root, 'docs', 'gallery')
        os.makedirs(docs_gallery_dir, exist_ok=True)
        report_path_2 = os.path.join(docs_gallery_dir, 'index.html')
        with open(report_path_2, 'w', encoding='utf-8') as f:
            f.write(html_content)
        print(f"[ReportHandler] Created {report_path_2}")

        return report_path_1, report_path_2

if __name__ == '__main__':
    handler = ReportHandler()
    handler.generate_report()
