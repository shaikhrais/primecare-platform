const fs = require('fs');
const path = require('path');

const APPS_DIR = path.join(__dirname, '..', 'apps');

function getDirectories(srcPath) {
  if (!fs.existsSync(srcPath)) return [];
  return fs.readdirSync(srcPath).filter(file => fs.statSync(path.join(srcPath, file)).isDirectory());
}

function getDartFiles(srcPath) {
    if (!fs.existsSync(srcPath)) return [];
    let results = [];
    const list = fs.readdirSync(srcPath);
    list.forEach(file => {
        file = path.join(srcPath, file);
        const stat = fs.statSync(file);
        if (stat && stat.isDirectory()) { 
            results = results.concat(getDartFiles(file));
        } else {
            if(file.endsWith('.dart') && (file.includes('screen') || file.includes('view') || file.includes('page'))) {
                results.push(path.basename(file, '.dart'));
            }
        }
    });
    return results;
}

const apps = getDirectories(APPS_DIR);

console.log('Detailed Role-Wise Information:\\n');

apps.forEach(app => {
  const appPath = path.join(APPS_DIR, app);
  const libPath = path.join(appPath, 'lib');
  
  // Just get all dart files containing 'screen', 'view', or 'page' in the name
  const screenFiles = getDartFiles(libPath);
  
  // Take a sample of up to 5 interesting screens
  const uniqueScreens = [...new Set(screenFiles)];
  const sample = uniqueScreens.slice(0, 7).join(', ');
  
  console.log(`**Role**: ${app.replace('primecare_', '').toUpperCase()}`);
  console.log(`- Total UI Screens Found: ${screenFiles.length}`);
  if (sample.length > 0) {
      console.log(`- Key Features/Screens: ${sample}...`);
  } else {
      console.log(`- Key Features/Screens: (Core app setup, minimal UI)`);
  }
  console.log('---');
});
