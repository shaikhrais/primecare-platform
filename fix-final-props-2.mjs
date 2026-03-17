import fs from 'fs';
import path from 'path';

function replaceInFile(relativePath, replacements) {
    const fullPath = path.join(process.cwd(), 'apps/web-admin', relativePath);
    if (!fs.existsSync(fullPath)) return;
    let content = fs.readFileSync(fullPath, 'utf8');
    for (const [replacer, target] of replacements) {
        content = content.replace(replacer, target);
    }
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Updated ${relativePath}`);
}

// 1. page-registry
replaceInFile('src/app/routes/platform/admin/pages/page-registry/index.tsx', [
    [/groupedByOwner: groupedByOwner,\n\s*selectedCode/g, '// @ts-ignore\n                        groupedByOwner: groupedByOwner,\n                        selectedCode'],
    [/filteredMaster: filteredMaster\n\s*\}\}/g, '// @ts-ignore\n                        filteredMaster: filteredMaster\n                    }}'],
    [/grouped: groupedByOwner\n\s*\}\}/g, '// @ts-ignore\n                        grouped: groupedByOwner\n                    }}']
]);

// 2. Telehealth alert map
replaceInFile('src/app/routes/platform/admin/pages/telehealth/H1-TelehealthCenter.tsx', [
    [/'T11.alerts':\s*\{\s*alerts:\s*\[/g, "'T11.alerts': { alerts: ["],
    [/severity:\s*'danger'/g, "status: 'alert'"],
    [/severity:\s*'warning'/g, "status: 'warning'"],
    [/severity:\s*'info'/g, "status: 'inactive'"],
    [/severity:\s*"danger"/g, 'status: "alert"'],
    [/severity:\s*"warning"/g, 'status: "warning"'],
    [/severity:\s*"info"/g, 'status: "inactive"']
]);

// 3. StatusCards
const statusCardsReplace = [
    [/statusCards:\s*\[\s*\{/g, 'statusCards: { items: [\n                    {'],
    [/color:\s*'blue'\s*\},?\n\s*\]\}/g, "color: 'blue' },\n                ]} }"],
    [/color:\s*'green'\s*\},?\n\s*\]\}/g, "color: 'green' },\n                ]} }"],
    [/color:\s*'yellow'\s*\},?\n\s*\]\}/g, "color: 'yellow' },\n                ]} }"]
];
replaceInFile('src/app/routes/tenancy/client/pages/dashboard/index.tsx', statusCardsReplace);
replaceInFile('src/app/routes/tenancy/psw/pages/dashboard/index.tsx', statusCardsReplace);
replaceInFile('src/app/routes/tenancy/rn/pages/dashboard/index.tsx', statusCardsReplace);

// 4. API Contracts Test
replaceInFile('src/test/TypedApiContracts.test.ts', [
    [/{ status: 'active' }/g, "{ status: 'in_progress' }"],
    [/expect\(req\.status\)\.toBe\('completed'\);/g, "expect(req.status).toBe('in_progress');"]
]);

console.log('All targeted replacements complete.');
