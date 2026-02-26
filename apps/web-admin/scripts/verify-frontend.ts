/**
 * verify-frontend.ts
 * 
 * Diagnostic tool for isolated frontend module verification.
 * Checks if major dashboard components and layouts are "loadable" 
 * by checking for syntax and basic type errors in their entry points.
 */

import { execSync } from 'child_process';
import path from 'path';
import fs from 'fs';

const BASE_PATH = path.join(process.cwd(), 'src');

const DASHBOARDS = [
    { name: 'Admin Dashboard', path: 'app/routes/admin/pages/dashboard/index.tsx' },
    { name: 'Manager Dashboard', path: 'app/routes/manager/pages/dashboard/index.tsx' },
    { name: 'PSW Dashboard', path: 'app/routes/psw/pages/dashboard/index.tsx' },
    { name: 'Client Dashboard', path: 'app/routes/client/pages/dashboard/index.tsx' },
    { name: 'Staff Dashboard', path: 'app/routes/staff/index.tsx' },
];

const PAGES = [
    { name: 'Earnings Center', path: 'app/routes/admin/pages/earnings/index.tsx' },
    { name: 'Schedule Central', path: 'app/routes/admin/pages/schedule/index.tsx' },
    { name: 'User Management', path: 'app/routes/admin/pages/users/index.tsx' },
    { name: 'Admission flow', path: 'app/routes/admin/pages/admission/index.tsx' },
];

const SHARED = [
    { name: 'Layouts', path: 'shared/components/layout/AdminLayout.tsx' },
    { name: 'Modals (Create Visit)', path: 'shared/components/modals/CreateVisitModal.tsx' },
    { name: 'Notification Context', path: 'shared/context/NotificationContext.tsx' },
];

async function verifyModule(name: string, relPath: string) {
    const fullPath = path.join(BASE_PATH, relPath);
    console.log(`\n🔍 Verifying [${name}] at: ${relPath}`);

    if (!fs.existsSync(fullPath)) {
        console.error(`❌ ERROR: File not found: ${relPath}`);
        return false;
    }

    try {
        // Use the project's tsconfig to ensure all aliases and settings are respected
        const cmd = `npx tsc --project tsconfig.json --noEmit --skipLibCheck`;

        execSync(cmd, { stdio: 'pipe' });
        console.log(`✅ [${name}] verified successfully!`);
        return true;
    } catch (error: any) {
        const output = error.stdout?.toString() || error.message;
        const normalizedRelPath = relPath.replace(/\//g, path.sep);
        const relevantErrors = output.split('\n').filter((line: string) => line.includes(normalizedRelPath));

        if (relevantErrors.length > 0) {
            console.error(`❌ [${name}] verification FAILED:`);
            console.error(relevantErrors.slice(0, 5).join('\n'));
            return false;
        } else {
            console.log(`✅ [${name}] verified (found global project errors but none in this module).`);
            return true;
        }
    }
}

async function run() {
    console.log('🚀 Starting Frontend Part-Based Verification...\n');

    let allPassed = true;

    console.log('--- DASHBOARDS ---');
    for (const dash of DASHBOARDS) {
        const passed = await verifyModule(dash.name, dash.path);
        if (!passed) allPassed = false;
    }

    console.log('\n--- CORE PAGES ---');
    for (const page of PAGES) {
        const passed = await verifyModule(page.name, page.path);
        if (!passed) allPassed = false;
    }

    console.log('\n--- SHARED & CONTEXT ---');
    for (const item of SHARED) {
        const passed = await verifyModule(item.name, item.path);
        if (!passed) allPassed = false;
    }

    console.log('\n-----------------------------------');
    if (allPassed) {
        console.log('✨ ALL FRONTEND PARTS VERIFIED! ✨');
        process.exit(0);
    } else {
        console.error('💥 SOME PARTS FAILED VERIFICATION 💥');
        process.exit(1);
    }
}

run().catch(err => {
    console.error('Fatal error during verification:', err);
    process.exit(1);
});
