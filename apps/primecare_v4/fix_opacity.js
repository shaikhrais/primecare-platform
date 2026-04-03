const fs = require('fs');
const path = require('path');

function processDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            processDir(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            const changed = content.replace(/\.withOpacity\(([^)]+)\)/g, '.withValues(alpha: $1)');
            if (content !== changed) {
                fs.writeFileSync(fullPath, changed, 'utf8');
                console.log('Updated ' + fullPath);
            }
        }
    }
}

processDir('./lib');
