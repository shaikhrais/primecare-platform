const fs = require('fs');

// 1. Sidebar Routes
let sidebarCode = fs.readFileSync('lib/core/widgets/universal_role_sidebar.dart', 'utf8');
sidebarCode = sidebarCode.replace(/\/psw\/hub/g, '/psw/home');
sidebarCode = sidebarCode.replace(/\/([a-zA-Z-]+)\/hub/g, '/$1/dashboard');
fs.writeFileSync('lib/core/widgets/universal_role_sidebar.dart', sidebarCode);

// 2. Main.dart
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');
mainCode = mainCode.replace(/return '\/psw\/hub';/g, "return '/psw/home';");
mainCode = mainCode.replace(/return '\/([a-zA-Z-]+)\/hub';/g, "return '/$1/dashboard';");

// Remove the global catchall explicitly
const strToKill = "GoRoute(path: '/:role/hub', builder: (context, state) => UniversalDashboardScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),";
mainCode = mainCode.replace(strToKill, "");

// Inject the explicit broken roles
const pswAnchor = "// ======================= PSW =======================";
if (mainCode.includes(pswAnchor) && !mainCode.includes("UniversalDashboardScreen(rolePrefix: 'rn')")) {
    const explicitHubs = `// ======================= NATIVE GRID HUBS =======================
          GoRoute(path: '/rn/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: 'rn')),
          GoRoute(path: '/mt/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: 'mt')),
          GoRoute(path: '/gm/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: 'gm')),
          GoRoute(path: '/scrum-master/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: 'scrum_master')),
          
          `;
    mainCode = mainCode.replace(pswAnchor, explicitHubs + pswAnchor);
}

fs.writeFileSync('lib/main.dart', mainCode);
console.log('Successfully reverted global Hub overrides!');
