const fs = require('fs');
const path = require('path');

const srcTheme = path.join(__dirname, '..', 'lib', 'core');
const srcLayouts = path.join(__dirname, '..', 'lib', 'features', 'shared', 'layouts');
const destFramework = path.join(__dirname, '..', '..', '..', 'packages', 'primecare_ui', 'lib', 'src', 'theme');

if (!fs.existsSync(destFramework)) fs.mkdirSync(destFramework, { recursive: true });

// Move Theme Files
function safeCopy(file, fromDir, renameTo = file) {
  const fromPath = path.join(fromDir, file);
  const toPath = path.join(destFramework, renameTo);
  if (fs.existsSync(fromPath)) {
    let content = fs.readFileSync(fromPath, 'utf8');
    // Correct internal paths if they point backward
    content = content.replace(/\.\.\/\.\.\/\.\.\/core\/colors\.dart/g, 'colors.dart');
    content = content.replace(/\.\.\/\.\.\/\.\.\/core\/theme_tokens\.dart/g, 'theme_tokens.dart');
    content = content.replace(/\.\.\/\.\.\/\.\.\/core\/theme_extension\.dart/g, 'theme_extension.dart');
    
    // We remove the old files so we don't end up with duplicate imports across the app resolving to the old file locally.
    // BUT we shouldn't delete them instantly because 600 files currently import 'core/colors.dart'.
    // If we delete it, ALL 600 files will error `File not found`.
    // Instead, we overwrite the local 'core/colors.dart' to just export the package!
    
    fs.writeFileSync(toPath, content, 'utf8');
    console.log(`[EXPORTED] ${file} -> primecare_ui/src/theme/${renameTo}`);
  }
}

safeCopy('colors.dart', srcTheme);
safeCopy('theme_tokens.dart', srcTheme);
safeCopy('theme_extension.dart', srcTheme);
safeCopy('theme.dart', srcTheme, 'primecare_theme.dart');
safeCopy('responsive_shell.dart', srcLayouts, 'primecare_responsive_shell.dart');

// Update primecare_ui.dart exports
const exportPath = path.join(__dirname, '..', '..', '..', 'packages', 'primecare_ui', 'lib', 'primecare_ui.dart');
if (fs.existsSync(exportPath)) {
  let exportsContent = fs.readFileSync(exportPath, 'utf8');
  const missingExports = [
    "export 'src/theme/colors.dart';",
    "export 'src/theme/theme_tokens.dart';",
    "export 'src/theme/theme_extension.dart';",
    "export 'src/theme/primecare_theme.dart';",
    "export 'src/theme/primecare_responsive_shell.dart';"
  ];
  let appended = false;
  missingExports.forEach(e => {
    if (!exportsContent.includes(e)) {
      exportsContent += '\n' + e;
      appended = true;
    }
  });
  if (appended) {
    fs.writeFileSync(exportPath, exportsContent, 'utf8');
    console.log(`[UPDATED] package primecare_ui exports patched.`);
  }
}

// Build a proxy bridge in the original locations so we don't break the millions of existing imports!
fs.writeFileSync(path.join(srcTheme, 'colors.dart'), "export 'package:primecare_ui/primecare_ui.dart';", 'utf8');
fs.writeFileSync(path.join(srcTheme, 'theme_tokens.dart'), "export 'package:primecare_ui/primecare_ui.dart';", 'utf8');
fs.writeFileSync(path.join(srcTheme, 'theme_extension.dart'), "export 'package:primecare_ui/primecare_ui.dart';", 'utf8');
fs.writeFileSync(path.join(srcTheme, 'theme.dart'), "export 'package:primecare_ui/primecare_ui.dart';", 'utf8');
fs.writeFileSync(path.join(srcLayouts, 'responsive_shell.dart'), "export 'package:primecare_ui/primecare_ui.dart';", 'utf8');

console.log("[FRAMEWORK BRIDGE] Local app proxies successfully bound to the core package natively.");
