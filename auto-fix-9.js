const fs = require('fs');
const path = require('path');

const pPath = path.join(__dirname, 'apps/web-admin/src/app/routes/platform.tsx');
let p = fs.readFileSync(pPath, 'utf8');

// Fix path depths
p = p.replace(/['"]\.\.\/\.\.\/\.\.\/shared\//g, "'@/shared/");

// Deduplicate apiClient
p = p.replace(/import\s*\{\s*apiClient\s*\}\s*from\s*['"][a-zA-Z0-9_.\/]+['"];?\n/g, "");
p = "import { apiClient } from '@/shared/utils/apiClient';\n" + p;

// Fix empty imports (the ones with just '' or "")
p = p.replace(/import\s*\{\s*[A-Za-z0-9_,\s]*\s*\}\s*from\s*['"]['"];?\n/g, "");
p = p.replace(/import\s+['"]['"];?\n/g, "");

// Fix strict type casting issue
p = p.replace(/status:\s*d\.status([,\s\}])/g, "status: d.status as 'CONNECTED' | 'DISCONNECTED' | 'EXPIRED'$1");

fs.writeFileSync(pPath, p);

const sPath = path.join(__dirname, 'apps/web-admin/src/app/routes/shared.tsx');
let s = fs.readFileSync(sPath, 'utf8');

// In shared.tsx, we have a duplicate TableColumn import versus a local TableColumn interface.
// Let's strip the import
s = s.replace(/import\s*\{\s*([^}]*?)TableColumn([^}]*)\s*\}\s*from\s*['"][^'"]+['"];?/g, function(match, p1, p2) {
    if (!p1.trim() && !p2.trim()) return ''; // It imported ONLY TableColumn
    return `import { ${p1.trim()} ${p2.trim()} } from '@/shared/components/sections';`.replace(/\s+/g, ' '); // Keep others
});
// Fallback brute strip if it's mixed:
s = s.replace(/TableColumn,\s*/g, '');
s = s.replace(/,\s*TableColumn/g, '');

fs.writeFileSync(sPath, s);

console.log("Applied final 9 surgical patches.");
