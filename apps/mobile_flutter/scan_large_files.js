const fs = require('fs');
const path = require('path');

const libDir = path.join(__dirname, 'lib');
const fileStats = [];

function scanDir(dir) {
  const items = fs.readdirSync(dir);
  for (let item of items) {
    if (item.includes('l10n') || item.includes('.g.dart') || item.includes('.freezed.dart')) continue;
    
    const fullPath = path.join(dir, item);
    const stat = fs.statSync(fullPath);
    if (stat.isDirectory()) {
      scanDir(fullPath);
    } else if (fullPath.endsWith('.dart')) {
      const content = fs.readFileSync(fullPath, 'utf8');
      const lines = content.split('\n').length;
      fileStats.push({
        file: fullPath.replace(__dirname + path.sep, ''),
        sizeKB: (stat.size / 1024).toFixed(2),
        lines: lines
      });
    }
  }
}

scanDir(libDir);
fileStats.sort((a, b) => b.lines - a.lines);

let result = "=== TOP 10 LARGEST FILES RUNTIME ANALYSIS ===\n";
for (let i = 0; i < Math.min(10, fileStats.length); i++) {
  result += `${i+1}. ${fileStats[i].file} | ${fileStats[i].lines} Lines | ${fileStats[i].sizeKB} KB\n`;
}

fs.writeFileSync('result.txt', result);
console.log("Written to result.txt cleanly");
