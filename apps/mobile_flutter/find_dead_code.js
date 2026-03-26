const fs = require('fs');
const path = require('path');

const libDir = path.join(__dirname, 'lib');

function getAllFiles(dir, exts, fileList = []) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      getAllFiles(filePath, exts, fileList);
    } else if (exts.includes(path.extname(filePath))) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

const dartFiles = getAllFiles(libDir, ['.dart']);
const allContent = dartFiles.map(f => fs.readFileSync(f, 'utf8')).join('\n');

const orphaned = [];
for (const file of dartFiles) {
  // Skip main.dart and routing files since they are entry points
  if (file.endsWith('main.dart') || file.endsWith('router.dart')) continue;

  const basename = path.basename(file);
  const regex = new RegExp(`['"]([^'"]*${basename})['"]`, 'g');
  if (!regex.test(allContent)) {
    orphaned.push(file.replace(libDir, ''));
  }
}

console.log("ZERO USE (ORPHANED) FILES:");
orphaned.forEach(f => console.log(f));
