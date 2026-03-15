#!/usr/bin/env node
/**
 * ╔═══════════════════════════════════════════════════════════════════╗
 * ║  PrimeCare A11y Hardening — Batch Script                        ║
 * ║  Adds role="main" + aria-label to every page's container div.   ║
 * ║  Reads MASTER_REGISTRY for page labels.                         ║
 * ╚═══════════════════════════════════════════════════════════════════╝
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const ROOT = path.resolve(__dirname, '..');

// ── Parse MASTER_REGISTRY ─────────────────────────────────────────────
function parseMasterRegistry() {
    const registryPath = path.resolve(ROOT, '../../packages/shared/src/registries/PageRegistry/master-registry.ts');
    const content = fs.readFileSync(registryPath, 'utf-8');
    const entries = {};
    const regex = /^\s*(\w+):\s*\{\s*file:\s*'([^']+)',\s*label:\s*'([^']+)',\s*type:\s*'([^']+)',\s*owner:\s*'([^']+)',\s*associates:\s*\[([^\]]*)\]/gm;
    let match;
    while ((match = regex.exec(content)) !== null) {
        const [, code, file, label, type, owner] = match;
        entries[code] = { file, label, type, owner };
    }
    return entries;
}

const REGISTRY = parseMasterRegistry();
const entries = Object.entries(REGISTRY);
console.log(`📦 Parsed ${entries.length} MASTER_REGISTRY entries`);

let modified = 0;
let skipped = 0;
let notFound = 0;

for (const [code, entry] of entries) {
    const absPath = path.resolve(ROOT, '../../', entry.file);

    if (!fs.existsSync(absPath)) {
        console.warn(`  ⚠️  ${code}: File not found — ${entry.file}`);
        notFound++;
        continue;
    }

    let content = fs.readFileSync(absPath, 'utf-8');

    // Already has role="main" → skip
    if (content.includes('role="main"')) {
        skipped++;
        continue;
    }

    // Strategy 1: page has data-cy="page.container" — add role + aria-label to that element
    if (content.includes('data-cy="page.container"')) {
        content = content.replace(
            'data-cy="page.container"',
            `data-cy="page.container" role="main" aria-label="${entry.label}"`
        );
        fs.writeFileSync(absPath, content, 'utf-8');
        modified++;
        continue;
    }

    // Strategy 2: page has a return/JSX with an outer div — add page.container + a11y to first div
    // Find the pattern: return ( followed by <div (with optional whitespace)
    const returnDivRegex = /return\s*\(\s*\n?\s*<div(?=[\s>])/;
    if (returnDivRegex.test(content)) {
        content = content.replace(
            returnDivRegex,
            (match) => {
                // Add data-cy, role, and aria-label to this first div
                return match.replace('<div', `<div data-cy="page.container" role="main" aria-label="${entry.label}"`);
            }
        );
        fs.writeFileSync(absPath, content, 'utf-8');
        modified++;
        continue;
    }

    // Strategy 3: Fragment wrapper — find the first <> and wrap or find first <div inside
    // This handles cases like: return (<> <div ...
    const fragmentDivRegex = /return\s*\(\s*\n?\s*<>\s*\n?\s*<div(?=[\s>])/;
    if (fragmentDivRegex.test(content)) {
        content = content.replace(
            fragmentDivRegex,
            (match) => {
                return match.replace(/<div(?=[\s>])/, `<div data-cy="page.container" role="main" aria-label="${entry.label}"`);
            }
        );
        fs.writeFileSync(absPath, content, 'utf-8');
        modified++;
        continue;
    }

    console.warn(`  ⚠️  ${code}: Could not find suitable injection point — ${entry.file}`);
    skipped++;
}

console.log(`\n════════════════════════════════════════════════`);
console.log(`✅ Modified: ${modified} pages`);
console.log(`⏭️  Skipped (already had role="main"): ${skipped}`);
console.log(`⚠️  Not found: ${notFound}`);
console.log(`📊 Total: ${entries.length}`);
console.log(`════════════════════════════════════════════════\n`);
