const fs = require('fs');
const path = require('path');

function cleanDirectory(dirPath) {
  if (!fs.existsSync(dirPath)) return;
  const files = fs.readdirSync(dirPath);

  for (const file of files) {
    const fullPath = path.join(dirPath, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      cleanDirectory(fullPath);
    } else if (fullPath.endsWith('.dart')) {
      cleanFile(fullPath);
    }
  }
}

function cleanFile(filePath) {
  let content = fs.readFileSync(filePath, 'utf-8');
  let originalContent = content;

  // Clean AST Syntax
  content = content.replace(/const const const const const /g, 'const ');
  content = content.replace(/const const const const /g, 'const ');
  content = content.replace(/const const const /g, 'const ');
  content = content.replace(/const const /g, 'const ');

  // Clean redundant shadow comments
  content = content.replace(/\/\* Soft Shadow \*\//g, '');
  content = content.replace(/\/\* TODO: Rose Background \*\//g, '');

  if (content !== originalContent) {
    fs.writeFileSync(filePath, content, 'utf-8');
    console.log(`[AST CLEANED] ${path.basename(filePath)}`);
  }
}

console.log("Running AST Syntax Sanitizer...");
cleanDirectory(path.join(__dirname, '..', 'lib'));
console.log("Cleanup complete!");
