const fs = require('fs');
const path = require('path');

const targetDir = 'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/mobile_flutter/lib';

function walk(dir, callback) {
  fs.readdirSync(dir).forEach(file => {
    const p = path.join(dir, file);
    if (fs.statSync(p).isDirectory()) {
      walk(p, callback);
    } else if (p.endsWith('.dart')) {
      callback(p);
    }
  });
}

let modifiedFiles = 0;

walk(targetDir, (filePath) => {
  let content = fs.readFileSync(filePath, 'utf8');
  let originalContent = content;

  // Replace Pravatar with Dicebear Avataaars (CanvasKit CORS natively compliant)
  // Example: https://i.pravatar.cc/150?img=11 -> https://api.dicebear.com/7.x/avataaars/png?seed=11
  content = content.replace(/https:\/\/i\.pravatar\.cc\/\d+\?img=(\d+)/g, 'https://api.dicebear.com/7.x/avataaars/png?seed=$1');

  // Replace generic Pravatar without specific img query
  content = content.replace(/https:\/\/i\.pravatar\.cc\/\d+/g, 'https://api.dicebear.com/7.x/avataaars/png?seed=random');

  // Replace failing Google Maps placeholder
  content = content.replace(
    /https:\/\/maps\.googleapis\.com\/maps\/api\/staticmap\?[^']+/g, 
    'https://dummyimage.com/600x300/0f172a/38bdf8.png&text=Map+Location+Placeholder'
  );

  if (content !== originalContent) {
    fs.writeFileSync(filePath, content, 'utf8');
    modifiedFiles++;
    console.log(`Updated placeholders gracefully natively structurally: ${filePath}`);
  }
});

console.log(`Successfully completed CORS substitution pass locally. Found and neutralized API restrictions implicitly safely fully natively across ${modifiedFiles} Dart files.`);
