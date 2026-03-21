const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');

function patchImports(dirPath) {
    if (!fs.existsSync(dirPath)) return;
    const files = fs.readdirSync(dirPath);

    for (const file of files) {
        const fullPath = path.join(dirPath, file);
        if (fs.statSync(fullPath).isDirectory()) {
            patchImports(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            if (content.includes("import 'package:flutter_gen/gen_l10n/app_localizations.dart';")) {
                content = content.replace(
                    /import 'package:flutter_gen\/gen_l10n\/app_localizations\.dart';/g, 
                    "import 'package:primecare_mobile/l10n/app_localizations.dart';"
                );
                fs.writeFileSync(fullPath, content, 'utf8');
            }
        }
    }
}

console.log('Patching import paths globally to non-synthetic locale targets...');
patchImports(srcRoot);
console.log('Import patching complete.');
