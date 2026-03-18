const fs = require('fs');
const path = require('path');

function walkTargetDirs(dir) {
    let targets = [];
    if (!fs.existsSync(dir)) return [];
    const list = fs.readdirSync(dir);
    list.forEach(f => {
        const fullPath = path.join(dir, f);
        if (fs.statSync(fullPath).isDirectory()) {
            if (f === 'pages') {
                targets.push(fullPath);
            }
            targets = targets.concat(walkTargetDirs(fullPath));
        }
    });
    return targets;
}

const targetDirs = walkTargetDirs('apps/web-admin/src/app/routes');
let moves = 0;

targetDirs.forEach(dir => {
    const parent = path.dirname(dir);
    const files = fs.readdirSync(dir);
    
    files.forEach(file => {
        const oldPath = path.join(dir, file);
        let newPath = path.join(parent, file);
        
        // Handle name collisions just in case they both have 'dashboard.tsx' for some weird reason
        if (fs.existsSync(newPath)) {
            newPath = path.join(parent, file.replace('.tsx', '_flattened.tsx').replace('.ts', '_flattened.ts'));
        }
        
        fs.renameSync(oldPath, newPath);
        moves++;
        console.log(`Moved ${file} -> ${newPath}`);
    });
    
    try {
        fs.rmdirSync(dir);
        console.log(`Destroyed empty container: ${dir}`);
    } catch(e) {
        console.log(`Could not destroy ${dir} - ${e.message}`);
    }
});

console.log(`Flattened ${moves} literal pages/ files directly into their tenancy roots.`);
