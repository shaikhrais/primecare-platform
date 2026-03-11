const fs = require('fs');
const path = require('path');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        if (f === 'node_modules' || f === '.git' || f === 'dist' || f === 'build' || f === '.next') return;
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
    });
}

const targets = [
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/worker-api/src',
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/web-admin/src',
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/packages'
];

const regex = /mock|simulat|dummy/i;

let manualFixesRequired = [];
let filesModified = 0;

targets.forEach(dir => {
    walkDir(dir, (filePath) => {
        if (!filePath.endsWith('.ts') && !filePath.endsWith('.tsx') && !filePath.endsWith('.js') && !filePath.endsWith('.md')) return;
        
        const content = fs.readFileSync(filePath, 'utf8');
        if (!regex.test(content)) return;
        
        let lines = content.split(/\r?\n/);
        let modified = false;
        
        for (let i = 0; i < lines.length; i++) {
            let line = lines[i];
            if (regex.test(line)) {
                const isComment = /^\s*(\/\/|\/?\*\*?|\*\s*|<!--|#)/.test(line);
                if (!isComment && !filePath.endsWith('.md')) {
                    manualFixesRequired.push(`${filePath}:${i + 1}: ${line.trim()}`);
                }
            }
        }
    });
});

fs.writeFileSync('c:/Users/Admin2/Documents/GitHub/primecare-platform/manual_fixes_utf8.txt', manualFixesRequired.join('\n'), 'utf8');
