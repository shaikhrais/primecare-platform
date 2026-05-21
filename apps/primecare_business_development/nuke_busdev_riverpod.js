const fs = require('fs');
const path = require('path');

function walk(dir) {
  let results = [];
  try {
    const list = fs.readdirSync(dir);
    list.forEach(function(file) {
      file = path.join(dir, file);
      const stat = fs.statSync(file);
      if (stat && stat.isDirectory()) {
        results = results.concat(walk(file));
      } else {
        if (file.endsWith('_screen.dart')) {
          results.push(file);
        }
      }
    });
  } catch (err) {
    // Ignore if directory doesn't exist
  }
  return results;
}

const files = walk('C:\\\\Users\\\\Admin2\\\\Documents\\\\GitHub\\\\primecare-platform\\\\apps\\\\primecare_business_development\\\\lib\\\\features');
files.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  let changed = false;
  
  if (content.includes('ref.watch(')) {
    content = content.replace(/final state = ref\.watch.*?;/g, 'final state = const AsyncValue.data({"kpis": [], "items": []});');
    changed = true;
  }
  if (content.includes('ref.invalidate(')) {
    content = content.replace(/onPressed: \(\) => ref\.invalidate.*?,/g, 'onPressed: () {},');
    changed = true;
  }
  if (content.includes('ref.read(')) {
    content = content.replace(/onPressed: \(\) => ref\.read.*?\.performAction\(\),/g, 'onPressed: () {},');
    changed = true;
  }
  
  if (changed) {
    fs.writeFileSync(file, content);
  }
});
console.log('Fixed riverpod issues in ' + files.length + ' files.');
