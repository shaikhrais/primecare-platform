import fs from 'fs';
import path from 'path';

const directory = 'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/mobile_flutter/lib';

function walkDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            walkDir(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            let modified = false;

            if (content.includes('AppColors.')) {
                content = content
                    .replace(/AppColors\.background/g, 'Colors.white')
                    .replace(/AppColors\.primary/g, 'Colors.blue')
                    .replace(/AppColors\.success/g, 'Colors.green')
                    .replace(/AppColors\.warning/g, 'Colors.orange')
                    .replace(/AppColors\.error/g, 'Colors.red')
                    .replace(/AppColors\.textPrimary/g, 'Colors.black87')
                    .replace(/AppColors\.textSecondary/g, 'Colors.grey');
                
                // Remove the incorrect import that broke things
                content = content.replace(/import '\.\.\/\.\.\/core\/theme\/app_colors\.dart';\r?\n?/g, '');
                content = content.replace(/import '\.\.\/\.\.\/core\/theme\/colors\.dart';\r?\n?/g, '');
                
                modified = true;
            }

            if (modified) {
                fs.writeFileSync(fullPath, content);
                console.log(`Patched: \${fullPath}`);
            }
        }
    }
}

walkDir(directory);
console.log("Global Material substitution complete!");
