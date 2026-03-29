const fs = require('fs');
const path = require('path');

const UI_LIB = path.join(__dirname, '../../packages/primecare_ui/lib/src');

function findDartFiles(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir, { withFileTypes: true });
  for (const file of files) {
    const fn = path.join(dir, file.name);
    if (file.isDirectory()) {
      findDartFiles(fn, fileList);
    } else if (fn.endsWith('.dart')) {
      fileList.push(fn);
    }
  }
  return fileList;
}

const allDartFiles = findDartFiles(UI_LIB);

let replacedColorsCount = 0;
let replacedTextStylesCount = 0;
let replacedOverflowsCount = 0;

console.log("=== EXECUTING MASSIVE PILLAR 2 & 3 REGEX SWEEP ===");

for (const filePath of allDartFiles) {
   let content = fs.readFileSync(filePath, 'utf8');
   let originalContent = content;

   // Centralize Colors (The "Cetrizef" Pillar)
   // Replacing explicitly hardcoded Colors.blue variants with dynamic Theme hooks
   if (content.includes('Colors.blue')) {
       // Replace solid blue with Theme primary constraint
       content = content.replace(/Colors\.blue(?![\.a-zA-Z])/g, 'Theme.of(context).primaryColor');
       
       // Replace shades of blue with context derivatives (using generic brand primary color where opacity is needed)
       content = content.replace(/Colors\.blue\.shade[0-9]+/g, 'Theme.of(context).primaryColorLight');
       content = content.replace(/Colors\.blueAccent/g, 'Theme.of(context).colorScheme.secondary');
       
       replacedColorsCount++;
   }
   
   // Centralize some common grey usages to color schemes to decouple Material hardcodes
   /* content = content.replace(/Colors\.grey\[[0-9]+\]/g, 'Theme.of(context).colorScheme.surfaceVariant'); */

   // Inject Overflow Resilience (The "Rizilians" Pillar)
   // Look for Text('...') without an overflow property inside PrimeCare components,
   // specifically targeting short label styles. Doing a massive AST inject is dangerous, 
   // but we can append overflow: TextOverflow.ellipsis to basic Text calls.
   // Simple search for Text(var) or Text('string') without overflow:
   // Example: Text(title, style: ...) -> Text(title, overflow: TextOverflow.ellipsis, style: ...)
   
   // Regex finds Text(...) where there is no overflow declaration
   const textRegex = /Text\(\s*([^,]+?)\s*,\s*style:\s*([^\)]+?)\s*\)/g;
   if (textRegex.test(content) && !content.includes('TextOverflow.ellipsis')) {
       content = content.replace(textRegex, (match, p1, p2) => {
           if (p2.includes('TextOverflow')) return match; 
           return 'Text(' + p1 + ', overflow: TextOverflow.ellipsis, maxLines: 1, style: ' + p2 + ')';
       });
       replacedOverflowsCount++;
   }

   const boldTextRegex = /Text\(\s*([^,]+?)\s*,\s*maxLines:\s*([0-9]+)\s*,\s*style:\s*([^\)]+?)\s*\)/g;
   if (boldTextRegex.test(content) && !content.includes('TextOverflow.ellipsis')) {
       content = content.replace(boldTextRegex, (match, p1, p2, p3) => {
           if (p3.includes('TextOverflow')) return match; 
           return 'Text(' + p1 + ', maxLines: ' + p2 + ', overflow: TextOverflow.ellipsis, style: ' + p3 + ')';
       });
       replacedOverflowsCount++;
   }

   if (content !== originalContent) {
       fs.writeFileSync(filePath, content, 'utf8');
   }
}

console.log('✅ Re-aligned ' + replacedColorsCount + ' components to Centralized Theme Dynamics.');
console.log('✅ Fortified ' + replacedOverflowsCount + ' components with Overflow-Ellipsis Resilience.');
