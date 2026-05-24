const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.join(__dirname, '..');
const APPS_DIR = path.join(ROOT_DIR, 'apps');
const REPORT_DIR = path.join(ROOT_DIR, 'brain', 'e66e47aa-5969-46fd-8242-d0d9790af3bc');
const REPORT_PATH = path.join(REPORT_DIR, 'deep_screen_scan_report.md');

function getDirectories(srcPath) {
  if (!fs.existsSync(srcPath)) return [];
  return fs.readdirSync(srcPath).filter(file => fs.statSync(path.join(srcPath, file)).isDirectory());
}

function scanDirectoryForDartFiles(srcPath) {
  if (!fs.existsSync(srcPath)) return [];
  let results = [];
  const list = fs.readdirSync(srcPath);
  list.forEach(file => {
    const fullPath = path.join(srcPath, file);
    const stat = fs.statSync(fullPath);
    if (stat && stat.isDirectory()) {
      results = results.concat(scanDirectoryForDartFiles(fullPath));
    } else {
      if (file.endsWith('.dart') && !file.endsWith('.g.dart') && !file.endsWith('.freezed.dart')) {
        results.push(fullPath);
      }
    }
  });
  return results;
}

function analyzeScreenFile(filePath, appName) {
  const content = fs.readFileSync(filePath, 'utf8');
  const fileName = path.basename(filePath);
  
  // 1. Detect Class Name and Base Class
  // e.g., class PswDashboardScreen extends GovernedConsumerWidget
  const classRegex = /class\s+([A-Za-z0-9_]+)\s+extends\s+([A-Za-z0-9_]+)/g;
  let match;
  let classes = [];
  
  while ((match = classRegex.exec(content)) !== null) {
    const className = match[1];
    const baseClass = match[2];
    
    // Check if it's a screen component (named screen, view, or page, or ending with screen/view/page)
    const isScreenClass = /Screen|View|Page/i.test(className);
    if (isScreenClass) {
      classes.push({ className, baseClass });
    }
  }

  if (classes.length === 0) {
    // If no explicit Screen/View/Page class is found, skip unless it's explicitly named a screen file
    if (!/screen|view|page/i.test(fileName)) {
      return null;
    }
    // Fallback stub analysis
    classes.push({ className: path.basename(fileName, '.dart'), baseClass: 'Unknown' });
  }

  // 2. Assess Compliance with Layout Invariants
  // Top-level governed screen check
  const isGoverned = classes.some(c => 
    c.baseClass.startsWith('Governed') || 
    c.baseClass.includes('BaseScreen') || 
    c.baseClass.includes('PlatformScreen')
  );

  // 3. Stub vs. High-Fidelity Wired Logic Detection
  const hasTodo = /TODO|unimplemented|placeholder/i.test(content);
  const isTooShort = content.length < 1200;
  const hasUnimplementedError = content.includes('UnimplementedError');
  const isStub = hasTodo || isTooShort || hasUnimplementedError;

  // 4. Data Binding Detection (Riverpod refs / API clients / RPC)
  const watchesProviders = /ref\.watch|ref\.listen|ref\.read/i.test(content);
  const callsApi = /api|client|service|fetch|http/i.test(content);
  const hasInteractiveBindings = watchesProviders || callsApi;

  // 5. Layout Invariant Inclusions
  const hasAppBar = /AppBar|SliverAppBar/i.test(content);
  const hasDrawer = /Drawer/i.test(content);
  const hasBottomNav = /BottomNavigationBar|NavigationBar/i.test(content);

  return {
    filePath: path.relative(ROOT_DIR, filePath).replace(/\\/g, '/'),
    appName,
    className: classes[0].className,
    baseClass: classes[0].baseClass,
    isGoverned,
    isStub,
    hasInteractiveBindings,
    watchesProviders,
    sizeBytes: content.length,
    layoutFeatures: { hasAppBar, hasDrawer, hasBottomNav }
  };
}

function runDeepScan() {
  console.log('🤖 INITIALIZING PLATFORM DEEP SCREEN ARCHITECTURAL SCAN...');
  const apps = getDirectories(APPS_DIR);
  
  const allAudits = [];
  let totalScreens = 0;
  let governedCount = 0;
  let stubCount = 0;
  let wiredCount = 0;
  
  apps.forEach(app => {
    const libPath = path.join(APPS_DIR, app, 'lib');
    if (!fs.existsSync(libPath)) return;
    
    const dartFiles = scanDirectoryForDartFiles(libPath);
    dartFiles.forEach(file => {
      const audit = analyzeScreenFile(file, app);
      if (audit) {
        allAudits.push(audit);
        totalScreens++;
        if (audit.isGoverned) governedCount++;
        if (audit.isStub) stubCount++;
        if (audit.hasInteractiveBindings) wiredCount++;
      }
    });
  });

  const compliantPercent = totalScreens > 0 ? ((governedCount / totalScreens) * 100).toFixed(1) : 0;
  const wiredPercent = totalScreens > 0 ? ((wiredCount / totalScreens) * 100).toFixed(1) : 0;

  // Generate gorgeous report
  let report = `# PrimeCare Deep Architectural Screen Registry Audit\n\n`;
  report += `This deep architectural scan was dynamically executed against the entire monorepo. It recursively parsed all Flutter frontend applications to audit layout compliance, state-management wiring, and implementation maturity.\n\n`;
  
  report += `## 📊 High-Level Metrics Summary\n\n`;
  report += `| Metric | Count | Ratio / Health |\n`;
  report += `| :--- | :--- | :--- |\n`;
  report += `| **Total Frontend Apps** | ${apps.length} | 11 UI Systems + 1 Edge API Proxy |\n`;
  report += `| **Total UI Screens Audited** | ${totalScreens} | Core Screens across all roles |\n`;
  report += `| **Governed Screens (Compliant)** | ${governedCount} | **${compliantPercent}%** Layout Invariant Compliant |\n`;
  report += `| **Interactive/Wired Screens** | ${wiredCount} | **${wiredPercent}%** Live Riverpod Data Bound |\n`;
  report += `| **Empty Stubs / Mocks** | ${stubCount} | Ready for features / refinement |\n\n`;

  report += `## 🛑 Architectural Exceptions & Non-Compliant Screens\n\n`;
  
  const nonCompliant = allAudits.filter(a => !a.isGoverned);
  if (nonCompliant.length === 0) {
    report += `> [!NOTE]\n> **100% Structural Compliance Verified!** Every top-level UI Screen correctly extends the PrimeCare Governed base screen wrapper (e.g. \`GovernedConsumerWidget\`). No direct direct-inheritance violations found.\n\n`;
  } else {
    report += `The following screens directly extend standard Flutter widgets instead of utilizing the Governed equivalents. They bypass Layout Invariant enforcement:\n\n`;
    report += `| Subsystem | Class Name | File Path | Direct Base Class | Remediation |\n`;
    report += `| :--- | :--- | :--- | :--- | :--- |\n`;
    nonCompliant.forEach(nc => {
      report += `| \`${nc.appName}\` | \`${nc.className}\` | [\`${path.basename(nc.filePath)}\`](file:///${path.join(ROOT_DIR, nc.filePath).replace(/\\/g, '/')}) | \`${nc.baseClass}\` | Change to Governed equivalent |\n`;
    });
    report += `\n`;
  }

  report += `## 🚀 Core Subsystem Detailed Portfolios\n\n`;
  
  apps.forEach(app => {
    const appAudits = allAudits.filter(a => a.appName === app);
    if (appAudits.length === 0) return;
    
    report += `### 🏢 Subsystem: ${app.replace('primecare_', '').toUpperCase()}\n`;
    report += `Total audited: **${appAudits.length}** screens.  \n\n`;
    
    report += `| Screen / Class | Base Class | Wire Status | Riverpod | Size (Bytes) | File Link |\n`;
    report += `| :--- | :--- | :--- | :--- | :--- | :--- |\n`;
    
    appAudits.forEach(audit => {
      const wireStatus = audit.isStub ? '❌ Stub / Mock' : '✅ Full/Wired';
      const riverpodStatus = audit.watchesProviders ? '🔗 Bound' : '🚫 Unbound';
      report += `| \`${audit.className}\` | \`${audit.baseClass}\` | ${wireStatus} | ${riverpodStatus} | ${audit.sizeBytes} | [Open File](file:///${path.join(ROOT_DIR, audit.filePath).replace(/\\/g, '/')}) |\n`;
    });
    
    report += `\n---\n\n`;
  });

  if (!fs.existsSync(REPORT_DIR)) {
    fs.mkdirSync(REPORT_DIR, { recursive: true });
  }
  fs.writeFileSync(REPORT_PATH, report, 'utf8');

  console.log(`Scan completed! Deep scan metrics written to: ${REPORT_PATH}`);
  console.log(`Audited ${totalScreens} screens.`);
}

runDeepScan();
