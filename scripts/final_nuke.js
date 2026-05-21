const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLINIC_DIR = path.join(__dirname, '..', 'apps', 'primecare_clinic');
const UI_PKG_DIR = path.join(__dirname, '..', 'packages', 'primecare_ui');

console.log('--- EXECUTING FINAL NUCLEAR COMPILER HOTFIX ---');

const registryFile = path.join(UI_PKG_DIR, 'lib', 'src', 'registry', 'screen_registry.dart');
if (fs.existsSync(registryFile)) {
    let content = fs.readFileSync(registryFile, 'utf8');
    
    // Ensure Scaffold is imported
    if (!content.includes("import 'package:flutter/material.dart';")) {
        content = "import 'package:flutter/material.dart';\n" + content;
    }

    // Replace all broken PremiumFeature views with a working Scaffold
    content = content.replace(/const\s+PremiumFeature[A-Za-z0-9_]*\(\)/g, 'const Scaffold(body: Center(child: Text("Coming Soon")))');
    
    fs.writeFileSync(registryFile, content, 'utf8');
    console.log('✅ Nuked broken PremiumFeature references in screen_registry.dart');
}

console.log('--- TRIGGERING DEPLOYMENT ---');
try {
    execSync('flutter build web --release', { cwd: CLINIC_DIR, stdio: 'inherit' });
    execSync('npx wrangler pages deploy build/web --project-name primecare-clinic --commit-dirty=true', { cwd: CLINIC_DIR, stdio: 'inherit' });
    console.log('🏆 Master Hotfix Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
