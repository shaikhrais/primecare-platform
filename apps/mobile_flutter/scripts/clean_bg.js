const fs = require('fs');
const path = require('path');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
    });
}

walkDir('./lib', function(filePath) {
    if (filePath.endsWith('.dart')) {
        let content = fs.readFileSync(filePath, 'utf-8');
        if (content.includes('backgroundColor: Color(0xFFF8FAFC),')) {
            // Safely remove the hardcoded background property to allow Theme inheritance
            content = content.replace(/[ \t]*backgroundColor:\s*Color\(0xFFF8FAFC\),\r?\n/g, '');
            fs.writeFileSync(filePath, content, 'utf-8');
            console.log('Cleaned static background in: ' + filePath);
        }
    }
});
