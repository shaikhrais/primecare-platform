const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');
const destComponents = path.join(__dirname, '..', '..', '..', 'packages', 'primecare_ui', 'lib', 'src', 'components');

if (!fs.existsSync(destComponents)) fs.mkdirSync(destComponents, { recursive: true });

const targets = [
  { file: 'master_detail_layout.dart', dir: 'features/shared/layouts' },
  { file: 'desktop_pane_wrapper.dart', dir: 'features/shared/layouts' },
  { file: 'responsive_layout_manager.dart', dir: 'features/shared/layouts' },
  { file: 'offline_banner.dart', dir: 'features/shared/widgets' },
  { file: 'primecare_app_bar.dart', dir: 'core/widgets' },
  { file: 'sdui_form_builder.dart', dir: 'features/shared' },
];

targets.forEach(t => {
  const fromPath = path.join(srcRoot, t.dir, t.file);
  const toPath = path.join(destComponents, t.file);
  if (fs.existsSync(fromPath)) {
    let content = fs.readFileSync(fromPath, 'utf8');
    
    // Correct absolute inner bindings preventing cyclical package collisions natively
    content = content.replace(/import '.*colors\.dart';/g, "import '../theme/colors.dart';");
    content = content.replace(/import '.*theme_tokens\.dart';/g, "import '../theme/theme_tokens.dart';");
    content = content.replace(/import '.*theme_extension\.dart';/g, "import '../theme/theme_extension.dart';");
    content = content.replace(/import '.*theme\.dart';/g, "import '../theme/primecare_theme.dart';");
    
    /// Handle package references physically pointing back internally
    content = content.replace(/import 'package:primecare_ui\/primecare_ui\.dart';/g, "");

    fs.writeFileSync(toPath, content, 'utf8');
    
    // Mount the absolute Proxy Bridge preserving existing Application configurations perfectly
    fs.writeFileSync(fromPath, "export 'package:primecare_ui/primecare_ui.dart';", 'utf8');
    console.log(`[EXPORTED] ${t.file} -> primecare_ui/src/components`);
  }
});

const exportPath = path.join(__dirname, '..', '..', '..', 'packages', 'primecare_ui', 'lib', 'primecare_ui.dart');
if (fs.existsSync(exportPath)) {
  let exportsContent = fs.readFileSync(exportPath, 'utf8');
  targets.forEach(t => {
    const e = `export 'src/components/${t.file}';`;
    if (!exportsContent.includes(e)) {
      exportsContent += '\n' + e;
    }
  });
  fs.writeFileSync(exportPath, exportsContent, 'utf8');
  console.log(`[UPDATED] Attached 6 physical export bridges dynamically to package matrix.`);
}
