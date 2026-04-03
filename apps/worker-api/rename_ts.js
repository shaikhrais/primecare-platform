const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, 'src');

function walkSync(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ? walkSync(dirPath, callback) : callback(path.join(dir, f));
    });
}

let filesUpdated = 0;

walkSync(srcDir, (filePath) => {
    if (!filePath.endsWith('.ts')) return;

    let original = fs.readFileSync(filePath, 'utf8');
    let content = original;

    // TypeScript/Prisma mapping variable replacements
    content = content.replace(/pswProfile/g, 'providerProfile');
    content = content.replace(/PswProfile/g, 'ProviderProfile');
    content = content.replace(/assignedPswId/g, 'assignedProviderId');
    content = content.replace(/pswId/g, 'providerId');
    content = content.replace(/PswDocument/g, 'ProviderDocument');
    content = content.replace(/PswAvailability/g, 'ProviderAvailability');
    content = content.replace(/pswVitals/g, 'providerVitals');
    content = content.replace(/PswVitalSign/g, 'ProviderVitalSign');
    content = content.replace(/PswShiftLog/g, 'ProviderShiftLog');
    
    // Note: Do NOT blindly replace "psw" -> "provider" everywhere as it might break URLs
    // e.g. /psw/dashboard needs to stay for now, or if it changes we handle routing later.
    // However, Prisma variable bindings like req.param('pswId') are caught by the pswId replace.

    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        filesUpdated++;
    }
});

console.log(`Updated ${filesUpdated} TypeScript files with Unified Provider variable references.`);
