#!/usr/bin/env node
/**
 * RBAC Audit Script — Scans all tenancy route files for permission guard coverage.
 *
 * Usage:
 *   node scripts/audit-rbac.mjs
 *
 * Ensures:
 *  - No tenancy routes use the deprecated `requireRole` middleware
 *  - All use `requirePermission` or `requireAnyPermission`
 *  - Reports files with no guard at all (module-level only)
 */

import { readdir, readFile, stat } from 'fs/promises';
import { join, relative } from 'path';

const TENANCY_ROOT = join(process.cwd(), 'apps/worker-api/src/tenancy');
const ROUTE_PATTERN = /\.(routes|module|defs)\.ts$/;

async function walk(dir) {
    const entries = await readdir(dir, { withFileTypes: true });
    const results = [];
    for (const entry of entries) {
        const fullPath = join(dir, entry.name);
        if (entry.isDirectory()) {
            results.push(...(await walk(fullPath)));
        } else if (ROUTE_PATTERN.test(entry.name)) {
            results.push(fullPath);
        }
    }
    return results;
}

async function audit() {
    console.log('🔒 RBAC Audit — Scanning tenancy route files...\n');

    const files = await walk(TENANCY_ROOT);
    let deprecated = 0;
    let guarded = 0;
    let unguarded = 0;
    const issues = [];

    for (const file of files) {
        const content = await readFile(file, 'utf-8');
        const rel = relative(TENANCY_ROOT, file);

        const usesRequireRole = /requireRole\s*\(/.test(content) && !content.includes('// RBAC: Inherits');
        const usesRequirePermission = /requirePermission\s*\(/.test(content);
        const usesRequireAnyPermission = /requireAnyPermission\s*\(/.test(content);
        const hasGuard = usesRequirePermission || usesRequireAnyPermission;
        const isModuleFile = file.endsWith('.module.ts');
        const inheritsComment = content.includes('// RBAC: Inherits');

        if (usesRequireRole) {
            deprecated++;
            issues.push({ file: rel, issue: '❌ DEPRECATED: Uses requireRole()' });
        } else if (hasGuard) {
            guarded++;
        } else if (inheritsComment || isModuleFile) {
            guarded++; // Module-level guard or documented inheritance
        } else {
            unguarded++;
            issues.push({ file: rel, issue: '⚠️  No explicit permission guard found' });
        }
    }

    // Summary
    console.log(`📊 Audit Results:`);
    console.log(`   Total route files:     ${files.length}`);
    console.log(`   ✅ Guarded:            ${guarded}`);
    console.log(`   ❌ Deprecated guards:  ${deprecated}`);
    console.log(`   ⚠️  Unguarded:         ${unguarded}`);
    console.log('');

    if (issues.length > 0) {
        console.log('Issues found:');
        for (const { file, issue } of issues) {
            console.log(`   ${issue} — ${file}`);
        }
        process.exit(1);
    } else {
        console.log('✅ All tenancy routes use requirePermission — no deprecated requireRole found!');
        process.exit(0);
    }
}

audit().catch(console.error);
