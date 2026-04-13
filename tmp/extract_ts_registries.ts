import { PageRegistry } from '../packages/domain/src/registries/PageRegistry';
import { FormRegistry, getFormById } from '../packages/domain/src/registries/FormRegistry';
import * as fs from 'fs';

let md_content = '# PrimeCare Full Entity Registry (Pages & Forms)\n\n';
md_content += `## TS Page Registry (${PageRegistry.length} Entries)\n\n`;
md_content += `| ID | Route | Label | Type | Owner | Connected Form |\n`;
md_content += `|---|---|---|---|---|---|\n`;

for (const p of PageRegistry) {
    const formId = p.formRegistryId || 'N/A';
    const formName = formId !== 'N/A' ? (getFormById(formId)?.name || formId) : 'None';
    md_content += `| \`${p.id}\` | \`${p.route}\` | ${p.label} | \`${p.type}\` | \`${p.owner}\` | ${formName} |\n`;
}

md_content += `\n## TS Form Registry (${FormRegistry.length} Entries)\n\n`;
md_content += `| ID | Name | Submits To | Owner |\n`;
md_content += `|---|---|---|---|\n`;

for (const f of FormRegistry) {
    md_content += `| \`${f.id}\` | ${f.name} | \`${f.apiEndpoint || 'N/A'}\` | \`${f.owner || 'Unknown'}\` |\n`;
}

fs.writeFileSync('c:/Users/Admin2/.gemini/antigravity/brain/aae26c46-7e18-47f3-b34c-77ef721cdea0/ts_registry_matrix.md', md_content, 'utf-8');
console.log(`Generated TS Matrix with ${PageRegistry.length} pages and ${FormRegistry.length} forms.`);
