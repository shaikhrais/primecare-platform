const fs = require('fs');
const path = require('path');

const UI_LIB = path.join(__dirname, '../../packages/primecare_ui/lib');
const MOBILE_LIB = path.join(__dirname, 'lib');

// Define exactly what we are shifting relative to mobile_flutter/lib
const moveMap = [
   { src: 'core/widgets/global_top_bar.dart', dest: 'src/components/global_top_bar.dart', exportStr: "export 'src/components/global_top_bar.dart';" },
   { src: 'core/widgets/language_toggle_button.dart', dest: 'src/components/language_toggle_button.dart', exportStr: "export 'src/components/language_toggle_button.dart';" },
   { src: 'core/widgets/universal_role_sidebar.dart', dest: 'src/components/universal_role_sidebar.dart', exportStr: "export 'src/components/universal_role_sidebar.dart';" },
   { src: 'features/master/shared/widgets/page_template.dart', dest: 'src/components/page_template.dart', exportStr: "export 'src/components/page_template.dart';" },
   { src: 'features/roles/psw/widgets/care_plan_sheet.dart', dest: 'src/components/care_plan_sheet.dart', exportStr: "export 'src/components/care_plan_sheet.dart';" }
];

const deleteMap = [
   'core/widgets/operational/team_member_avatar_pile.dart',
   'features/roles/psw/widgets/incident_report_fab.dart',
   'features/master/shared/widgets/kpi_card.dart'
];

// Helper: Scan dart files
function findDartFiles(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir, { withFileTypes: true });
  for (const file of files) {
    const fn = path.join(dir, file.name);
    if (file.isDirectory()) {
      findDartFiles(fn, fileList);
    } else if (fn.endsWith('.dart')) {
      fileList.push(fn);
    }
  }
  return fileList;
}

const allDartFiles = findDartFiles(MOBILE_LIB);

console.log("=== PHASE 1: MOVING WIDGETS TO primecare_ui ===");

// 1. Move files
let exportsToInject = [];
for (const item of moveMap) {
   const srcPath = path.join(MOBILE_LIB, item.src);
   const destPath = path.join(UI_LIB, item.dest);
   
   if (fs.existsSync(srcPath)) {
      const content = fs.readFileSync(srcPath, 'utf8');
      fs.writeFileSync(destPath, content, 'utf8');
      fs.unlinkSync(srcPath); // delete original
      exportsToInject.push(item.exportStr);
      console.log('Moved: ' + item.src + ' -> ' + item.dest);
   }
}

// 2. Add Export string to primecare_ui.dart
const uiIndexFile = path.join(UI_LIB, 'primecare_ui.dart');
if (fs.existsSync(uiIndexFile) && exportsToInject.length > 0) {
   let indexContent = fs.readFileSync(uiIndexFile, 'utf8');
   const exportsStr = '\n// Transferred Core Components\n' + exportsToInject.join('\n') + '\n';
   
   if (!indexContent.includes("export 'src/components/page_template.dart';")) {
      fs.writeFileSync(uiIndexFile, indexContent + exportsStr, 'utf8');
      console.log("Updated primecare_ui.dart with new exports");
   }
}

console.log("\n=== PHASE 2: DELETING REDUNDANT WIDGETS ===");
for (const relPath of deleteMap) {
   const absPath = path.join(MOBILE_LIB, relPath);
   if (fs.existsSync(absPath)) {
      fs.unlinkSync(absPath);
      console.log('Deleted loose widget: ' + relPath);
   }
}

console.log("\n=== PHASE 3: REWIRING IMPORTS ACROSS MOBILE_FLUTTER ===");
// Modify every file in mobile_flutter
let modifiedFileCount = 0;

for (const filePath of allDartFiles) {
   // Don't rewire the deleted loose widgets
   if (!fs.existsSync(filePath)) continue;

   let content = fs.readFileSync(filePath, 'utf8');
   let changed = false;

   // Purge the old relative and absolute imports, replace with primecare_ui
   const looseImports = [
      /import\s+['"]package:primecare_mobile\/core\/widgets\/global_top_bar\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/core\/widgets\/language_toggle_button\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/core\/widgets\/universal_role_sidebar\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/features\/master\/shared\/widgets\/page_template\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/features\/roles\/psw\/widgets\/care_plan_sheet\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/core\/widgets\/operational\/team_member_avatar_pile\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/features\/roles\/psw\/widgets\/incident_report_fab\.dart['"];?/g,
      /import\s+['"]package:primecare_mobile\/features\/master\/shared\/widgets\/kpi_card\.dart['"];?/g,
      
      // Relative variations:
      /import\s+['"][^'"]+widgets\/global_top_bar\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/language_toggle_button\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/universal_role_sidebar\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/page_template\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/care_plan_sheet\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/team_member_avatar_pile\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/incident_report_fab\.dart['"];?/g,
      /import\s+['"][^'"]+widgets\/kpi_card\.dart['"];?/g
   ];

   let needsPrimecareUIImport = false;
   looseImports.forEach(regex => {
       if (regex.test(content)) {
          content = content.replace(regex, '');
          needsPrimecareUIImport = true;
          changed = true;
       }
   });

   // Handle the UnifiedKpiCard replacement
   if (content.includes('UnifiedKpiCard')) {
      content = content.replace(/UnifiedKpiCard/g, 'PrimeCareKpiCard');
      needsPrimecareUIImport = true;
      changed = true;
   }

   // Inject the primecare_ui import at the top securely
   if (needsPrimecareUIImport && !content.includes('package:primecare_ui/primecare_ui.dart')) {
       // Insert it dynamically below the first flutter/material.dart or export
       const targetPoint = /(import\s+['"]package:flutter\/(?:material|foundation|cupertino)\.dart['"];?)/;
       if (targetPoint.test(content)) {
            content = content.replace(targetPoint, "$1\nimport 'package:primecare_ui/primecare_ui.dart';");
       } else {
            content = "import 'package:primecare_ui/primecare_ui.dart';\n" + content;
       }
       changed = true;
   }

   if (changed) {
       fs.writeFileSync(filePath, content, 'utf8');
       modifiedFileCount++;
   }
}

console.log('Successfully rewrote ' + modifiedFileCount + ' architectural files pointing them to primecare_ui!');
