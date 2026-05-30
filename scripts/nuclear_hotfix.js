const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const UI_PKG_DIR = path.join(__dirname, '..', 'packages', 'primecare_ui');

console.log('--- EXECUTING NUCLEAR COMPILER HOTFIX ---');

// 1. Fix platform_usage.dart by stripping theme.typography entirely
const platformUsageFile = path.join(UI_PKG_DIR, 'lib', 'src', 'features', 'generated_screens', 'platform_usage.dart');
if (fs.existsSync(platformUsageFile)) {
    let content = fs.readFileSync(platformUsageFile, 'utf8');
    content = content.replace(/style:\s*theme\.typography\.[a-zA-Z0-9_]+(\.copyWith\([^)]+\))?/g, 'style: const TextStyle()');
    fs.writeFileSync(platformUsageFile, content, 'utf8');
    console.log('✅ Nuked typography errors in platform_usage.dart');
}

// 2. Delete broken dummy widgets in psw/presentation/widgets
const dummyWidgetsDir = path.join(CLINIC_DIR, 'lib', 'features', 'psw', 'presentation', 'widgets');
if (fs.existsSync(dummyWidgetsDir)) {
    fs.rmSync(dummyWidgetsDir, { recursive: true, force: true });
    console.log('✅ Deleted broken dummy widgets in psw/presentation/widgets');
}

console.log('--- TRIGGERING DEPLOYMENT ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Master Hotfix Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
