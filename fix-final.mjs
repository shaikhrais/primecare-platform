import fs from 'fs';
import path from 'path';

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors.json', 'utf8'));

const fileErrors = {};
errors.forEach(err => {
    const match = err.match(/^(.+?)\((\d+),(\d+)\):\s*(.+)$/);
    if (!match) return;
    const [_, filePath, line, col, message] = match;
    const absolutePath = path.resolve(process.cwd(), 'apps/web-admin', filePath);
    if (!fileErrors[absolutePath]) fileErrors[absolutePath] = [];
    fileErrors[absolutePath].push({ line: parseInt(line), col: parseInt(col), message });
});

for (const [filePath, fileErrs] of Object.entries(fileErrors)) {
    if (!fs.existsSync(filePath)) continue;
    
    let contentLines = fs.readFileSync(filePath, 'utf8').split('\n');
    let hasChanges = false;
    
    fileErrs.sort((a, b) => b.line - a.line);
    
    let needsTableColumn = false;
    let needsTabItem = false;
    let needsUseState = false;

    for (const err of fileErrs) {
        let lineIdx = err.line - 1;
        let lineStr = contentLines[lineIdx];
        
        if (err.message.includes("is not assignable to type 'Promise<{ default: ComponentType<any>; }>'")) {
            const lazyMatch = lineStr.match(/const\s+([A-Za-z0-9_]+)\s*=\s*lazy\(\(\)\s*=>\s*import\(['"]([^'"]+)['"]\)\s*\);/);
            if (lazyMatch) {
                const varName = lazyMatch[1];
                const importPath = lazyMatch[2];
                contentLines[lineIdx] = lineStr.replace(
                    /lazy\(\(\)\s*=>\s*import\(['"][^'"]+['"]\)\s*\)/,
                    `lazy(() => import('${importPath}').then(m => ({ default: Object.values(m)[0] as any })))`
                );
                hasChanges = true;
            }
        }
        
        if (err.message.includes("has no default export")) {
            if (lineStr.includes('import ') && !lineStr.includes('{')) {
                contentLines[lineIdx] = lineStr.replace(/import\s+([A-Za-z0-9_]+)\s+from/, 'import { $1 } from');
                hasChanges = true;
            }
        }
        
        if (err.message.includes("Cannot find name 'TableColumn'")) needsTableColumn = true;
        if (err.message.includes("Cannot find name 'TabItem'")) needsTabItem = true;
        if (err.message.includes("Cannot find name 'useState'")) needsUseState = true;
        
        if (err.message.includes("Property 'items' is missing")) {
            if (lineStr.includes('kpiCards: [')) {
                contentLines[lineIdx] = lineStr.replace(/kpiCards:\s*\[/, 'kpiCards: { items: [');
                // The tricky part: we need to find the matching `],` or `] }` to close the object.
                // In our script, the structure were written cleanly: `] },`
                for (let j = lineIdx; j < contentLines.length; j++) {
                    if (contentLines[j].includes(']')) {
                        contentLines[j] = contentLines[j].replace(/\]/, ']}');
                        break;
                    }
                }
                hasChanges = true;
            }
            // For scrum-master: `cardGrid: [` -> `cardGrid: { items: [`
            if (lineStr.includes('cardGrid: [')) {
                contentLines[lineIdx] = lineStr.replace(/cardGrid:\s*\[/, 'cardGrid: { items: [');
                for (let j = lineIdx; j < contentLines.length; j++) {
                    if (contentLines[j].includes(']')) {
                        contentLines[j] = contentLines[j].replace(/\]/, ']}');
                        break;
                    }
                }
                hasChanges = true;
            }
            // And any others like tabs: [ ... ]
            if (lineStr.includes('tabs: [')) {
                contentLines[lineIdx] = lineStr.replace(/tabs:\s*\[/, 'tabs: { items: [');
                for (let j = lineIdx; j < contentLines.length; j++) {
                    if (contentLines[j].includes(']')) {
                        contentLines[j] = contentLines[j].replace(/\]/, ']}');
                        break;
                    }
                }
                hasChanges = true;
            }
        }
        
        if (err.message.includes("Property 'RegistrySummaryHome' does not exist")) {
             contentLines[lineIdx] = lineStr.replace('m.RegistrySummaryHome', 'm.RegistrySummary');
             hasChanges = true;
        }
        if (err.message.includes("Did you mean 'Schedule'?")) {
             contentLines[lineIdx] = lineStr.replace('m.ScheduleHub', 'm.Schedule');
             hasChanges = true;
        }
        if (err.message.includes("Property 'LeadsPage' does not exist")) {
             contentLines[lineIdx] = lineStr.replace('m.LeadsPage', 'm.LeadList');
             hasChanges = true;
        }
        if (err.message.includes("Property 'LeadAdmission' does not exist")) {
             contentLines[lineIdx] = lineStr.replace('m.LeadAdmission', 'm.ClientAdmission');
             hasChanges = true;
        }
        if (err.message.includes("Property 'Onboarding' does not exist")) {
             contentLines[lineIdx] = lineStr.replace('m.Onboarding', 'm.StaffOnboarding');
             hasChanges = true;
        }
        if (err.message.includes("Property 'Reconciliation' does not exist")) {
             contentLines[lineIdx] = lineStr.replace('m.Reconciliation', 'm.FinancialReconciliation');
             hasChanges = true;
        }
        if (err.message.includes("Property 'InvoicesNew' does not exist")) {
             contentLines[lineIdx] = lineStr.replace(/m\.InvoicesNew\s*\|\|\s*/, '');
             hasChanges = true;
        }
        if (err.message.includes("Property 'default' does not exist")) {
             if (lineStr.includes('m.default')) {
                 contentLines[lineIdx] = lineStr.replace(/\|\|\s*m\.default/, '');
                 hasChanges = true;
             }
        }
    }
    
    let newContent = contentLines.join('\n');
    
    if (needsTableColumn && !newContent.includes("import { TableColumn }")) {
        newContent = `import { TableColumn } from '@/shared/components/sections/SectionTable';\n` + newContent;
        hasChanges = true;
    }
    if (needsTabItem && !newContent.includes("import { TabItem }")) {
        newContent = `import { TabItem } from '@/shared/components/sections/SectionTabs';\n` + newContent;
        hasChanges = true;
    }
    if (needsUseState && !newContent.includes("import { useState }")) {
        newContent = `import { useState } from 'react';\n` + newContent;
        hasChanges = true;
    }
    
    if (hasChanges) {
        fs.writeFileSync(filePath, newContent, 'utf8');
        console.log(`Final fixes to ${path.basename(filePath)}`);
    }
}
