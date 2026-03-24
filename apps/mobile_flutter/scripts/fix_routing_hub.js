const fs = require('fs');

// Patch 1: Sidebar Paths
let sidebarCode = fs.readFileSync('lib/core/widgets/universal_role_sidebar.dart', 'utf8');
sidebarCode = sidebarCode.replace(/paths = \[\'\/([a-zA-Z-]+)\/(dashboard|home)\'/g, "paths = ['/$1/hub'");
fs.writeFileSync('lib/core/widgets/universal_role_sidebar.dart', sidebarCode);

// Patch 2: Main.dart Dynamic Route & Redirects
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');
mainCode = mainCode.replace("GoRoute(path: '/:role/dashboard', builder: (context, state) => UniversalDashboardScreen", "GoRoute(path: '/:role/hub', builder: (context, state) => UniversalDashboardScreen");

mainCode = mainCode.replace(/return '\/([a-zA-Z-]+)\/dashboard';/g, "return '/$1/hub';");
mainCode = mainCode.replace(/return '\/psw\/home';/g, "return '/psw/hub';");

fs.writeFileSync('lib/main.dart', mainCode);
console.log('Fixed Sidebar and Main routing paths to Hub dynamically!');
