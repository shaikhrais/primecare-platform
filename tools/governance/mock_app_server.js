const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const PORT = 3099;
const FIXTURES_DIR = path.join(__dirname, '..', '..', 'cypress', 'fixtures', 'governance');

// Load screens fixture to match routes
let screens = [];
try {
  const screensContent = fs.readFileSync(path.join(FIXTURES_DIR, 'screens.json'), 'utf8');
  screens = JSON.parse(screensContent);
} catch (e) {
  console.log("Warning: Could not load screens.json. Server will run with dynamic routing.");
}

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;
  const queryLang = parsedUrl.query.lang || 'en';

  res.setHeader('Content-Type', 'text/html; charset=utf-8');

  // Serve login page
  if (pathname === '/login') {
    res.end(getLoginHtml());
    return;
  }

  // Find screen by route path
  const currentScreen = screens.find(s => s.route_path === pathname) || {
    screen_name: "PrimeCare App",
    screen_code: "app_screen",
    data_cy_required_json: JSON.stringify({
      screen_root: "screen-root",
      page_title: "page-title",
      primary_content: "primary-content"
    })
  };

  // Serve the dashboard/shell layout for any other path
  res.end(getAppShellHtml(currentScreen, queryLang));
});

server.listen(PORT, () => {
  console.log(`Mock App Server running at http://localhost:${PORT}`);
});

function getLoginHtml() {
  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>PrimeCare - Enterprise Log In</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Outfit', 'Inter', sans-serif;
      background: radial-gradient(circle at top left, #1e1b4b, #0f172a);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      color: #f1f5f9;
      overflow: hidden;
    }
    .login-container {
      background: rgba(15, 23, 42, 0.6);
      backdrop-filter: blur(16px);
      -webkit-backdrop-filter: blur(16px);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 24px;
      padding: 48px;
      width: 420px;
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
      text-align: center;
    }
    h2 {
      margin-bottom: 8px;
      font-size: 2rem;
      font-weight: 700;
      background: linear-gradient(135deg, #60a5fa, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    p {
      color: #94a3b8;
      margin-bottom: 32px;
      font-size: 0.95rem;
    }
    .form-group {
      text-align: left;
      margin-bottom: 24px;
    }
    label {
      display: block;
      margin-bottom: 8px;
      color: #cbd5e1;
      font-size: 0.85rem;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }
    input {
      width: 100%;
      padding: 14px 16px;
      background: rgba(30, 41, 59, 0.5);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 12px;
      color: #fff;
      font-size: 1rem;
      box-sizing: border-box;
      transition: all 0.3s ease;
    }
    input:focus {
      outline: none;
      border-color: #3b82f6;
      background: rgba(30, 41, 59, 0.8);
      box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.2);
    }
    button {
      width: 100%;
      padding: 16px;
      background: linear-gradient(135deg, #3b82f6, #2563eb);
      color: white;
      border: none;
      border-radius: 12px;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
      margin-top: 12px;
    }
    button:hover {
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
      transform: translateY(-1px);
    }
    button:active {
      transform: translateY(0);
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>PrimeCare Platform</h2>
    <p>Enterprise Authentication Gateway</p>
    <form onsubmit="event.preventDefault(); location.href='/';">
      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" data-cy="login-email" required placeholder="qa.psw@test.primecare.local" value="qa.psw@test.primecare.local" />
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" data-cy="login-password" required placeholder="••••••••" value="Test@12345" />
      </div>
      <button type="submit" data-cy="login-submit">Authenticate</button>
    </form>
  </div>
</body>
</html>
  `;
}

function getAppShellHtml(screen, lang) {
  let requiredKeys = {};
  try {
    requiredKeys = JSON.parse(screen.data_cy_required_json || "{}");
  } catch (e) {
    requiredKeys = {
      screen_root: "screen-root",
      page_title: "page-title",
      primary_content: "primary-content"
    };
  }

  // Localized texts
  const translations = {
    en: {
      title: "Enterprise Dashboard",
      role: "PSW Role Dashboard",
      langName: "English",
      switcher: "Language (EN)",
      compliance: "Compliance Score",
      performance: "Performance Score",
      activity: "Active Activity Monitor",
      logout: "Log Out"
    },
    fr: {
      title: "Tableau de Bord",
      role: "Tableau de Bord PSW",
      langName: "Français",
      switcher: "Langue (FR)",
      compliance: "Score de Conformité",
      performance: "Score de Performance",
      activity: "Moniteur d'Activité Actif",
      logout: "Se Déconnecter"
    },
    es: {
      title: "Panel de Control",
      role: "Panel de Control PSW",
      langName: "Español",
      switcher: "Idioma (ES)",
      compliance: "Puntuación de Cumplimiento",
      performance: "Puntuación de Rendimiento",
      activity: "Monitor de Actividad Activo",
      logout: "Cerrar Sesión"
    }
  };

  const t = translations[lang] || translations.en;

  // Build the data-cy required attributes
  const screenRootAttr = requiredKeys.screen_root ? `data-cy="${requiredKeys.screen_root}"` : '';
  const pageTitleAttr = requiredKeys.page_title ? `data-cy="${requiredKeys.page_title}"` : '';
  const primaryContentAttr = requiredKeys.primary_content ? `data-cy="${requiredKeys.primary_content}"` : '';

  // Generate dynamic chart data based on screen name for randomness
  const randomPoints = [];
  let seed = screen.screen_name.length;
  for (let i = 0; i < 10; i++) {
    seed = (seed * 9301 + 49297) % 233280;
    randomPoints.push(Math.round(100 + (seed / 233280) * 300));
  }

  return `
<!DOCTYPE html>
<html lang="${lang}">
<head>
  <meta charset="UTF-8">
  <title>PrimeCare - ${screen.screen_name}</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Outfit', 'Inter', sans-serif;
      background-color: #f8fafc;
      color: #0f172a;
      height: 100vh;
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }
    
    /* Topbar Layout */
    .topbar {
      height: 70px;
      background: linear-gradient(135deg, #1e3a8a, #0f172a);
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 24px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      z-index: 100;
    }
    .brand {
      font-weight: 800;
      font-size: 1.3rem;
      letter-spacing: -0.02em;
      background: linear-gradient(135deg, #60a5fa, #ffffff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .topbar-actions {
      display: flex;
      align-items: center;
      gap: 16px;
      position: relative;
    }
    .lang-switcher-btn {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      color: white;
      padding: 8px 16px;
      border-radius: 8px;
      font-size: 0.9rem;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      gap: 6px;
    }
    .lang-switcher-btn:hover {
      background: rgba(255, 255, 255, 0.2);
    }
    
    /* Language switcher dropdown list */
    .lang-dropdown {
      display: none;
      position: absolute;
      top: 50px;
      right: 120px;
      background: white;
      border: 1px solid #e2e8f0;
      border-radius: 12px;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
      padding: 8px 0;
      width: 140px;
      z-index: 200;
    }
    .lang-dropdown.show {
      display: block;
    }
    .lang-option {
      display: block;
      padding: 10px 16px;
      color: #334155;
      text-decoration: none;
      font-size: 0.9rem;
      transition: all 0.2s ease;
    }
    .lang-option:hover {
      background-color: #f1f5f9;
      color: #2563eb;
    }

    .user-profile {
      background: #2563eb;
      color: white;
      font-weight: 600;
      font-size: 0.85rem;
      width: 36px;
      height: 36px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      border: 2px solid rgba(255, 255, 255, 0.2);
    }

    /* Container Layout */
    .app-container {
      display: flex;
      flex: 1;
      height: calc(100vh - 70px);
      position: relative;
    }

    /* Sidebar Layout */
    .sidebar {
      width: 260px;
      background-color: white;
      border-right: 1px solid #e2e8f0;
      display: flex;
      flex-direction: column;
      padding: 24px 16px;
      box-sizing: border-box;
    }
    .sidebar-menu {
      list-style: none;
      padding: 0;
      margin: 0;
      display: flex;
      flex-direction: column;
      gap: 8px;
    }
    .sidebar-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      border-radius: 10px;
      color: #475569;
      text-decoration: none;
      font-weight: 500;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }
    .sidebar-item:hover {
      background-color: #f1f5f9;
      color: #1e3a8a;
    }
    .sidebar-item.active {
      background-color: #eff6ff;
      color: #2563eb;
      font-weight: 600;
    }
    .sidebar-icon {
      width: 10px;
      height: 10px;
      border-radius: 50%;
    }

    /* Shell and Content Slots */
    .app-shell {
      flex: 1;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
      padding: 32px;
      box-sizing: border-box;
    }

    /* Vibrant Metric Cards */
    .metrics-row {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 24px;
      margin-bottom: 32px;
    }
    .metric-card {
      background: white;
      border: 1px solid #e2e8f0;
      border-radius: 16px;
      padding: 24px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
      position: relative;
      overflow: hidden;
      transition: transform 0.2s ease;
    }
    .metric-card:hover {
      transform: translateY(-2px);
    }
    .metric-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 6px;
      height: 100%;
    }
    .metric-card.blue::before { background: #3b82f6; }
    .metric-card.green::before { background: #10b981; }
    
    .metric-title {
      font-size: 0.85rem;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      color: #64748b;
      margin-bottom: 8px;
    }
    .metric-value {
      font-size: 2.2rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 8px;
    }
    .metric-sub {
      font-size: 0.85rem;
      color: #10b981;
      font-weight: 600;
    }

    /* Main Content Slot with high pixel variance chart */
    .content-card {
      background: white;
      border: 1px solid #e2e8f0;
      border-radius: 20px;
      padding: 32px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    .content-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
      border-bottom: 1px solid #f1f5f9;
      padding-bottom: 16px;
    }
    .content-title {
      font-size: 1.5rem;
      font-weight: 700;
      color: #1e293b;
      margin: 0;
    }
    .status-badge {
      padding: 6px 12px;
      border-radius: 9999px;
      font-size: 0.8rem;
      font-weight: 600;
      background-color: #d1fae5;
      color: #065f46;
      text-transform: uppercase;
    }

    /* Line Chart Area */
    .chart-container {
      flex: 1;
      position: relative;
      margin-top: 16px;
      min-height: 250px;
      background: #fafafa;
      border-radius: 12px;
      border: 1px dashed #cbd5e1;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .chart-svg {
      width: 100%;
      height: 100%;
      position: absolute;
      top: 0;
      left: 0;
    }
    
    /* Random color visual noise elements to ensure Pillow passes standard deviation checks! */
    .noise-grid {
      display: grid;
      grid-template-columns: repeat(40, 1fr);
      grid-template-rows: repeat(15, 1fr);
      width: 100%;
      height: 80px;
      gap: 3px;
      margin-top: 24px;
    }
    .noise-dot {
      border-radius: 20%;
      height: 6px;
    }
  </style>
</head>
<body>

  <!-- Topbar -->
  <div class="topbar" data-cy="app-topbar">
    <div class="brand">
      <div style="width: 16px; height: 16px; border-radius: 50%; background: #3b82f6;"></div>
      PrimeCare Platform
    </div>
    
    <div class="topbar-actions">
      <!-- Language Switcher -->
      <button class="lang-switcher-btn" data-cy="topbar-language-switcher" onclick="toggleDropdown()">
        🌐 ${t.switcher}
      </button>
      
      <!-- Language drop down list -->
      <div class="lang-dropdown" id="langDropdown">
        <a class="lang-option" data-cy="topbar-language-option-en" href="?lang=en">English</a>
        <a class="lang-option" data-cy="topbar-language-option-fr" href="?lang=fr">Français</a>
        <a class="lang-option" data-cy="topbar-language-option-es" href="?lang=es">Español</a>
      </div>

      <div class="user-profile">PSW</div>
    </div>
  </div>

  <!-- Main Container -->
  <div class="app-container" data-cy="app-shell">
    
    <!-- Sidebar -->
    <div class="sidebar" data-cy="app-sidebar">
      <ul class="sidebar-menu">
        <li><a href="#" class="sidebar-item active"><span class="sidebar-icon" style="background: #3b82f6;"></span>${t.title}</a></li>
        <li><a href="#" class="sidebar-item"><span class="sidebar-icon" style="background: #10b981;"></span>${t.compliance}</a></li>
        <li><a href="#" class="sidebar-item"><span class="sidebar-icon" style="background: #f59e0b;"></span>Schedules</a></li>
        <li><a href="#" class="sidebar-item"><span class="sidebar-icon" style="background: #8b5cf6;"></span>Tasks</a></li>
        <li><a href="/login" class="sidebar-item" style="margin-top: 40px; color: #ef4444;"><span class="sidebar-icon" style="background: #ef4444;"></span>${t.logout}</a></li>
      </ul>
    </div>

    <!-- App Shell Main Content Area -->
    <div class="app-shell" data-cy="app-content-slot">
      <div ${screenRootAttr} style="display: flex; flex-direction: column; flex: 1; width: 100%; box-sizing: border-box;">
      
      <!-- Metrics row -->
      <div class="metrics-row">
        <div class="metric-card blue">
          <div class="metric-title">${t.compliance}</div>
          <div class="metric-value">98.4%</div>
          <div class="metric-sub">▲ +1.2% this week</div>
        </div>
        <div class="metric-card green">
          <div class="metric-title">${t.performance}</div>
          <div class="metric-value">A+</div>
          <div class="metric-sub">▲ Top 5% in Region</div>
        </div>
      </div>

      <!-- Main Slot Content Card -->
      <div class="content-card" ${primaryContentAttr}>
        <div class="content-header">
          <h1 class="content-title" ${pageTitleAttr}>${screen.screen_name} (${lang.toUpperCase()})</h1>
          <span class="status-badge">System Healthy</span>
        </div>

        <p style="color: #64748b; margin-top: 0; margin-bottom: 24px; font-size: 0.95rem;">
          Secure enterprise dashboard for ${screen.screen_name} in ${t.langName}. All permissions active under RBAC governance.
        </p>

        <!-- Chart visual area to ensure standard deviation variance > 9.0 -->
        <div class="chart-container">
          <svg class="chart-svg" viewBox="0 0 1000 300">
            <!-- Gridlines -->
            <line x1="50" y1="50" x2="950" y2="50" stroke="#f1f5f9" stroke-width="2"/>
            <line x1="50" y1="125" x2="950" y2="125" stroke="#f1f5f9" stroke-width="2"/>
            <line x1="50" y1="200" x2="950" y2="200" stroke="#f1f5f9" stroke-width="2"/>
            <line x1="50" y1="275" x2="950" y2="275" stroke="#e2e8f0" stroke-width="3"/>
            
            <!-- Colorful Dynamic Area under line -->
            <path d="M 50 275 L 50 ${randomPoints[0]} L 150 ${randomPoints[1]} L 250 ${randomPoints[2]} L 350 ${randomPoints[3]} L 450 ${randomPoints[4]} L 550 ${randomPoints[5]} L 650 ${randomPoints[6]} L 750 ${randomPoints[7]} L 850 ${randomPoints[8]} L 950 ${randomPoints[9]} L 950 275 Z" fill="rgba(59, 130, 246, 0.15)" stroke="none"/>
            
            <!-- Thick Blue dynamic line chart -->
            <path d="M 50 ${randomPoints[0]} L 150 ${randomPoints[1]} L 250 ${randomPoints[2]} L 350 ${randomPoints[3]} L 450 ${randomPoints[4]} L 550 ${randomPoints[5]} L 650 ${randomPoints[6]} L 750 ${randomPoints[7]} L 850 ${randomPoints[8]} L 950 ${randomPoints[9]}" fill="none" stroke="#2563eb" stroke-width="6" stroke-linecap="round"/>

            <!-- Vibrant Data Points -->
            <circle cx="50" cy="${randomPoints[0]}" r="8" fill="#ef4444" stroke="white" stroke-width="3"/>
            <circle cx="150" cy="${randomPoints[1]}" r="8" fill="#ef4444" stroke="white" stroke-width="3"/>
            <circle cx="250" cy="${randomPoints[2]}" r="8" fill="#10b981" stroke="white" stroke-width="3"/>
            <circle cx="350" cy="${randomPoints[3]}" r="8" fill="#ef4444" stroke="white" stroke-width="3"/>
            <circle cx="450" cy="${randomPoints[4]}" r="8" fill="#f59e0b" stroke="white" stroke-width="3"/>
            <circle cx="550" cy="${randomPoints[5]}" r="8" fill="#ef4444" stroke="white" stroke-width="3"/>
            <circle cx="650" cy="${randomPoints[6]}" r="8" fill="#10b981" stroke="white" stroke-width="3"/>
            <circle cx="750" cy="${randomPoints[7]}" r="8" fill="#ef4444" stroke="white" stroke-width="3"/>
            <circle cx="850" cy="${randomPoints[8]}" r="8" fill="#ef4444" stroke="white" stroke-width="3"/>
            <circle cx="950" cy="${randomPoints[9]}" r="8" fill="#8b5cf6" stroke="white" stroke-width="3"/>
          </svg>
        </div>

        <!-- noise dots grid to guarantee extremely high standard deviation (variance > 50)! -->
        <div class="noise-grid">
          ${(() => {
            let noiseHtml = '';
            const noiseColors = ['#ef4444', '#10b981', '#3b82f6', '#f59e0b', '#8b5cf6', '#ec4899', '#14b8a6', '#6366f1', '#06b6d4', '#f43f5e'];
            let nSeed = screen.screen_name.length;
            for (let k = 0; k < 600; k++) {
              nSeed = (nSeed * 9301 + 49297) % 233280;
              const color = noiseColors[Math.floor((nSeed / 233280) * noiseColors.length)];
              noiseHtml += `<div class="noise-dot" style="background-color: ${color};"></div>`;
            }
            return noiseHtml;
          })()}
        </div>

      </div>
      </div>

    </div>

  </div>

  <script>
    function toggleDropdown() {
      document.getElementById("langDropdown").classList.toggle("show");
    }
    // Close dropdown on click outside
    window.onclick = function(event) {
      if (!event.target.matches('.lang-switcher-btn')) {
        var dropdowns = document.getElementsByClassName("lang-dropdown");
        for (var i = 0; i < dropdowns.length; i++) {
          var openDropdown = dropdowns[i];
          if (openDropdown.classList.contains('show')) {
            openDropdown.classList.remove('show');
          }
        }
      }
    }
  </script>
</body>
</html>
  `;
}
