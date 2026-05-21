const fs = require('fs');
const path = require('path');

const dashboards = JSON.parse(fs.readFileSync('c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\scratch\\active_dashboards.json', 'utf8'));

const allPaths = [];
for (const app in dashboards) {
  allPaths.push(...dashboards[app]);
}

function findWidgetClosingParen(content, startPos) {
  let parenCount = 0;
  let bracketCount = 0;
  let braceCount = 0;
  let inString = false;
  let stringChar = '';
  
  for (let i = startPos; i < content.length; i++) {
    const char = content[i];
    
    if (inString) {
      if (char === stringChar && content[i - 1] !== '\\') {
        inString = false;
      }
      continue;
    }
    if (char === "'" || char === '"') {
      inString = true;
      stringChar = char;
      continue;
    }
    
    if (char === '(') parenCount++;
    else if (char === ')') parenCount--;
    else if (char === '[') bracketCount++;
    else if (char === ']') bracketCount--;
    else if (char === '{') braceCount++;
    else if (char === '}') braceCount--;
    
    if (parenCount === 0 && bracketCount === 0 && braceCount === 0 && i > startPos) {
      if (content[i] === ')') {
        return i;
      }
    }
  }
  return -1;
}

let modifiedCount = 0;
let skippedCount = 0;

allPaths.forEach(filePath => {
  if (!fs.existsSync(filePath)) {
    console.log(`File not found: ${filePath}`);
    return;
  }
  
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Skip if already contains 1800 constraint
  if (content.includes('maxWidth: 1800') || content.includes('1800')) {
    console.log(`Skipping (already optimized): ${path.basename(filePath)}`);
    skippedCount++;
    return;
  }
  
  // Try wrapping Scaffold body first
  const bodyIndex = content.indexOf('body:');
  if (bodyIndex !== -1) {
    let startPos = bodyIndex + 5;
    while (startPos < content.length && /\s/.test(content[startPos])) {
      startPos++;
    }
    
    const endPos = findWidgetClosingParen(content, startPos);
    if (endPos !== -1) {
      const widgetCode = content.substring(startPos, endPos + 1);
      const wrapped = `Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ${widgetCode},
        ),
      )`;
      
      content = content.substring(0, startPos) + wrapped + content.substring(endPos + 1);
      fs.writeFileSync(filePath, content, 'utf8');
      console.log(`Wrapped body in: ${path.basename(filePath)}`);
      modifiedCount++;
      return;
    }
  }
  
  // If no Scaffold body, wrap SafeArea child
  const safeAreaIndex = content.indexOf('SafeArea(');
  if (safeAreaIndex !== -1) {
    const childIndex = content.indexOf('child:', safeAreaIndex);
    if (childIndex !== -1) {
      let startPos = childIndex + 6;
      while (startPos < content.length && /\s/.test(content[startPos])) {
        startPos++;
      }
      
      const endPos = findWidgetClosingParen(content, startPos);
      if (endPos !== -1) {
        const widgetCode = content.substring(startPos, endPos + 1);
        const wrapped = `Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1800),
            child: ${widgetCode},
          ),
        )`;
        
        content = content.substring(0, startPos) + wrapped + content.substring(endPos + 1);
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Wrapped SafeArea child in: ${path.basename(filePath)}`);
        modifiedCount++;
        return;
      }
    }
  }
  
  console.log(`Failed to process: ${path.basename(filePath)}`);
});

console.log(`Summary: Wrapped ${modifiedCount} files, Skipped ${skippedCount} files.`);
