const fs = require('fs');
const path = require('path');

const rolesDir = path.join(__dirname, 'lib/features/roles');

function findDartFiles(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findDartFiles(filePath, fileList);
    } else if (file.endsWith('_dashboard_screen.dart') || file.endsWith('_home_screen.dart')) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

const allDashboards = findDartFiles(rolesDir);
let patchedCount = 0;

for (const filePath of allDashboards) {
  let content = fs.readFileSync(filePath, 'utf8');
  let originalContent = content;

  if (!content.includes('package:primecare_ui/primecare_ui.dart')) {
    content = content.replace(/(import 'package:flutter\/material\.dart';)/, "$1\nimport 'package:primecare_ui/primecare_ui.dart';");
  }

  let modified = false;

  if (content.match(/Row\s*\([\s\S]*?children:\s*(const\s*)?\[[\s\S]*?Expanded\s*\([\s\S]*?child:/)) {
      content = content.replace(/Expanded\s*\(\s*(flex:\s*\d+,\s*)?child:\s*/g, "SizedBox(child: "); 
      content = content.replace(/Row\s*\(\s*(crossAxisAlignment:[^,]*,)?\s*children:/g, "PrimeCareResponsiveKpiGrid(\n children:");
      modified = true;
  }

  if (modified && content !== originalContent) {
    fs.writeFileSync(filePath, content, 'utf8');
    patchedCount++;
    console.log(`Patched: ${path.basename(filePath)}`);
  }
}

console.log(`\nSuccessfully patched ${patchedCount} dashboard files.`);
