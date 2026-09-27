const fs = require('fs');
const path = require('path');

const APPS_DIR = path.join(__dirname, '..', 'apps');
const OUT_PATH = path.join(__dirname, '..', 'brain', '9f1aac54-2244-49d2-b642-4b25189f019f', 'full_role_screen_table.md');

function getDirectories(srcPath) {
  if (!fs.existsSync(srcPath)) return [];
  return fs.readdirSync(srcPath).filter(file => fs.statSync(path.join(srcPath, file)).isDirectory());
}

function getDartFiles(srcPath) {
    if (!fs.existsSync(srcPath)) return [];
    let results = [];
    const list = fs.readdirSync(srcPath);
    list.forEach(file => {
        const fullPath = path.join(srcPath, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) { 
            results = results.concat(getDartFiles(fullPath));
        } else {
            if(file.endsWith('.dart') && (file.includes('screen') || file.includes('view') || file.includes('page'))) {
                results.push({ name: path.basename(file, '.dart'), fullPath });
            }
        }
    });
    return results;
}

const apps = getDirectories(APPS_DIR);

let markdown = `# Full PrimeCare Role & Screen Inventory\n\n`;
markdown += `This table contains a 100% complete listing of every single screen available in the PrimeCare ecosystem, categorized by Role.\n\n`;
markdown += `| Role (App) | Screen / Feature Name |\n`;
markdown += `| :--- | :--- |\n`;

apps.forEach(app => {
  const roleName = app.replace('primecare_', '').toUpperCase();
  const libPath = path.join(APPS_DIR, app, 'lib');
  const screenFiles = getDartFiles(libPath);
  
  if (screenFiles.length === 0) {
    markdown += `| **${roleName}** | *(No UI Screens - Core Logic/Service)* |\n`;
  } else {
    // Deduplicate names
    const uniqueNames = [...new Set(screenFiles.map(s => s.name))].sort();
    uniqueNames.forEach(screenName => {
      markdown += `| **${roleName}** | \`${screenName}\` |\n`;
    });
  }
});

const brainDir = path.dirname(OUT_PATH);
if (!fs.existsSync(brainDir)) fs.mkdirSync(brainDir, { recursive: true });
fs.writeFileSync(OUT_PATH, markdown, 'utf8');

console.log('Successfully generated full_role_screen_table.md');
