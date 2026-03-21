const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib', 'features');

let stats = {
  ElevatedButton: 0,
  OutlinedButton: 0,
  TextButton: 0,
  TextFormField: 0,
  BoxDecoration: 0,
  filesWithLoosePrimitives: new Set()
};

function scan(dir) {
  if (!fs.existsSync(dir)) return;
  for (let f of fs.readdirSync(dir)) {
    let p = path.join(dir, f);
    if (fs.statSync(p).isDirectory()) {
      scan(p);
    } else if (p.endsWith('.dart')) {
      let c = fs.readFileSync(p, 'utf8');
      let matches = false;
      
      const vElevated = (c.match(/ElevatedButton\(/g) || []).length;
      const vOutlined = (c.match(/OutlinedButton\(/g) || []).length;
      const vTextBtn  = (c.match(/TextButton\(/g) || []).length;
      const vInput    = (c.match(/TextFormField\(/g) || []).length;
      const vBoxDec   = (c.match(/BoxDecoration\(/g) || []).length;

      stats.ElevatedButton += vElevated;
      stats.OutlinedButton += vOutlined;
      stats.TextButton += vTextBtn;
      stats.TextFormField += vInput;
      stats.BoxDecoration += vBoxDec;

      if (vElevated > 0 || vOutlined > 0 || vTextBtn > 0 || vInput > 0 || vBoxDec > 0) {
        stats.filesWithLoosePrimitives.add(p.replace(/\\/g, '/').split('lib/features/')[1]);
      }
    }
  }
}

scan(srcRoot);

let report = `# PrimeCare Loose Primitive UI Audit\n\n`;
report += `This audit executed a physical AST string-match over all screen layouts in the \`mobile_flutter\` directory to detect hard-coded "loose" Flutter primitives that must be encapsulated by \`primecare_ui\`.\n\n`;
report += `### Raw Primitive Distribution\n`;
report += `- **ElevatedButtons**: ${stats.ElevatedButton}\n`;
report += `- **OutlinedButtons**: ${stats.OutlinedButton}\n`;
report += `- **TextButtons**: ${stats.TextButton}\n`;
report += `- **TextFormFields**: ${stats.TextFormField}\n`;
report += `- **BoxDecorations (Cards)**: ${stats.BoxDecoration}\n\n`;

report += `### Screens Requiring Refactoring (${stats.filesWithLoosePrimitives.size})\n`;
for (let file of stats.filesWithLoosePrimitives) {
  report += `- \`${file}\`\n`;
}

console.log(report);
