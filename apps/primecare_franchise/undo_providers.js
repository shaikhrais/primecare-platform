const fs = require('fs');
const path = require('path');

function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(function(file) {
    file = path.join(dir, file);
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) {
      results = results.concat(walk(file));
    } else {
      if (file.endsWith('.dart') && !file.endsWith('.g.dart')) {
        results.push(file);
      }
    }
  });
  return results;
}

const files = walk('C:\\\\Users\\\\Admin2\\\\Documents\\\\GitHub\\\\primecare-platform\\\\apps\\\\primecare_franchise\\\\lib');
files.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  // Match lower case first letter for Provider
  const newContent = content.replace(/\b([a-z])([a-zA-Z0-9_]*ControllerProvider)\b/g, (match, p1, p2) => {
    return p1.toUpperCase() + p2;
  });
  if (content !== newContent) {
    fs.writeFileSync(file, newContent);
  }
});
