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

            // Structural Regex matches capturing precise component instantiations natively.
            // Using \b ensures we do not mutate partial strings like "RichText" -> "RichPrimeCareText".
            modified = modified.replace(/\bText\(/g, 'PrimeCareText(');
            modified = modified.replace(/\bIcon\(/g, 'PrimeCareIcon(');
            modified = modified.replace(/\bSizedBox\(/g, 'PrimeCareSizedBox(');
            modified = modified.replace(/\bSizedBox\.shrink\(/g, 'PrimeCareSizedBox.shrink(');
            modified = modified.replace(/\bSizedBox\.square\(/g, 'PrimeCareSizedBox.square(');
            modified = modified.replace(/\bExpanded\(/g, 'PrimeCareExpanded(');
            modified = modified.replace(/\bCenter\(/g, 'PrimeCareCenter(');
            modified = modified.replace(/\bPadding\(/g, 'PrimeCarePadding(');
            modified = modified.replace(/\bContainer\(/g, 'PrimeCareContainer(');
            modified = modified.replace(/\bStack\(/g, 'PrimeCareStack(');
            modified = modified.replace(/\bListView\(/g, 'PrimeCareListView(');
            modified = modified.replace(/\bSingleChildScrollView\(/g, 'PrimeCareScrollWrapper(');
            modified = modified.replace(/\bSafeArea\(/g, 'PrimeCareSafeArea(');
            
            // Secondary Primitive Routing:
            modified = modified.replace(/\bCircularProgressIndicator\(/g, 'PrimeCareLoader(');
            modified = modified.replace(/\bIconButton\(/g, 'PrimeCareIconButton(');
            modified = modified.replace(/\bTextField\(/g, 'PrimeCareTextField(');
            modified = modified.replace(/\bGestureDetector\(/g, 'PrimeCareGesture(');
            modified = modified.replace(/\bInkWell\(/g, 'PrimeCareInkWell(');
            modified = modified.replace(/\bCircleAvatar\(/g, 'PrimeCareAvatar(');
            
            // Phase 82 built PrimeCareAppBar, Phase 86 overrides raw local ones preserving native UI signatures:
            modified = modified.replace(/\bAppBar\(/g, 'PrimeCareNavBar(');

            if (original !== modified) {
                // Ensure import exists explicitly for the framework seal
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

console.log('Deploying Absolute Primitive Annihilation Array (Phase 87)...');
refactor(srcRoot);
console.log(`Annihilation Complete. ${filesModified} application layers strictly conform to the SDK bound.`);
