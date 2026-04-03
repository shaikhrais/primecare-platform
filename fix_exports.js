const fs = require('fs');
const path = require('path');

function walk(dir, callback) {
  fs.readdirSync(dir).forEach(f => {
    let dirPath = path.join(dir, f);
    if(fs.statSync(dirPath).isDirectory()) {
        walk(dirPath, callback);
    } else {
        callback(path.join(dir, f));
    }
  });
}

const targetDir = path.join(__dirname, 'services');

walk(targetDir, (filePath) => {
  if (filePath.endsWith('.ts')) {
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    content = content.replace(/import\s+\{([^}]*)(requireAuth|requirePermission|requireOwner|requireClientAssignedToPSW|requireStaff)[^}]*\}\s+from\s+['"]@primecare\/shared-utils['"]/g, 
        "import { $1$2 } from '@primecare/shared-auth'");

    if (original !== content) {
      console.log('Fixed export leakage in', filePath);
      fs.writeFileSync(filePath, content, 'utf8');
    }
  }
});
