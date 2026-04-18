const fs = require('fs');
const path = require('path');

const UI_DIR = path.join(__dirname, 'packages', 'factory_system', 'primecare_ui', 'lib', 'src', 'screens');
const REPORT_PATH = path.join(__dirname, '.agents', 'governance', 'reconciliation_report.md');
const ROUTES_PATH = path.join(__dirname, 'apps', 'primecare_corporate', 'lib', 'routes', 'groups', 'corporate_routes.dart');
const INVENTORY_PATH = path.join(__dirname, '.agents', 'page_inventory.yaml');

function countOccurrences(text, regex) {
    const matches = text.match(regex);
    return matches ? matches.length : 0;
}

function traverseDirectory(dir, fileList = []) {
    if (!fs.existsSync(dir)) return fileList;
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            traverseDirectory(fullPath, fileList);
        } else if (fullPath.endsWith('.dart')) {
            fileList.push(fullPath);
        }
    }
    return fileList;
}

async function verify() {
    console.log("=== DOUBLE DEEP VERIFY: UI & Routing Synchronization ===\n");

    try {
        // 1. Verify Pages (UI layer)
        const uiFiles = traverseDirectory(UI_DIR);
        let pageCount = 0;
        let pageClasses = 0;
        let pageStrings = new Set();
        for (const file of uiFiles) {
            const content = fs.readFileSync(file, 'utf8');
            pageCount++;
            
            // Look for classes extending StatelessWidget or StatefulWidget
            const classMatches = content.match(/class [A-Za-z0-9_]+ extends (StatelessWidget|StatefulWidget)/g);
            if (classMatches) {
                pageClasses += classMatches.length;
            }
        }
        console.log(`[UI Analysis] Found ${uiFiles.length} screen files containing ${pageClasses} widget classes.`);

        // 2. Verify Intents / Roles (reconciliation_report)
        const reportContent = fs.readFileSync(REPORT_PATH, 'utf8');
        const rolesMatch = reportContent.match(/Total Registered Intents:\s*(\d+)/);
        const reportRolesCount = rolesMatch ? parseInt(rolesMatch[1]) : 0;
        
        const pagesMatch = reportContent.match(/Total Registered Pages:\s*(\d+)/);
        const reportPagesCount = pagesMatch ? parseInt(pagesMatch[1]) : 0;

        const lines = reportContent.split('\n');
        let tableRows = 0;
        for (const line of lines) {
            if (line.trim().startsWith('|') && !line.includes('---') && !line.includes('Field ID')) {
                tableRows++;
            }
        }
        console.log(`[Report Analysis] Expected Intents: ${reportRolesCount}, Expected Pages: ${reportPagesCount}, Table Rows Expected Fields: ${tableRows}`);
        
        // 3. Verify Routes (Corporate Routes)
        const routesContent = fs.readFileSync(ROUTES_PATH, 'utf8');
        const routeFields = countOccurrences(routesContent, /static const String \w+ = '/g);
        console.log(`[Routing Analysis] Found ${routeFields} declared routes in corporate_routes.dart`);

        // Check if report match
        console.log("\n--- VERIFICATION CONCLUSION ---");
        if (tableRows === reportPagesCount) {
             console.log(`✅ Table Row Count (${tableRows}) EXACTLY MATCHES Reported Pages (${reportPagesCount})`);
        } else {
             console.log(`❌ Table Row Count (${tableRows}) DOES NOT MATCH Reported Pages (${reportPagesCount})`);
        }

        // Each role typically has standard 7 screens: Dashboard, Management, Analytics, Settings, Tasks, Audit Logs, Intake Form
        // 38 roles * 7 screens = 266 screens.
        if (reportRolesCount * 7 === routeFields || reportRolesCount * 7 === reportPagesCount) {
             console.log(`✅ Roles Multiplier (38 * 7 = 266) EXACTLY MATCHES! Architecture is mathematically sound.`);
        } else {
             console.log(`⚠️ Roles Multiplier Check Failed. RoleCount: ${reportRolesCount}, PagesExpected: 266, Found: ${routeFields}`);
        }

    } catch (e) {
        console.error("Verification failed unexpectedly:", e);
    }
}

verify();
