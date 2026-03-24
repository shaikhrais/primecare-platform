const fs = require('fs');

const oldPath = 'lib/features/psw/psw_dashboard_screen.dart';
const newPath = 'lib/features/psw/psw_shifts_screen.dart';

// 1. Rewrite the Dart class content in the new file
let screenCode = fs.readFileSync(oldPath, 'utf8');
screenCode = screenCode.replace(/PswDashboardScreen/g, 'PswShiftsScreen');
fs.writeFileSync(newPath, screenCode);
fs.unlinkSync(oldPath); // delete old file

// 2. Update GoRouter definition logic in Main.dart
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');
mainCode = mainCode.replace("import 'features/psw/psw_dashboard_screen.dart';", "import 'features/psw/psw_shifts_screen.dart';");
mainCode = mainCode.replace("GoRoute(path: '/psw/dashboard', builder: (context, state) => PswDashboardScreen()),", "GoRoute(path: '/psw/shifts', builder: (context, state) => PswShiftsScreen()),");
fs.writeFileSync('lib/main.dart', mainCode);

// 3. Repath the physical Universal Sidebar array link
let sidebarCode = fs.readFileSync('lib/core/widgets/universal_role_sidebar.dart', 'utf8');
sidebarCode = sidebarCode.replace(/\/psw\/dashboard/g, '/psw/shifts');
fs.writeFileSync('lib/core/widgets/universal_role_sidebar.dart', sidebarCode);

console.log("Renamed PswDashboardScreen to PswShiftsScreen natively!");
