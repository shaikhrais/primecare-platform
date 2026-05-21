const fs = require('fs');
const path = require('path');

const APPS_DIR = path.join(__dirname, '..', 'apps');

function getDartFiles(srcPath) {
    if (!fs.existsSync(srcPath)) return [];
    let results = [];
    const list = fs.readdirSync(srcPath);
    list.forEach(file => {
        const fullPath = path.join(srcPath, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) { 
            results = results.concat(getDartFiles(fullPath));
        } else {
            if(file.endsWith('.dart') && (file.includes('screen') || file.includes('view') || file.includes('page')) && !file.includes('_controller')) {
                results.push(fullPath);
            }
        }
    });
    return results;
}

const apps = fs.readdirSync(APPS_DIR).filter(file => fs.statSync(path.join(APPS_DIR, file)).isDirectory());

let totalTested = 0;
let passed = 0;
let failed = 0;

console.log('--- STARTING FRONTEND SPIDER TEST ---');
apps.forEach(app => {
  const libPath = path.join(APPS_DIR, app, 'lib');
  const screenFiles = getDartFiles(libPath);
  
  screenFiles.forEach(file => {
      totalTested++;
      const content = fs.readFileSync(file, 'utf8');
      
      // Simulate checking if the widget compiles and has state logic attached
      const hasBuild = content.includes('Widget build(');
      const hasConsumer = content.includes('ConsumerWidget');
      const hasScaffold = content.includes('Scaffold(');
      
      if (hasBuild && hasConsumer && hasScaffold) {
          passed++;
      } else {
          failed++;
          console.error(`[FAIL] ${path.basename(file)} is structurally invalid.`);
      }
  });
});

console.log('--- FRONTEND SPIDER TEST COMPLETE ---');
console.log(`Total Screens Checked: ${totalTested}`);
console.log(`✅ Passed: ${passed}`);
console.log(`❌ Failed: ${failed}`);
