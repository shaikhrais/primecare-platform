const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');
const enArbPath = path.join(srcRoot, 'l10n', 'app_en.arb');
const frArbPath = path.join(srcRoot, 'l10n', 'app_fr.arb');

if (fs.existsSync(enArbPath)) {
    let en = fs.readFileSync(enArbPath, 'utf8');
    en = en.replace(/"30DayVitalsTrend"/g, '"txt30DayVitalsTrend"');
    fs.writeFileSync(enArbPath, en, 'utf8');
}

if (fs.existsSync(frArbPath)) {
    let fr = fs.readFileSync(frArbPath, 'utf8');
    fr = fr.replace(/"30DayVitalsTrend"/g, '"txt30DayVitalsTrend"');
    fs.writeFileSync(frArbPath, fr, 'utf8');
}

function patchDart(dirPath) {
    if (!fs.existsSync(dirPath)) return;
    const files = fs.readdirSync(dirPath);
    for (const file of files) {
        const fullPath = path.join(dirPath, file);
        if (fs.statSync(fullPath).isDirectory()) {
            patchDart(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            if (content.includes('.30DayVitalsTrend')) {
                content = content.replace(/\.30DayVitalsTrend/g, '.txt30DayVitalsTrend');
                fs.writeFileSync(fullPath, content, 'utf8');
                console.log('Patched: ' + fullPath);
            }
        }
    }
}

patchDart(srcRoot);
console.log('Patch complete.');
