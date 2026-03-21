const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');

let filesModified = 0;

function refactor(dir) {
    if (!fs.existsSync(dir)) return;
    for (let f of fs.readdirSync(dir)) {
        let p = path.join(dir, f);
        if (fs.statSync(p).isDirectory()) {
            refactor(p);
        } else if (p.endsWith('.dart') && !p.includes('generated') && !p.includes('primecare_ui')) {
            let original = fs.readFileSync(p, 'utf8');
            let modified = original;

            // Structural Regex matches
            modified = modified.replace(/\bScaffold\(/g, 'PrimeCareScaffold(');
            modified = modified.replace(/\bColumn\(/g, 'PrimeCareColumn(');
            modified = modified.replace(/\bRow\(/g, 'PrimeCareRow(');

            if (original !== modified) {
                // Ensure import exists
                if (!modified.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
                    modified = modified.replace(
                        /import 'package:flutter\/material\.dart';/, 
                        "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';"
                    );
                }
                
                fs.writeFileSync(p, modified, 'utf8');
                filesModified++;
            }
        }
    }
}

console.log('Deploying Universal Layout Extraction Regex (Phase 86)...');
refactor(srcRoot);
console.log(`Extraction Complete. ${filesModified} core Application modules overwritten entirely.`);
