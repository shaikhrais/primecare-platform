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
        const fullPath = path.join(srcPath, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) { 
            results = results.concat(getDartFiles(fullPath));
        } else {
            if(file.endsWith('.dart') && 
              (file.includes('screen') || file.includes('view') || file.includes('page')) && 
              !file.includes('_controller')) {
                results.push(fullPath);
            }
        }
    });
    return results;
}

const apps = getDirectories(APPS_DIR);

let totalScreens = 0;
let emptyStubs = 0;
let missingDependencies = 0;
let fullyImplemented = 0;

apps.forEach(app => {
  const libPath = path.join(APPS_DIR, app, 'lib');
  const screenFiles = getDartFiles(libPath);
  
  screenFiles.forEach(file => {
      totalScreens++;
      const content = fs.readFileSync(file, 'utf8');
      
      // Determine if it is a stub
      if (content.length < 200 || content.includes('TODO') || content.includes('UnimplementedError') || !content.includes('Widget build(')) {
          emptyStubs++;
      } else {
          fullyImplemented++;
      }
  });
});

console.log(`Total Screens: ${totalScreens}`);
console.log(`Fully Implemented: ${fullyImplemented}`);
console.log(`Empty/Stubs/Missing Logic: ${emptyStubs}`);
