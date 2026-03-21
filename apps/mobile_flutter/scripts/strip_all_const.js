const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');

function stripConsts(dirPath) {
    if (!fs.existsSync(dirPath)) return;
    const files = fs.readdirSync(dirPath);

    for (const file of files) {
        const fullPath = path.join(dirPath, file);
        if (fs.statSync(fullPath).isDirectory()) {
            stripConsts(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            // Safely strip ALL `const WidgetName(` instantiations recursively
            // ensuring we do not strip `const` from variable declarations like `const double x = 5;`
            const original = content;
            content = content.replace(/const\s+([A-Z][a-zA-Z0-9_\.]*\()/g, '$1');
            
            // Also strip list literals: `const [`
            content = content.replace(/const\s+\[/g, '[');

            // Also map literals: `const {`
            content = content.replace(/const\s+\{/g, '{');

            if (content !== original) {
                fs.writeFileSync(fullPath, content, 'utf8');
            }
        }
    }
}

console.log('Stripping absolute UI constants natively. This enables dynamic Riverpod localized string updates at 60fps.');
stripConsts(srcRoot);
console.log('Constants purged globally.');
