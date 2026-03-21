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

function stripStyleBlock(c, styleKey) {
    while (true) {
        let decIdx = c.indexOf(styleKey);
        if (decIdx === -1) break;

        let openParen = decIdx + styleKey.length - 1; 
        if (c[openParen] !== '(') break; // formatting error bail

        let closeParen = extractBalanced(c, openParen);
        
        if (closeParen !== -1) {
            let wipeEnd = closeParen + 1;
            while (c[wipeEnd] === ' ' || c[wipeEnd] === '\n' || c[wipeEnd] === '\r') wipeEnd++;
            if (c[wipeEnd] === ',') wipeEnd++;

            c = c.substring(0, decIdx) + c.substring(wipeEnd);
        } else {
            break; 
        }
    }
    return c;
}

function refactorFile(p) {
    let c = fs.readFileSync(p, 'utf8');
    let original = c;

    // First strip nested style constructors
    c = stripStyleBlock(c, 'style: ElevatedButton.styleFrom(');
    c = stripStyleBlock(c, 'style: OutlinedButton.styleFrom(');
    c = stripStyleBlock(c, 'style: TextButton.styleFrom(');

    // Swap the main primitives safely
    c = c.replace(/ElevatedButton\(/g, 'PrimeCareButton(type: PrimeCareButtonType.primary, ');
    c = c.replace(/OutlinedButton\(/g, 'PrimeCareButton(type: PrimeCareButtonType.secondary, ');
    c = c.replace(/TextButton\(/g, 'PrimeCareButton(type: PrimeCareButtonType.text, ');

    if (c !== original) {
        if (!c.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
            let lastImport = c.lastIndexOf("import ");
            if (lastImport !== -1) {
                let endOfLine = c.indexOf("\n", lastImport);
                c = c.substring(0, endOfLine + 1) + "import 'package:primecare_ui/primecare_ui.dart';\n" + c.substring(endOfLine + 1);
            } else {
                c = "import 'package:primecare_ui/primecare_ui.dart';\n" + c;
            }
        }
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
           console.log(`[AST BUTTON MAPPED] ${f}`);
           refactorCount++;
       }
    }
  }
}

scan(srcRoot);
console.log(`\nOperation Complete. Safely mapped ${refactorCount} button layouts globally onto PrimeCareButton natively.`);
