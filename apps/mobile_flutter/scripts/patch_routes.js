const fs = require('fs');

// Patch main.dart
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');
if (!mainCode.includes('dashboard_screen.dart')) {
    mainCode = mainCode.replace("import 'features/auth/login_screen.dart';", "import 'features/auth/login_screen.dart';\nimport 'features/dashboard/dashboard_screen.dart';");
}
if (!mainCode.includes("path: '/dashboard'")) {
    mainCode = mainCode.replace("GoRoute(\n        path: '/login',", "GoRoute(\n        path: '/dashboard',\n        builder: (context, state) => DashboardScreen(),\n      ),\n      GoRoute(\n        path: '/login',");
}
// Fix redirect logic natively
mainCode = mainCode.replace("case 'manager':\n          case 'admin': return '/manager/dashboard';", "case 'manager': return '/manager/dashboard';\n          case 'admin':\n          case 'super_admin': return '/dashboard';");
fs.writeFileSync('lib/main.dart', mainCode);

// Patch login_screen.dart
let loginCode = fs.readFileSync('lib/features/auth/login_screen.dart', 'utf8');
loginCode = loginCode.replace(/case 'manager':\s*case 'admin':\s*context\.go\('\/manager\/dashboard'\);/, "case 'manager':\n            context.go('/manager/dashboard');\n            break;\n          case 'admin':\n          case 'super_admin':\n            context.go('/dashboard');");
fs.writeFileSync('lib/features/auth/login_screen.dart', loginCode);

console.log('Routes strictly aligned.');
