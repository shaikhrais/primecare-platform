const fs = require('fs');
const path = require('path');

function getFiles(dir, list = []) {
  if (!fs.existsSync(dir)) return list;
  const files = fs.readdirSync(dir, { withFileTypes: true });
  for (const file of files) {
    const fn = path.join(dir, file.name);
    if (file.isDirectory()) {
      getFiles(fn, list);
    } else if (fn.includes('widgets') && fn.endsWith('.dart')) {
      list.push(fn);
    }
  }
  return list;
}

const allWidgets = getFiles('lib');
fs.writeFileSync('loose_widgets.txt', allWidgets.join('\n'), 'utf8');
console.log('Saved to loose_widgets.txt. Count: ' + allWidgets.length);
