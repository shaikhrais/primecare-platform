const fs = require('fs');

function fix(file, replacements) {
    if (!fs.existsSync(file)) return;
    let txt = fs.readFileSync(file, 'utf8');
    
    // Global imports slash fix
    txt = txt.replace(/from\s+['"]([^'"]+)['"]/g, match => match.replace(/\\\\/g, '/'));
    
    for (const [search, replace] of replacements) {
        if (txt.includes(search)) {
            txt = txt.replace(search, replace);
        } else {
            console.log('NOT FOUND in ' + file + ':\n' + search.substring(0, 50));
        }
    }
    fs.writeFileSync(file, txt, 'utf8');
}

fix('apps/web-admin/src/app/routes/platform/admin.tsx', [
    [",\n    { key: 'service', label: 'Service' }", "export const earningCols: TableColumn[] = [\n    { key: 'provider', label: 'Provider' }, { key: 'client', label: 'Client' },\n    { key: 'service', label: 'Service' }"],
    ["ction fetchIncidents(): Promise<any[]> {", "export async function fetchIncidents(): Promise<any[]> {"],
    ['PageTemplate pageId="D6-OBS" title="📡 Observability Home" s', "export function ObservabilityHome() {\n    return <PageTemplate pageId=\"D6-OBS\" title=\"📡 Observability Home\" s"],
    ["t API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8787'", "export const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8787'"]
]);

fix('apps/web-admin/src/app/routes/platform/scrum-master.tsx', [
    ["egistry } = AdminRegistry;", "const { RouteRegistry, ApiRegistry, ButtonRegistry, ContentRegistry, ThemeRegistry } = AdminRegistry;"],
    ["age { name: string; path: string; variable: string; category: string; isDynamic: boolean; }", "export interface AuditPage { name: string; path: string; variable: string; category: string; isDynamic: boolean; }"],
    ["ng; label: string; description: string; icon: React.ReactNode;", "export interface PipelineStep { id: string; label: string; description: string; icon: React.ReactNode;"],
    ["face RoleFlowEntry {", "export interface RoleFlowEntry {"],
    ["sm-card {", "export const roleFlowsStyles2 = `\n    .sm-card {"]
]);

fix('apps/web-admin/src/app/routes/tenancy/rn.tsx', [
    ["route: string; frequency: string;", "export interface Medication { name: string; dose: string; route: string; frequency: string;"],
    ["onRegistry['WC']}\n        />\n    );\n}", "export function WoundCareHome() {\n    return (\n        <PageTemplate pageId=\"WC\" title=\"Wound Care Home\" subtitle=\"Wound Care Management\"\n            sectionData={PageSectionRegistry['WC']}\n        />\n    );\n}"]
]);

fix('apps/web-admin/src/app/routes/tenancy/family.tsx', [
    ["ctionData={PageSectionRegistry['FAM']}\n        />\n    );\n}", "export function FamilyHome() {\n    return (\n        <PageTemplate pageId=\"FAM\" title=\"Family Home\" subtitle=\"Manage family care plans\"\n            sectionData={PageSectionRegistry['FAM']}\n        />\n    );\n}"]
]);

console.log('Fixes applied.');
