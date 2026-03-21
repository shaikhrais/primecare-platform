const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');
const targets = [
  'features/shared/layouts/master_detail_layout.dart',
  'features/shared/layouts/desktop_pane_wrapper.dart',
  'features/shared/layouts/responsive_layout_manager.dart',
  'features/shared/widgets/offline_banner.dart',
  'core/widgets/primecare_app_bar.dart',
  'features/shared/sdui_form_builder.dart',
];

const targetBasenames = targets.map(t => path.basename(t));

function processDirectory(dir) {
  for (let f of fs.readdirSync(dir)) {
    let p = path.join(dir, f);
    if (fs.statSync(p).isDirectory()) {
      processDirectory(p);
    } else if (p.endsWith('.dart')) {
      // Ignore acting upon the physical targets themselves yet
      let isTarget = targets.some(t => p.replace(/\\/g, '/').endsWith(t));
      if (isTarget) continue;

      let content = fs.readFileSync(p, 'utf8');
      let modified = false;

      let lines = content.split('\n');
      for (let i = 0; i < lines.length; i++) {
        let line = lines[i];
        if (line.startsWith('import ')) {
          // If the internal path references one of the eradicated basenames
          let matchesTarget = targetBasenames.some(b => line.includes(b));
          if (matchesTarget) {
             lines[i] = "import 'package:primecare_ui/primecare_ui.dart';";
             modified = true;
          }
        }
      }

      if (modified) {
        // Truncate structural duplicate import mutations (prevent import fracture)
        let finalLines = [];
        let hasUIImport = false;
        for (let line of lines) {
           if (line.trim() === "import 'package:primecare_ui/primecare_ui.dart';") {
             if (hasUIImport) continue; 
             hasUIImport = true;
           }
           finalLines.push(line);
        }
        fs.writeFileSync(p, finalLines.join('\n'), 'utf8');
        console.log(`[RE-ROUTED] ${path.basename(p)} -> primecare_ui`);
      }
    }
  }
}

// 1. Traverse AST dependencies natively across the primary architecture
processDirectory(srcRoot);

// 2. Physical Eradication
targets.forEach(t => {
  let p = path.join(srcRoot, ...t.split('/'));
  if (fs.existsSync(p)) {
    fs.unlinkSync(p);
    console.log(`[DELETED] ${t}`);
  }
});

console.log('Absolute Component Eradication Complete.');
