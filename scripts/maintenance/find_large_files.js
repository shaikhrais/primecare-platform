const fs = require('fs');
const path = require('path');

function findLargeFiles(dir) {
    const files = fs.readdirSync(dir);
    files.forEach(file => {
        const filePath = path.join(dir, file);
        const stat = fs.statSync(filePath);
        if (stat.isDirectory()) {
            findLargeFiles(filePath);
        } else if (filePath.endsWith('.tsx')) {
            const content = fs.readFileSync(filePath, 'utf-8');
            const lines = content.split('\n').length;
            if (lines > 200) {
                fs.appendFileSync('large_files_list.txt', `${filePath}: ${lines}\n`);
            }
        }
    });
}

if (fs.existsSync('large_files_list.txt')) {
    fs.unlinkSync('large_files_list.txt');
}
findLargeFiles('C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps\\web-admin\\src');
