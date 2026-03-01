const fs = require('fs');
const path = require('path');

const mappings = {
    "'/psw/schedule'": 'AdminRegistry.RouteRegistry.PSW.SCHEDULE',
    "'/psw/dashboard'": 'AdminRegistry.RouteRegistry.PSW.DASHBOARD',
    "'/admin/dashboard'": 'AdminRegistry.RouteRegistry.DASHBOARD',
    "'/manager/dashboard'": 'AdminRegistry.RouteRegistry.MANAGER.DASHBOARD',
    "'/client/dashboard'": 'AdminRegistry.RouteRegistry.CLIENT.DASHBOARD',
    "'/staff/dashboard'": 'AdminRegistry.RouteRegistry.STAFF.DASHBOARD',
    "'/rn/dashboard'": 'AdminRegistry.RouteRegistry.RN.DASHBOARD',
    "'/support/manual'": 'AdminRegistry.RouteRegistry.SUPPORT',
    "'/earnings'": "AdminRegistry.RouteRegistry.EARNINGS",
    "'/bookings'": 'AdminRegistry.RouteRegistry.CLIENT.BOOKINGS',
    "'/admin/clients/admission'": 'AdminRegistry.RouteRegistry.ADMISSION',
    "'/admin/customers'": 'AdminRegistry.RouteRegistry.USERS',
    "'/admin/users'": 'AdminRegistry.RouteRegistry.USERS',
    "'/roles/new'": 'AdminRegistry.RouteRegistry.USERS_NEW',
    "'/timesheets'": 'AdminRegistry.RouteRegistry.TIMESHEETS',
    "'/timesheets/adjust'": 'AdminRegistry.RouteRegistry.TIMESHEET_ADJUST',
    "'/templates'": 'AdminRegistry.RouteRegistry.CONTENT',
    "'/roles'": 'AdminRegistry.RouteRegistry.USERS',
    "'/admin/knowledge-base'": 'AdminRegistry.RouteRegistry.SUPPORT',
    "'/login'": 'AdminRegistry.RouteRegistry.LOGIN'
};

const importStatement = `import { AdminRegistry } from 'prime-care-shared';\n`;

function processFile(filePath) {
    let content = fs.readFileSync(filePath, 'utf8');
    let modified = false;

    // Check if any mapping keys exist in the file
    for (const [literal, registry] of Object.entries(mappings)) {
        const toPattern = new RegExp(`to=${literal.replace(/'/g, '"')}`, 'g');
        const navigatePattern = new RegExp(`navigate\\(${literal}\\)`, 'g');

        if (content.match(toPattern)) {
            content = content.replace(toPattern, `to={${registry}}`);
            modified = true;
        }

        if (content.match(navigatePattern)) {
            content = content.replace(navigatePattern, `navigate(${registry})`);
            modified = true;
        }
    }

    if (modified) {
        // Inject import if not exists
        if (!content.includes('prime-care-shared') && !content.includes('AdminRegistry')) {
            const importMatch = content.match(/import.*?;/g);
            if (importMatch && importMatch.length > 0) {
                const lastImport = importMatch[importMatch.length - 1];
                content = content.replace(lastImport, `${lastImport}\n${importStatement}`);
            } else {
                content = importStatement + content;
            }
        } else if (!content.includes('AdminRegistry')) {
            content = content.replace(/import\s+{([^}]+)}\s+from\s+['"]prime-care-shared['"];/, "import { $1, AdminRegistry } from 'prime-care-shared';");
        }

        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated: ${filePath}`);
    }
}

function processDirectory(directory) {
    const files = fs.readdirSync(directory);
    for (const file of files) {
        const fullPath = path.join(directory, file);
        if (fs.statSync(fullPath).isDirectory()) {
            processDirectory(fullPath);
        } else if (fullPath.endsWith('.tsx') || fullPath.endsWith('.ts')) {
            processFile(fullPath);
        }
    }
}

processDirectory(path.join(__dirname, 'src/app/routes'));
console.log('Mass URL Refactoring Complete');
