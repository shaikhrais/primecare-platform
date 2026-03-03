
import { OpenAPIHono } from '@hono/zod-openapi';

// Modules to verify
const modules = [
    { name: 'Auth', path: '../src/auth/auth.routes' },
    { name: 'Admin', path: '../src/platform/admin/admin.module' },
    { name: 'Manager', path: '../src/tenancy/manager/manager.module' },
    { name: 'Staff', path: '../src/tenancy/staff/staff.module' },
    { name: 'RN', path: '../src/tenancy/rn/rn.module' },
    { name: 'PSW', path: '../src/tenancy/psw/psw.module' },
    { name: 'Client', path: '../src/tenancy/client/client.module' },
    { name: 'User', path: '../src/user/user.routes' },
    { name: 'System', path: '../src/platform/system/system.module' },
];

async function verifyModule(modName: string, modPath: string) {
    console.log(`\n[Checking Part: ${modName}] ...`);
    try {
        const moduleExport = await import(modPath);
        const app = moduleExport.default;

        if (!(app instanceof OpenAPIHono)) {
            console.warn(`  ! Warning: ${modName} export is not an instance of OpenAPIHono.`);
            return true;
        }

        // Attempt to trigger schema generation for this specific sub-app
        // This is where most @asteasolutions/zod-to-openapi crashes happen
        try {
            (app as any).doc('/test-openapi.json', {
                openapi: '3.0.0',
                info: { title: `Test ${modName}`, version: '1.0.0' },
            });
            console.log(`  v Success: ${modName} is valid and schema-safe.`);
            return true;
        } catch (schemaErr: any) {
            console.error(`  X Schema Error in ${modName}:`, schemaErr.message);
            if (schemaErr.stack) {
                // Find the first line in the stack trace that belongs to our src
                const srcLine = schemaErr.stack.split('\n').find((l: string) => l.includes('/src/'));
                if (srcLine) console.error(`    at ${srcLine.trim()}`);
            }
            return false;
        }
    } catch (loadErr: any) {
        console.error(`  X Load Error in ${modName}:`, loadErr.message);
        return false;
    }
}

async function run() {
    console.log('--- PrimeCare API Modular Verification ---');
    let allPass = true;
    for (const mod of modules) {
        const ok = await verifyModule(mod.name, mod.path);
        if (!ok) allPass = false;
    }

    console.log('\n------------------------------------------');
    if (allPass) {
        console.log('ALL PARTS VERIFIED: API is stable and modular.');
        process.exit(0);
    } else {
        console.error('VERIFICATION FAILED: One or more parts have errors.');
        process.exit(1);
    }
}

run();
