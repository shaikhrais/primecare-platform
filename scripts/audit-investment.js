const fs = require('fs');
const path = require('path');

/**
 * Investment Audit Script (JS Version)
 * Measures the "mass" of each role's workspace.
 */

const ROUTES_DIR = path.join(__dirname, '../apps/web-admin/src/app/routes');

function auditRole(role) {
    const rolePath = path.join(ROUTES_DIR, role);
    if (!fs.existsSync(rolePath)) return null;

    const pagesPath = path.join(rolePath, 'pages');

    let pageCount = 0;
    if (fs.existsSync(pagesPath)) {
        const items = fs.readdirSync(pagesPath, { withFileTypes: true });
        // In the new structure, each page is a directory with an index.tsx
        pageCount = items.filter(d => d.isDirectory()).length;
    }

    return {
        'Role': role.toUpperCase(),
        'Pages': pageCount,
        'Has Sub-Router': fs.existsSync(path.join(rolePath, 'index.tsx')) ? '✅' : '❌'
    };
}

const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client'];
const report = roles.map(auditRole).filter(r => r !== null);

console.log('\n--- PrimeCare Role Investment Audit ---');
if (report.length > 0) {
    console.table(report);
} else {
    console.log('No roles migrated yet.');
}
console.log('---------------------------------------\n');
