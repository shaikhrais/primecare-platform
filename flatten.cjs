const fs = require('fs');
const path = require('path');

const ROUTES_DIR = path.join(__dirname, 'apps/web-admin/src/app/routes');
const DOMAINS = ['auth', 'shared', 'tenancy', 'platform'];

function getAllFiles(dirPath, arrayOfFiles) {
    const files = fs.readdirSync(dirPath);
    arrayOfFiles = arrayOfFiles || [];
    files.forEach(function(file) {
        if (fs.statSync(dirPath + "/" + file).isDirectory()) {
            arrayOfFiles = getAllFiles(dirPath + "/" + file, arrayOfFiles);
        } else {
            if (file.endsWith('.ts') || file.endsWith('.tsx')) {
                arrayOfFiles.push(path.join(dirPath, file));
            }
        }
    });
    return arrayOfFiles;
}

function processDomain(domain) {
    console.log(`\n--- Flattening ${domain} ---`);
    const domainDir = path.join(ROUTES_DIR, domain);
    if (!fs.existsSync(domainDir)) return;

    const files = getAllFiles(domainDir);
    const imports = new Set();
    let body = '';

    files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        const lines = content.split('\n');
        
        body += `\n\n// --- Merged from ${path.basename(file)} ---\n`;
        
        let inImport = false;
        let currentImport = '';

        for (let i = 0; i < lines.length; i++) {
            let line = lines[i];
            
            // Basic import extraction
            if (line.trim().startsWith('import ') || inImport) {
                currentImport += line + '\n';
                if (line.includes(';') || line.includes('from') || (line.includes('}') && line.includes('from'))) {
                    inImport = false;
                    
                    // Process the complete import statement
                    let isInternal = false;
                    // Check if it imports something from the same domain
                    if (currentImport.includes("from './") || currentImport.includes("from \"./") ||
                        (domain === 'auth' && currentImport.includes("from '../auth")) ||
                        (domain === 'shared' && currentImport.includes("from '../shared"))) {
                        // It's internal to the domain being merged. Skip it.
                        isInternal = true;
                    }

                    if (!isInternal) {
                        // Fix relative paths to sibling domains
                        // e.g., in auth/login.tsx: from '../shared/error' -> from './shared'
                        let modifiedImport = currentImport;
                        DOMAINS.forEach(d => {
                            if (d !== domain) {
                                modifiedImport = modifiedImport.replace(new RegExp(`from\\s+['"]\\.\\.\\/${d}.*?['"]`), `from './${d}'`);
                                modifiedImport = modifiedImport.replace(new RegExp(`from\\s+['"]\\.\\/\\.\\.\\/${d}.*?['"]`), `from './${d}'`);
                            }
                        });
                        imports.add(modifiedImport.trim());
                    }
                    currentImport = '';
                } else {
                    inImport = true;
                }
                continue;
            }

            // Skip internal exports like `export * from './manager';`
            if (line.trim().startsWith('export * from') && (line.includes("from './") || line.includes("from \"./"))) {
                continue;
            }
            if (line.trim().startsWith('export { default } from')) {
                continue;
            }

            // Strip default exports to prevent multiple default exports in one file
            line = line.replace('export default function', 'export function');
            line = line.replace('export default class', 'export class');
            if (line.trim().startsWith('export default ')) continue;

            body += line + '\n';
        }
    });

    const finalContent = Array.from(imports).join('\n') + '\n\n' + body;
    fs.writeFileSync(path.join(ROUTES_DIR, `${domain}.tsx`), finalContent);
    console.log(`Created ${domain}.tsx (${finalContent.length} bytes)`);
}

DOMAINS.forEach(processDomain);

// Now update router.tsx imports
const routerPath = path.join(ROUTES_DIR, '../router.tsx');
let routerContent = fs.readFileSync(routerPath, 'utf8');

routerContent = routerContent.replace(/import\s+\{\s*([a-zA-Z0-9_,\s]+)\s*\}\s+from\s+['"]\.\/routes\/auth\/.*?['"]/g, "import { $1 } from './routes/auth'");
// Fix duplicates in router.tsx if multiple auth files were imported
routerContent = routerContent.replace(/import\s+\{\s*([a-zA-Z0-9_,\s]+)\s*\}\s+from\s+['"]\.\/routes\/auth['"]/g, "import { $1 } from './routes/auth';");

routerContent = routerContent.replace(/import\s+\{\s*([a-zA-Z0-9_,\s]+)\s*\}\s+from\s+['"]\.\/routes\/platform\/.*?['"]/g, "import { $1 } from './routes/platform'");
routerContent = routerContent.replace(/import\s+\{\s*([a-zA-Z0-9_,\s]+)\s*\}\s+from\s+['"]\.\/routes\/tenancy\/.*?['"]/g, "import { $1 } from './routes/tenancy'");

routerContent = routerContent.replace(/import\s*\(\s*['"]\.\/routes\/shared\/.*?['"]\s*\)/g, "import('./routes/shared')");
routerContent = routerContent.replace(/import\s*\(\s*['"]\.\/routes\/platform\/.*?['"]\s*\)/g, "import('./routes/platform')");

fs.writeFileSync(routerPath, routerContent);
console.log("Updated router.tsx");
