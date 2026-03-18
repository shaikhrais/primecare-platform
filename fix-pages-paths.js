const fs = require('fs');
const path = require('path');

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors-flatten-final.json', 'utf8'));

const filePathsToFix = new Set();
errors.forEach(err => {
    const match = err.match(/^(.+?)\(\d+,\d+\):/);
    if (match) filePathsToFix.add('apps/web-admin/' + match[1]);
});

filePathsToFix.forEach(fullPath => {
    if (!fs.existsSync(fullPath)) return;
    
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Replace '/pages/' -> '/' in generic imports
    content = content.replace(/['"]([^'"]*)\/pages\/([^'"]+)['"]/g, "'$1/$2'");
    
    // Deal with './pages/' specifically
    content = content.replace(/['"]\.\/pages\/([^'"]+)['"]/g, "'./$1'");
    
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Patched paths in ${fullPath}`);
});
