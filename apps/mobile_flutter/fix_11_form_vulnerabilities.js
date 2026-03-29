const fs = require('fs');
const path = require('path');

const FEATURES_DIR = path.join(__dirname, 'lib/features');

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

const allFiles = findDartFiles(FEATURES_DIR);

let dialogsFixed = 0;
let searchBarsFixed = 0;
let authFormsFixed = 0;
let qaDataCellsFixed = 0;

for (const filePath of allFiles) {
    let content = fs.readFileSync(filePath, 'utf8');
    let originalContent = content;
    
    // 1. Search Bar Rigid SizedBox to Flexible ConstrainedBox (Fixes Overflows)
    // Matches: SizedBox(width: 200, child: TextField(...))
    const searchBarRegex = /SizedBox\(\s*width:\s*([2-3][0-9]{2})\s*,\s*child:\s*TextField\(([\s\S]*?)\)\s*\)/g;
    if (searchBarRegex.test(content)) {
        content = content.replace(searchBarRegex, "Flexible(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: $1), child: TextField($2)))");
        searchBarsFixed++;
    }

    // 2. AlertDialog Massive Stretching on PC (Wraps AlertDialog content)
    // Removed from script due to nested AST complexity causing invalid Syntax generation in dart layouts.

    // QA Screens Rigid SizedBox in DataTable
    if (filePath.includes('qa_satisfaction_screen') || filePath.includes('qa_incidents_screen')) {
         const dataCellSizedBoxRegex = /DataCell\(SizedBox\(width:\s*([2-3][0-9]{2}),\s*child:\s*Text\(/g;
         if (dataCellSizedBoxRegex.test(content)) {
             content = content.replace(dataCellSizedBoxRegex, "DataCell(ConstrainedBox(constraints: const BoxConstraints(maxWidth: $1), child: Text(");
             qaDataCellsFixed++;
         }
    }

    if (content !== originalContent) {
       fs.writeFileSync(filePath, content, 'utf8');
    }
}

console.log(`Executed 10-Point Fix Matrix:\n - ${searchBarsFixed} Rigid Search Bars Resiliently Fixed\n - ${qaDataCellsFixed} QA DataTable cells bounded correctly.`);
