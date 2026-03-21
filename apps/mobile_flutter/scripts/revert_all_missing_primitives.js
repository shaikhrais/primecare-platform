const fs = require('fs');
const path = require('path');

function walkDir(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(file => {
    file = path.join(dir, file);
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) {
      results = results.concat(walkDir(file));
    } else if (file.endsWith('.dart')) {
      results.push(file);
    }
  });
  return results;
}

const dartFiles = walkDir('lib');

dartFiles.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  let original = content;
  content = content.replace(/PrimeCareScrollWrapper/g, 'SingleChildScrollView');
  content = content.replace(/PrimeCareSizedBox/g, 'SizedBox');
  
  if (content !== original) {
    fs.writeFileSync(file, content);
    console.log(`Reverted primitives in ${file}`);
  }
});
