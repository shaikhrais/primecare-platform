const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');

let filesModified = 0;

function revert(dir) {
    if (!fs.existsSync(dir)) return;
    for (let f of fs.readdirSync(dir)) {
        let p = path.join(dir, f);
        if (fs.statSync(p).isDirectory()) {
            revert(p);
        } else if (p.endsWith('.dart') && !p.includes('generated') && !p.includes('primecare_ui')) {
            let original = fs.readFileSync(p, 'utf8');
            let modified = original;

            // Revert secondary functional extractions that caused parameter mismatch
            modified = modified.replace(/\bPrimeCareLoader\(/g, 'CircularProgressIndicator(');
            modified = modified.replace(/\bPrimeCareIconButton\(/g, 'IconButton(');
            modified = modified.replace(/\bPrimeCareTextField\(/g, 'TextField(');
            modified = modified.replace(/\bPrimeCareGesture\(/g, 'GestureDetector(');
            modified = modified.replace(/\bPrimeCareInkWell\(/g, 'InkWell(');
            modified = modified.replace(/\bPrimeCareAvatar\(/g, 'CircleAvatar(');

            if (original !== modified) {
                fs.writeFileSync(p, modified, 'utf8');
                filesModified++;
            }
        }
    }
}

console.log('Reverting Interactive Components to preserve syntax bindings...');
revert(srcRoot);
console.log(`Reversion Complete. ${filesModified} files successfully restored to Flutter primitive endpoints.`);
