const fs = require('fs');
const path = require('path');

const libDir = path.join(__dirname, '..', 'lib');
const layoutsDir = path.join(libDir, 'features', 'shared', 'layouts');
const proxyFile = path.join(layoutsDir, 'responsive_shell.dart');

// 1. Delete the physical layout proxy file to ensure 0 loose layout components exist
if (fs.existsSync(proxyFile)) {
    fs.unlinkSync(proxyFile);
    console.log('Deleted physical ghost proxy: ' + proxyFile);
}
if (fs.existsSync(layoutsDir)) {
    try {
        fs.rmdirSync(layoutsDir);
        console.log('Annihilated layouts directory completely.');
    } catch(e) {
        console.warn('Could not remove layouts directory, might not be empty?', e);
    }
}

// 2. Strip imports from the 8 shell files recursively
function sweep(dir) {
    if(!fs.existsSync(dir)) return;
    for (const f of fs.readdirSync(dir)) {
        const p = path.join(dir, f);
        if (fs.statSync(p).isDirectory()) {
            sweep(p);
        } else if (p.endsWith('.dart') && !p.includes('generated') && !p.includes('primecare_ui')) {
            let content = fs.readFileSync(p, 'utf8');
            let original = content;

            // Remove legacy proxy imports
            content = content.replace(/import 'package:primecare_mobile\/features\/shared\/layouts\/responsive_shell\.dart';\n?/g, '');
            content = content.replace(/import '\.\.\/\.\.\/shared\/layouts\/responsive_shell\.dart';\n?/g, '');
            content = content.replace(/import '\.\.\/layouts\/responsive_shell\.dart';\n?/g, '');
            
            if (content !== original) {
                // Ensure the base SDK is injected instead if missing
                if (!content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
                    content = "import 'package:primecare_ui/primecare_ui.dart';\n" + content;
                }
                fs.writeFileSync(p, content, 'utf8');
                console.log(`Re-routed shell import directly to core SDK in ${f}`);
            }
        }
    }
}

console.log('Burning layout proxies and sweeping Shell imports natively...');
sweep(libDir);
console.log('Physical trace eradication complete.');
