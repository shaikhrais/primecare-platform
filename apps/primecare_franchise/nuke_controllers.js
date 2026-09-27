// Governance - Category: controller | Purpose: Controller layer orchestrating business logic and state management for the corresponding module.
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
      if (file.endsWith('_controller.dart')) {
        results.push(file);
      }
    }
  });
  return results;
}

const files = walk('C:\\\\Users\\\\Admin2\\\\Documents\\\\GitHub\\\\primecare-platform\\\\apps\\\\primecare_franchise\\\\lib\\\\features\\\\franchise\\\\presentation\\\\widgets');
files.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  content = content.replace(/part '.*?\.g\.dart';/g, '');
  content = content.replace(/@riverpod/g, '');
  content = content.replace(/extends _\$[a-zA-Z0-9_]+/g, '');
  content = content.replace(/@override/g, ''); // Removes override annotations since we aren't inheriting from the Riverpod base class anymore
  fs.writeFileSync(file, content);
});
