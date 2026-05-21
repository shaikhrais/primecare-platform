const fs = require('fs');
const path = require('path');

const dashboards = JSON.parse(fs.readFileSync('c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\scratch\\active_dashboards.json', 'utf8'));

const allPaths = [];
for (const app in dashboards) {
  allPaths.push(...dashboards[app]);
}

allPaths.forEach(filePath => {
  if (!fs.existsSync(filePath)) return;
  const content = fs.readFileSync(filePath, 'utf8');
  
  // Find what is returned in the build method
  const buildIndex = content.indexOf('Widget build(BuildContext context');
  if (buildIndex === -1) {
    console.log(`${path.basename(filePath)}: No build method found`);
    return;
  }
  
  const returnIndex = content.indexOf('return ', buildIndex);
  if (returnIndex === -1) {
    console.log(`${path.basename(filePath)}: No return in build`);
    return;
  }
  
  const lineEnd = content.indexOf('\n', returnIndex);
  const returnLine = content.substring(returnIndex, lineEnd).trim();
  console.log(`${path.basename(filePath)}: ${returnLine}`);
});
