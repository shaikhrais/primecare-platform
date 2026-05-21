const fs = require('fs');
const path = require('path');

function findFiles(dir, suffix, fileList = []) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat.isDirectory()) {
      if (file !== 'node_modules' && file !== '.git' && file !== 'build' && file !== '.dart_tool') {
        findFiles(filePath, suffix, fileList);
      }
    } else if (file.endsWith(suffix)) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

const appsDir = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps';
const dashboards = findFiles(appsDir, '_dashboard_screen.dart');
console.log(`Found ${dashboards.length} dashboard files:`);
dashboards.forEach(f => console.log(f));
