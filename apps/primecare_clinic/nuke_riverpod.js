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
      if (file.endsWith('_screen.dart')) {
        results.push(file);
      }
    }
  });
  return results;
}

const files = walk('C:\\\\Users\\\\Admin2\\\\Documents\\\\GitHub\\\\primecare-platform\\\\apps\\\\primecare_clinic\\\\lib\\\\features\\\\generated_screens');
files.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  content = content.replace(/final state = ref\.watch.*?;/g, 'final state = const AsyncValue.data({"kpis": [], "items": []});');
  content = content.replace(/onPressed: \(\) => ref\.invalidate.*?,/g, 'onPressed: () {},');
  content = content.replace(/onPressed: \(\) => ref\.read.*?\.performAction\(\),/g, 'onPressed: () {},');
  fs.writeFileSync(file, content);
});
