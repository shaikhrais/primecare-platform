const fs = require('fs');
const path = require('path');

const servicesDir = path.join(process.cwd(), 'services');
fs.readdirSync(servicesDir).forEach(dirName => {
    const dirPath = path.join(servicesDir, dirName);
    if (!fs.statSync(dirPath).isDirectory()) return;

    const pkgJsonPath = path.join(dirPath, 'package.json');
    if (fs.existsSync(pkgJsonPath)) {
        try {
            const json = JSON.parse(fs.readFileSync(pkgJsonPath, 'utf8'));
            if (json.name && json.name.endsWith('-service')) {
                json.name = json.name.replace('-service', '-api');
                fs.writeFileSync(pkgJsonPath, JSON.stringify(json, null, 2) + '\n');
                console.log(`Updated ${pkgJsonPath} to ${json.name}`);
            }
        } catch (e) {
            console.error(`Error updating ${pkgJsonPath}:`, e);
        }
    }
    
    // Also rename any internal dependencies they might have on each other (unlikely but possible)
});

// Update governance_api pubspec.yaml
const pubspecPath = path.join(process.cwd(), 'services', 'governance_api', 'pubspec.yaml');
if (fs.existsSync(pubspecPath)) {
    let pubspec = fs.readFileSync(pubspecPath, 'utf8');
    pubspec = pubspec.replace('name: governance_service', 'name: governance_api');
    fs.writeFileSync(pubspecPath, pubspec);
    console.log(`Updated ${pubspecPath}`);
}
