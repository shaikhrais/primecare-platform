const fs = require('fs');
const path = require('path');

const mdPath = path.join(__dirname, '../screen_inventory_251.md');

let mdContent = `# PrimeCare Screen Inventory (251 Screens)

| Screen ID | Feature Function | Scaffolded Components |
|---|---|---|
`;

for (let i = 1; i <= 251; i++) {
  mdContent += `| \`SCREEN_PREMIUM_FEATURE_${i}\` | Premium Feature ${i} Dashboard | \`GovernedConsumerWidget\`, \`PageTemplate\`, \`Center\`, \`Text\` |\n`;
}

fs.writeFileSync(mdPath, mdContent);
console.log('Markdown table generated at screen_inventory_251.md');
