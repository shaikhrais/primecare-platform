
const fs = require('fs');
const path = require('path');

function getFiles(dir) {
    let results = [];
    const list = fs.readdirSync(dir);
    list.forEach(file => {
        const fullPath = path.join(dir, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) {
            results = results.concat(getFiles(fullPath));
        } else {
            if (fullPath.endsWith('.ts') || fullPath.endsWith('.tsx')) {
                results.push(fullPath);
            }
        }
    });
    return results;
}

const srcDir = path.join(process.cwd(), 'src');
const files = getFiles(srcDir);

files.forEach(file => {
    const content = fs.readFileSync(file, 'utf8');
    const lines = content.split('\n').length;
    if (lines > 200) {
        console.log(`${file} : ${lines}`);
    }
});
