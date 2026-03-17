import fs from 'fs';
import path from 'path';

const srcDir = path.join(process.cwd(), 'apps/web-admin/src');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        if (fs.statSync(dirPath).isDirectory()) {
            walkDir(dirPath, callback);
        } else if (f.endsWith('.ts') || f.endsWith('.tsx')) {
            callback(dirPath);
        }
    });
}

function fixImports() {
    let fixCount = 0;
    walkDir(srcDir, (filePath) => {
        let content = fs.readFileSync(filePath, 'utf8');
        let hasChanges = false;
        
        const importRegex = /(import\s+.*?from\s+['"])([^'"]+)(['"];?)/g;
        const dynamicImportRegex = /(import\s*\(\s*['"])([^'"]+)(['"]\s*\))/g;
        
        function replacer(match, p1, importPath, p3) {
            if (!importPath.startsWith('.') && !importPath.startsWith('@/')) return match;
            
            let absoluteImportPath = importPath;
            if (importPath.startsWith('@/')) {
                absoluteImportPath = importPath.replace('@/', path.join(srcDir, '/') ).replace(/\\/g, '/');
            } else {
                absoluteImportPath = path.resolve(path.dirname(filePath), importPath).replace(/\\/g, '/');
            }
            
            if (!fs.existsSync(absoluteImportPath) && !fs.existsSync(absoluteImportPath + '.tsx') && !fs.existsSync(absoluteImportPath + '.ts') && !fs.existsSync(absoluteImportPath + '.d.ts')) {
                const parentDir = path.dirname(absoluteImportPath);
                if (fs.existsSync(path.join(parentDir, 'index.tsx')) || fs.existsSync(path.join(parentDir, 'index.ts'))) {
                    let newImportPath = importPath.split('/').slice(0, -1).join('/');
                    if (newImportPath === '') newImportPath = '.';
                    // Since the file is already an index, we just point to the folder.
                    console.log(`Fixing import in ${path.basename(filePath)}: ${importPath} -> ${newImportPath}`);
                    hasChanges = true;
                    fixCount++;
                    return p1 + newImportPath + p3;
                }
            }
            return match;
        }

        content = content.replace(importRegex, replacer);
        content = content.replace(dynamicImportRegex, replacer);
        
        // Fix TS error: "suffix" does not exist
        if (content.includes('suffix:')) {
            const newContent = content.replace(/suffix:\s*['"][^'"]*['"]\s*,?/g, '');
            if (newContent !== content) {
                content = newContent;
                hasChanges = true;
            }
        }
        
        // Fix TS error: Property 'id' is missing in MapMarker
        if (content.match(/\{[^}]*lat:\s*[-0-9.]+,\s*lng:\s*[-0-9.]+/g)) {
            let i = 1;
            const newContent = content.replace(/(\{[^}]*)(lat:\s*[-0-9.]+,\s*lng:\s*[-0-9.]+)/g, (match, p1, p2) => {
                if (p1.includes('id:')) return match;
                return p1 + `id: 'm${i++}', ` + p2;
            });
            if (newContent !== content) {
                content = newContent;
                hasChanges = true;
            }
        }
        
        // Fix TS error: Type '"alert"' is not assignable... / "completed" not assignable
        // The allowed statuses are 'active' | 'inactive' | 'danger' | 'warning'
        if (content.includes("status: 'completed'")) {
            content = content.replace(/status:\s*'completed'/g, "status: 'active'");
            hasChanges = true;
        }
        if (content.includes("status: 'alert'")) {
            content = content.replace(/status:\s*'alert'/g, "status: 'danger'");
            hasChanges = true;
        }
        if (content.includes('status: "completed"')) {
            content = content.replace(/status:\s*"completed"/g, 'status: "active"');
            hasChanges = true;
        }
        if (content.includes('status: "alert"')) {
            content = content.replace(/status:\s*"alert"/g, 'status: "danger"');
            hasChanges = true;
        }

        if (hasChanges) {
            fs.writeFileSync(filePath, content, 'utf8');
        }
    });
    console.log(`Fixed ${fixCount} imports.`);
}

fixImports();
