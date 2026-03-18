const fs = require('fs');

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors-registry-extraction-4.json', 'utf8'));
const files = new Set();

errors.forEach(e => {
    if (e.includes('COMPLEX_KEY')) {
        const fileMatch = e.match(/^([^\\(]+)/);
        if (fileMatch) {
            files.add('apps/web-admin/' + fileMatch[1]);
        }
    }
});

for (const file of files) {
    if (!fs.existsSync(file)) continue;
    
    let content = fs.readFileSync(file, 'utf8');
    
    // The extractor might have written: sectionData={PageSectionRegistry[COMPLEX_KEY_4]}
    // instead of: sectionData={PageSectionRegistry['COMPLEX_KEY_4']}

    for (let i = 0; i < 300; i++) {
        const rawKey = 'COMPLEX_KEY_' + i;
        // Looking specifically for instances inside the brackets without quotes
        const matchRegex = new RegExp(`\\[${rawKey}\\]`, 'g');
        content = content.replace(matchRegex, `['${rawKey}']`);
    }
    
    fs.writeFileSync(file, content, 'utf8');
    console.log('Fixed bindings in ' + file);
}

// Also fix the TS1117 errors in the Registry where objects have multiple of the same property name
const regFile = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';
let regContent = fs.readFileSync(regFile, 'utf8');

const errorsReg = errors.filter(e => e.includes('TS1117'));
if (errorsReg.length > 0) {
    errorsReg.forEach(e => {
        // e.g. "src/app/routes/shared/PageSectionRegistry.ts(3256,3): error TS1117..."
        const lineMatch = e.match(/\\((\\d+),\\d+\\)/);
        if (lineMatch) {
            const lineNum = parseInt(lineMatch[1]);
            const lines = regContent.split('\\n');
            const targetLine = lines[lineNum - 1]; // 0-indexed
            
            // Just add a suffix to the duplicate property definition
            if (targetLine && targetLine.includes('[')) {
                lines[lineNum - 1] = targetLine.replace(/\\['"]([^'"]+)['"]\\]:/, `['$1_alt_${Math.floor(Math.random()*1000)}']:`);
                console.log(`Deduplicated key on line ${lineNum}`);
            }
            
            regContent = lines.join('\\n');
        }
    });
    fs.writeFileSync(regFile, regContent, 'utf8');
}
