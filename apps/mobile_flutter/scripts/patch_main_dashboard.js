const fs = require('fs');
const path = require('path');

const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');
let mainCode = fs.readFileSync(mainPath, 'utf8');

if (!mainCode.includes("import 'features/shared/universal_dashboard_screen.dart';")) {
  mainCode = "import 'features/shared/universal_dashboard_screen.dart';\n" + mainCode;
}

// 1. Remove all old hardcoded generic Dashboard instances that failed
const roles = ['rn', 'psw', 'client', 'coordinator', 'admin', 'manager', 'scrum-master', 'gm', 'mt'];
roles.forEach(role => {
  // Catch patterns like GoRoute(path: '/rn/dashboard', builder: (context, state) => UniversalHostScreen(endpoint: '/v1/sdui/dashboard')),
  const regex = new RegExp(`GoRoute\\(\\s*path:\\s*'\\/${role}\\/dashboard'[\\s\\S]*?\\),`, 'g');
  mainCode = mainCode.replace(regex, "");
});

// 2. Inject Native Universal Dashboard global hook resolving everything
const dashboardRoute = `GoRoute(path: '/:role/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),`;
if (!mainCode.includes(dashboardRoute)) {
  mainCode = mainCode.replace("routes: [", "routes: [\n        " + dashboardRoute + "\n");
}

fs.writeFileSync(mainPath, mainCode);
console.log('Main.dart globally scrubbed and patched mapping the Universal Dashboard Hub to all 9 roles properly!');
