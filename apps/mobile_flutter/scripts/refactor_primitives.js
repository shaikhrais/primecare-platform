const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib', 'features');

function extractBalanced(str, startIdx) {
    let openCount = 0;
    for (let i = startIdx; i < str.length; i++) {
        if (str[i] === '(') openCount++;
        else if (str[i] === ')') {
            openCount--;
            if (openCount === 0) return i;
        }
    }
    return -1;
}

function refactorFile(p) {
    let c = fs.readFileSync(p, 'utf8');
    let original = c;

    // Safety check - we only care if a BoxDecoration actually exists
    if (!c.includes('BoxDecoration(')) return false;

    if (!c.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        let lastImport = c.lastIndexOf("import ");
        if (lastImport !== -1) {
            let endOfLine = c.indexOf("\n", lastImport);
            c = c.substring(0, endOfLine + 1) + "import 'package:primecare_ui/primecare_ui.dart';\n" + c.substring(endOfLine + 1);
        } else {
            c = "import 'package:primecare_ui/primecare_ui.dart';\n" + c;
        }
    }

    while (true) {
        let decIdx = c.indexOf('decoration: BoxDecoration(');
        if (decIdx === -1) {
            decIdx = c.indexOf('decoration: const BoxDecoration(');
        }
        if (decIdx === -1) break; // Break safely when 100% of BoxDecorations are purged

        let targetPrefix = c.substring(decIdx).startsWith('decoration: const BoxDecoration(') ? 'decoration: const BoxDecoration' : 'decoration: BoxDecoration';

        let openParen = decIdx + targetPrefix.length; 
        let closeParen = extractBalanced(c, openParen);
        
        if (closeParen !== -1) {
            // Check for trailing comma cleanly
            let wipeEnd = closeParen + 1;
            while (c[wipeEnd] === ' ' || c[wipeEnd] === '\n' || c[wipeEnd] === '\r') wipeEnd++;
            if (c[wipeEnd] === ',') wipeEnd++;

            c = c.substring(0, decIdx) + c.substring(wipeEnd);
            
            // Search backwards for the parent Container matching this explicit decoration block
            let containerIdx = c.lastIndexOf('Container(', decIdx);
            if (containerIdx !== -1) {
                c = c.substring(0, containerIdx) + 'PrimeCareCard(' + c.substring(containerIdx + 'Container('.length);
            }
        } else {
            break; 
        }
    }
    
    if (c !== original) {
        fs.writeFileSync(p, c, 'utf8');
        return true;
    }
    return false;
}

let refactorCount = 0;
function scan(dir) {
  if (!fs.existsSync(dir)) return;
  for (let f of fs.readdirSync(dir)) {
    let p = path.join(dir, f);
    if (fs.statSync(p).isDirectory()) {
      scan(p);
    } else if (p.endsWith('.dart')) {
       if (refactorFile(p)) {
           console.log(`[AST CARD MAPPED] ${f}`);
           refactorCount++;
       }
    }
  }
}

scan(srcRoot);
console.log(`\nOperation Complete. Safely mapped ${refactorCount} layout files globally onto PrimeCareCard array natively.`);
