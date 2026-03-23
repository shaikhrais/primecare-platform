const fs = require('fs');
const path = require('path');

function walkDir(dir, callback) {
  fs.readdirSync(dir).forEach(f => {
    let dirPath = path.join(dir, f);
    let isDirectory = fs.statSync(dirPath).isDirectory();
    isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
  });
}

function stripAppBar(content) {
  let startIndex = 0;
  let modifiedContent = content;
  let changes = 0;

  while (true) {
    startIndex = modifiedContent.indexOf('appBar:');
    // Ensure we are inside a Scaffold! Actually, removing all `appBar:` is exactly what we want since the Master TopBar rules them all.
    // Wait, `GlobalTopBar` in main.dart uses `appBar:` on its PrimeCareScaffold. We MUST NOT strip main.dart!
    if (startIndex === -1) break;

    // Find the end by counting parentheses
    let openBrackets = 0;
    let foundOpen = false;
    let endIndex = startIndex;

    for (let i = startIndex; i < modifiedContent.length; i++) {
      if (modifiedContent[i] === '(') {
        openBrackets++;
        foundOpen = true;
      } else if (modifiedContent[i] === ')') {
        openBrackets--;
      }
      
      if (foundOpen && openBrackets === 0) {
         endIndex = i;
         
         // look for the trailing comma
         let lookahead = i + 1;
         while (lookahead < modifiedContent.length && (modifiedContent[lookahead] === ' ' || modifiedContent[lookahead] === '\n' || modifiedContent[lookahead] === '\r')) {
            lookahead++;
         }
         if (modifiedContent[lookahead] === ',') endIndex = lookahead;
         
         break;
      }
    }

    if (foundOpen) {
       let prefix = modifiedContent.substring(0, startIndex);
       let suffix = modifiedContent.substring(endIndex + 1);
       modifiedContent = prefix + suffix;
       changes++;
    } else {
       break; // Malformed or simple appBar: null
    }
  }
  return { modifiedContent, changes };
}

const libPath = path.join(__dirname, '../lib');

walkDir(libPath, function(filePath) {
  if (filePath.endsWith('.dart') && !filePath.includes('main.dart')) {
     const original = fs.readFileSync(filePath, 'utf8');
     const { modifiedContent, changes } = stripAppBar(original);
     if (changes > 0) {
        fs.writeFileSync(filePath, modifiedContent, 'utf8');
        console.log(`Stripped ${changes} AppBars from ${filePath}`);
     }
  }
});
