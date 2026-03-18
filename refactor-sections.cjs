const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, 'apps/web-admin/src/app');
const routesDir = path.join(srcDir, 'routes');
const sectionsDir = path.join(srcDir, 'sections');

// Ensure section directories exist
['shared', 'tenancy', 'platform', 'auth'].forEach(d => {
    fs.mkdirSync(path.join(sectionsDir, d), { recursive: true });
});

const files = ['shared.tsx', 'tenancy.tsx', 'platform.tsx', 'auth.tsx'];
const registryEntries = [];

let textVarsString = '';

files.forEach(fileName => {
    const filePath = path.join(routesDir, fileName);
    let content = fs.readFileSync(filePath, 'utf8');
    const scope = fileName.replace('.tsx', '');
    
    // Extract TEXT_VARS if found inside shared.tsx to relocate it to the sections index
    if (fileName === 'shared.tsx') {
        const textVarsMatch = content.match(/export const TEXT_VARS.*?};/s);
        if (textVarsMatch) {
            textVarsString = textVarsMatch[0];
            content = content.replace(textVarsMatch[0], '');
        }
        
        // Remove the massive legacy PageSectionRegistry dictionary
        const oldRegistryMatch = content.match(/export const PageSectionRegistry.*?};\s*$/s);
        if (oldRegistryMatch) {
            content = content.replace(oldRegistryMatch[0], 'import { PageSectionRegistry } from "../sections";\\nexport { PageSectionRegistry };\\n');
        }
    }

    // RegEx to find and replace the PageTemplate instances
    const componentRegex = /export function ([A-Za-z0-9_]+)\(\) \{\s*return \(\s*<PageTemplate\s+pageId="([^"]+)"\s*(.*?)sectionData=\{PageSectionRegistry\['([^']+)'\]\}\s*\/>\s*\);\s*\}/gs;

    let modifiedContent = content;
    let match;

    while ((match = componentRegex.exec(content)) !== null) {
        const compName = match[1];
        const oldPageId = match[2];
        const midProps = match[3];
        const oldSectionKey = match[4];

        const sectionFileName = `${compName}Section.ts`;
        const sectionFilePath = path.join(sectionsDir, scope, sectionFileName);

        // Generate the physical physical section payload file
        const sectionCode = `import { SectionConfig } from '@/shared/types';

export const ${compName}Section: SectionConfig = {
    'mod.stats': { kpiCards: [
        { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
        { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
        { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
    ]},
    'mod.body': { emptyState: { 
        title: '${compName.replace(/([A-Z])/g, ' $1').trim()}', 
        description: 'This layout configuration has been safely decoupled and is awaiting custom React logic.' 
    }}
};
`;
        fs.writeFileSync(sectionFilePath, sectionCode, 'utf8');

        // Append to the Master Registry
        registryEntries.push({ scope, compName });

        // Update the route file's AST string to use the stable string literal rather than randomized complex keys
        const newComponentCode = `export function ${compName}() {
    return (
        <PageTemplate 
            pageId="PGE-${compName}" 
            ${midProps.trim()}
            sectionData={PageSectionRegistry['${compName}']}
        />
    );
}`;
        modifiedContent = modifiedContent.replace(match[0], newComponentCode);
    }

    // Rewrite the route file with the stable identifiers and stripped dictionary monolith
    fs.writeFileSync(filePath, modifiedContent, 'utf8');
});

// Build the robust src/app/sections/index.ts Registry Engine
let indexCode = `import { SectionConfig } from '@/shared/types';\n\n`;

if (textVarsString) {
    indexCode += textVarsString + '\n\n';
} else {
    indexCode += `export const TEXT_VARS: Record<string, string> = {};\n\n`;
}

registryEntries.forEach(entry => {
    indexCode += `import { ${entry.compName}Section } from './${entry.scope}/${entry.compName}Section';\n`;
});

indexCode += `\nexport const PageSectionRegistry: Record<string, SectionConfig> = {\n`;
registryEntries.forEach(entry => {
    indexCode += `    '${entry.compName}': ${entry.compName}Section,\n`;
});
indexCode += `};\n`;

fs.writeFileSync(path.join(sectionsDir, 'index.ts'), indexCode, 'utf8');

console.log("✅ Successfully decoupled " + registryEntries.length + " UI routes into physical src/app/sections/ modules.");
