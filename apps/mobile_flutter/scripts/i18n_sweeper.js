const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');
const enArbPath = path.join(srcRoot, 'l10n', 'app_en.arb');
const frArbPath = path.join(srcRoot, 'l10n', 'app_fr.arb');

// 1. Load existing dictionaries to prevent overwrites
let enDict = {};
let frDict = {};
if (fs.existsSync(enArbPath)) enDict = JSON.parse(fs.readFileSync(enArbPath, 'utf8'));
if (fs.existsSync(frArbPath)) frDict = JSON.parse(fs.readFileSync(frArbPath, 'utf8'));

// Keys tracked to prevent collision
const activeKeys = new Set(Object.keys(enDict));

function generateKey(str) {
    let clean = str.replace(/[^a-zA-Z0-9]/g, ' ').trim().split(/\s+/);
    clean = clean.slice(0, 6); // Max 6 words for a key
    if (clean.length === 0 || clean[0] === '') return null;
    let key = clean.map((w, i) => i === 0 ? w.toLowerCase() : w.charAt(0).toUpperCase() + w.slice(1).toLowerCase()).join('');
    
    // Ensure uniqueness
    let finalKey = key;
    let counter = 2;
    while (activeKeys.has(finalKey) && enDict[finalKey] !== str) {
        finalKey = key + counter;
        counter++;
    }
    return finalKey;
}

let filesModified = 0;
let stringsExtracted = 0;

function sweep(dirPath) {
    if (!fs.existsSync(dirPath)) return;
    const files = fs.readdirSync(dirPath);

    for (const file of files) {
        const fullPath = path.join(dirPath, file);
        const stat = fs.statSync(fullPath);

        if (stat.isDirectory()) {
            sweep(fullPath);
        } else if (fullPath.endsWith('.dart') && !fullPath.includes('.g.dart') && !fullPath.includes('app_localizations') && !fullPath.includes('app_strings.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            let original = content;

            // Regex 1: PrimeCareText('Literal')
            const textRegex = /PrimeCareText\(\s*'([^'$]+)'\s*\)/g;
            content = content.replace(textRegex, (match, str) => {
                const key = generateKey(str);
                if (!key) return match;
                activeKeys.add(key);
                enDict[key] = str;
                frDict[key] = frDict[key] || `[FR] ${str}`;
                stringsExtracted++;
                return `PrimeCareText(AppLocalizations.of(context)!.${key})`;
            });

            // Regex 2: label: 'Literal'
            const labelRegex = /label:\s*'([^'$]+)'/g;
            content = content.replace(labelRegex, (match, str) => {
                const key = generateKey(str);
                if (!key) return match;
                activeKeys.add(key);
                enDict[key] = str;
                frDict[key] = frDict[key] || `[FR] ${str}`;
                stringsExtracted++;
                return `label: AppLocalizations.of(context)!.${key}`;
            });

            // Regex 3: title: const PrimeCareText('Literal') -> Needs deep unwrapping
            // Handled mostly by Regex 1 if const is removed or PrimeCareText is isolated, 
            // but let's do a generic one for `title: '...'` or `tooltip: '...'` or `hintText: '...'`
            const propertyRegex = /(title|tooltip|hintText|labelText):\s*'([^'$]+)'/g;
            content = content.replace(propertyRegex, (match, prop, str) => {
                const key = generateKey(str);
                if (!key) return match;
                activeKeys.add(key);
                enDict[key] = str;
                frDict[key] = frDict[key] || `[FR] ${str}`;
                stringsExtracted++;
                return `${prop}: AppLocalizations.of(context)!.${key}`;
            });

            if (content !== original) {
                // Remove stray 'const' caused by replacing a const PrimeCareText('...') with a dynamic context
                content = content.replace(/const PrimeCareText\(AppLocalizations/g, 'PrimeCareText(AppLocalizations');
                content = content.replace(/const\s+label:\s*AppLocalizations/g, 'label: AppLocalizations');
                
                if (!content.includes('package:flutter_gen/gen_l10n/app_localizations.dart')) {
                    content = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\n" + content;
                }
                fs.writeFileSync(fullPath, content, 'utf8');
                filesModified++;
            }
        }
    }
}

console.log('Deploying AST Localization Sweeper...');
sweep(srcRoot);

// Write Dictionaries back to arb
// Ensure valid json format (2 spaces)
fs.writeFileSync(enArbPath, JSON.stringify(enDict, null, 2), 'utf8');
fs.writeFileSync(frArbPath, JSON.stringify(frDict, null, 2), 'utf8');

console.log(`AST Sweep Complete. Modified ${filesModified} files.`);
console.log(`Extracted ${stringsExtracted} pure UI strings into the core Native Dictionary.`);
