const fs = require('fs');
const path = require('path');

function processFile(filePath) {
   let content = fs.readFileSync(filePath, 'utf8');
   let modified = false;
   let searchFrom = 0;
   
   while(true) {
      let idx = content.indexOf('appBar:', searchFrom);
      // Ensure we don't accidentally match 'appBar: null' or something, though we'll just check for '('
      if (idx === -1) break;

      let openParenIdx = content.indexOf('(', idx);
      // Give it a reasonable distance, e.g. 'appBar: PrimeCareNavBar('
      if (openParenIdx === -1 || (openParenIdx - idx) > 40) { 
          searchFrom = idx + 7; 
          continue; 
      }

      let openCount = 0;
      let closeIdx = -1;
      for (let i = openParenIdx; i < content.length; i++) {
         if (content[i] === '(') openCount++;
         if (content[i] === ')') {
            openCount--;
            if (openCount === 0) {
               closeIdx = i;
               break;
            }
         }
      }

      if (closeIdx !== -1) {
         let endCut = closeIdx + 1;
         while(endCut < content.length && (content[endCut] === ' ' || content[endCut] === '\r' || content[endCut] === '\n')) endCut++;
         if (content[endCut] === ',') endCut++;

         content = content.substring(0, idx) + content.substring(endCut);
         modified = true;
      } else {
         searchFrom = idx + 7;
      }
   }
   
   if (modified) {
      fs.writeFileSync(filePath, content, 'utf8');
      console.log('Stripped appBars from ' + path.basename(filePath));
   }
}

function walkDir(dir) {
  fs.readdirSync(dir).forEach(f => {
    let dirPath = path.join(dir, f);
    if (fs.statSync(dirPath).isDirectory()) {
       walkDir(dirPath);
    } else if (f.endsWith('.dart') && f !== 'main.dart') {
       processFile(dirPath);
    }
  });
}

walkDir(path.join(__dirname, '../lib'));
