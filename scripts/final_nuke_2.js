const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');

console.log('--- EXECUTING FINAL COMPILER PATH FIX ---');

// 1. Fix app_router.dart imports
const appRouterPath = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'app_router.dart');
if (fs.existsSync(appRouterPath)) {
    let content = fs.readFileSync(appRouterPath, 'utf8');
    content = content.replace(/\.\.\/features\/psw/g, '../../features/psw');
    fs.writeFileSync(appRouterPath, content, 'utf8');
    console.log('✅ Fixed app_router.dart imports.');
}

// 2. Fix clinic_routes.dart which references deleted dummy screens
const clinicRoutesPath = path.join(CLINIC_DIR, 'lib', 'core', 'routing', 'clinic_routes.dart');
if (fs.existsSync(clinicRoutesPath)) {
    let content = fs.readFileSync(clinicRoutesPath, 'utf8');
    // Remove all references to PswDashboardScreen, PswScheduleScreen, etc. that were deleted
    // Since this is a massive array of routes, we can just safely purge the PSW block since we injected them directly in app_router.dart
    content = content.replace(/GoRoute\([\s\S]*?Psw.*?Screen.*?\),/g, '');
    fs.writeFileSync(clinicRoutesPath, content, 'utf8');
    console.log('✅ Purged dead PSW dummy routes from clinic_routes.dart.');
}

console.log('--- TRIGGERING DEPLOYMENT ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Master Hotfix Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
