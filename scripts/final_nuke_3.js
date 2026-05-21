const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');

console.log('--- EXECUTING FINAL COMPILER IMPORT FIX ---');

// 1. Fix clinic_routes.dart imports
const clinicRoutesPath = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'clinic_routes.dart');
if (fs.existsSync(clinicRoutesPath)) {
    let content = fs.readFileSync(clinicRoutesPath, 'utf8');
    // Remove all imports referencing the deleted dummy widgets
    content = content.replace(/import\s+'[^']*psw\/presentation\/widgets[^']*';[\r\n]+/g, '');
    
    // Also remove any remaining builder: (context) => const PswScheduleScreen() etc. that weren't caught by the GoRoute regex
    content = content.replace(/builder:\s*\(context\)\s*=>\s*const\s*Psw.*?Screen\(\),/g, 'builder: (context) => const Scaffold(body: Center(child: Text("Coming Soon"))),');

    fs.writeFileSync(clinicRoutesPath, content, 'utf8');
    console.log('✅ Purged dead imports and builders from clinic_routes.dart.');
}

// 2. Fix app_router.dart naming collision
const appRouterPath = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');
if (fs.existsSync(appRouterPath)) {
    let content = fs.readFileSync(appRouterPath, 'utf8');
    
    if (content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart' hide PswDashboardScreen, PswCarePlanScreen, PswDailyNotesScreen, PswClientProfileScreen, PswMyShiftsScreen, PswMessagingScreen;");
    }
    
    // Ensure the relative imports for the PSW screens exist
    if (!content.includes("../../features/psw/screens/psw_dashboard_screen.dart")) {
        content = content.replace("import 'clinic_routes.dart';", "import 'clinic_routes.dart';\nimport '../../features/psw/screens/psw_dashboard_screen.dart';\nimport '../../features/psw/screens/psw_care_plan_screen.dart';\nimport '../../features/psw/screens/psw_daily_notes_screen.dart';\nimport '../../features/psw/screens/psw_client_profile_screen.dart';\nimport '../../features/psw/screens/psw_my_shifts_screen.dart';\nimport '../../features/psw/screens/psw_messaging_screen.dart';");
    }

    fs.writeFileSync(appRouterPath, content, 'utf8');
    console.log('✅ Resolved naming collision in app_router.dart.');
}

console.log('--- TRIGGERING DEPLOYMENT ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('npx wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Master Hotfix Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
