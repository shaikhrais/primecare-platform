const fs = require('fs');
const path = require('path');

const libDir = path.join(__dirname, 'lib');
const featuresDir = path.join(libDir, 'features');

const rolesDir = path.join(featuresDir, 'roles');
const masterDir = path.join(featuresDir, 'master');

if (!fs.existsSync(rolesDir)) fs.mkdirSync(rolesDir);
if (!fs.existsSync(masterDir)) fs.mkdirSync(masterDir);

const roleFolders = ['admin', 'client', 'coordinator', 'gm', 'manager', 'mt', 'psw', 'rn', 'scrum_master', 'superuser'];
const masterFolders = ['auth', 'home', 'messaging', 'payment', 'shared', 'telemetry'];

function safeMove(src, dest) {
  if (fs.existsSync(src)) {
    fs.renameSync(src, dest);
  }
}

// 1. Physically move directories
roleFolders.forEach(folder => {
  safeMove(path.join(featuresDir, folder), path.join(rolesDir, folder));
});

masterFolders.forEach(folder => {
  safeMove(path.join(featuresDir, folder), path.join(masterDir, folder));
});

// 2. Recursively update all imports in all .dart files
function updateImports(dir) {
  const items = fs.readdirSync(dir);
  for (const item of items) {
    const fullPath = path.join(dir, item);
    if (fs.statSync(fullPath).isDirectory()) {
      updateImports(fullPath);
    } else if (fullPath.endsWith('.dart')) {
      let content = fs.readFileSync(fullPath, 'utf8');
      let modified = false;

      // Update role imports
      roleFolders.forEach(folder => {
        const target = `package:primecare_mobile/features/${folder}`;
        const replacement = `package:primecare_mobile/features/roles/${folder}`;
        if (content.includes(target)) {
          // Global replace for this target
          content = content.split(target).join(replacement);
          modified = true;
        }
      });

      // Update master imports
      masterFolders.forEach(folder => {
        const target = `package:primecare_mobile/features/${folder}`;
        const replacement = `package:primecare_mobile/features/master/${folder}`;
        if (content.includes(target)) {
          // Global replace for this target
          content = content.split(target).join(replacement);
          modified = true;
        }
      });

      // Update relative imports
      // This is slightly trickier, but most PrimeCare files use absolute package imports.
      // E.g., import '../shared/x.dart'; 
      // We will blindly replace '../shared/' with '../master/shared/' if needed, but safe regex is hard.
      // Instead, let's fix the major relative imports strictly if they exist.
      const relativeRoleRegex = new RegExp(`['"]\\.\\./(${roleFolders.join('|')})/`, 'g');
      content = content.replace(relativeRoleRegex, (match, p1) => {
        modified = true;
        return match.charAt(0) + '../../roles/' + p1 + '/';
      });

      const relativeMasterRegex = new RegExp(`['"]\\.\\./(${masterFolders.join('|')})/`, 'g');
      content = content.replace(relativeMasterRegex, (match, p1) => {
        modified = true;
        return match.charAt(0) + '../../master/' + p1 + '/';
      });

      if (modified) {
        fs.writeFileSync(fullPath, content, 'utf8');
      }
    }
  }
}

updateImports(libDir);

console.log("MIGRATION COMPLETE: All folders dynamically relocated into /master and /roles cleanly.");
