const fs = require('fs'); 
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');
const brainPath = 'C:\\Users\\Admin2\\.gemini\\antigravity\\brain\\cdcc0ead-6614-438c-8a9a-dc3fa1ec4c7a';

const widgetCounts = {};
const widgetLocations = {};

function scan(dir) {
    if (!fs.existsSync(dir)) return;
    for (let f of fs.readdirSync(dir)) {
        let p = path.join(dir, f);
        if (fs.statSync(p).isDirectory()) {
            scan(p);
        } else if (p.endsWith('.dart') && !p.includes('generated') && !p.includes('primecare_ui')) {
            let c = fs.readFileSync(p, 'utf8');
            // Match widget constructors like `child: Text(`, `return Scaffold(`, `[ Column(`
            const regex = /(?:return|child:|children:\s*\[|\s+|,)\s*([A-Z][a-zA-Z0-9_]*)\(/g;
            let match;
            while ((match = regex.exec(c)) !== null) {
                let widgetName = match[1];
                // Filter out common non-widgets that start with uppercase
                if (['Color', 'EdgeInsets', 'BorderRadius', 'TextStyle', 'IconData', 'Size', 'String', 'Duration', 'Map', 'List', 'DateTime', 'BoxShadow', 'Offset', 'Border', 'BorderSide', 'MaterialPageRoute'].includes(widgetName)) continue;

                widgetCounts[widgetName] = (widgetCounts[widgetName] || 0) + 1;
                
                if (!widgetLocations[widgetName]) widgetLocations[widgetName] = new Set();
                widgetLocations[widgetName].add(f);
            }
        }
    }
}

console.log('Initiating deep-scan over universal architecture...');
scan(srcRoot);

let sorted = Object.entries(widgetCounts).sort((a,b) => b[1] - a[1]);
let md = `# Absolute Component Encapsulation Audit (Phase 86)\n\n`;
md += `This document catalogs EVERY distinct UI Module constructed natively within the application boundary (\`lib/\`), definitively identifying the remaining "loose" structural primitives requesting migration into \`primecare_ui\`.\n\n`;
md += `## Structural Component Heatmap\n\n| Component Entity | Global Instances | Framework Source |\n| :--- | :--- | :--- |\n`;

let uiLibComponents = ['PrimeCareCard', 'PrimeCareButton', 'PrimeCareTextField', 'PrimeCareSectionHeader', 'PrimeCareBadge', 'PrimeCareAvatar', 'PrimeCareWizardFlow', 'MasterDetailLayout', 'DesktopPaneWrapper', 'ResponsiveLayoutManager', 'ResponsiveShell', 'OfflineBanner', 'PrimeCareScheduler', 'PrimeCareStatCard', 'PrimeCareDataTable', 'PrimeCareAppBar', 'ResponsivePane'];

for (let [name, count] of sorted) {
    let source = name.startsWith('PrimeCare') || uiLibComponents.includes(name) ? '`primecare_ui`' : '`flutter/material`';
    md += `| **${name}** | ${count} | ${source} |\n`;
}

md += `\n\n## Targeted Layout & Typography Primitives\n`;
md += `The Founder explicitly commanded: *"include all layous also we are add layout as now"*. The critical structural Flutter layouts directly bypassing \`primecare_ui\` currently are:\n`;

let targets = ['Text', 'SizedBox', 'Column', 'Row', 'ListView', 'Scaffold', 'Expanded', 'Padding', 'Icon', 'SingleChildScrollView', 'Container', 'Center', 'Flexible', 'SafeArea', 'Stack'];
for(let t of targets) {
    if(widgetCounts[t]) {
        let files = Array.from(widgetLocations[t]).slice(0, 3).join(', ') + (widgetLocations[t].size > 3 ? `... (+${widgetLocations[t].size - 3} more)` : '');
        md += `- **\`${t}\`**: Found ${widgetCounts[t]} times globally. Example leaks: \`${files}\`\n`;
    }
}

fs.writeFileSync(path.join(brainPath, 'loose_framework_audit.md'), md, 'utf8');
console.log('Audit compiled natively to loose_framework_audit.md');
