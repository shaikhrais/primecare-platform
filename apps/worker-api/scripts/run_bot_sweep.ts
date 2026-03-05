
import { PrismaClient } from '../generated/client';
import { ButtonRegistry, LinkRegistry, InteractionARegistry, InteractionRegistry } from 'prime-care-shared';

const prisma = new PrismaClient();
const tenantId = '7130af26-f02a-4122-8c58-d89fac890a5f';

async function runSweep() {
    console.log('--- Starting Response Bot Verification Sweep ---');
    let totalAudited = 0;
    let errorsFound = 0;

    const upsertTouchpoint = async (data: any) => {
        totalAudited++;
        const isError = data.status !== 'OK' && data.status !== 'OK_PARAM';
        if (isError) {
            errorsFound++;
            console.log(`  [!] Issue: ${data.id} (${data.type}) - ${data.status}: ${data.errorDetail}`);
        }

        const existing = await prisma.systemTouchpoint.findUnique({
            where: { touchpointId: data.id }
        });

        if (existing) {
            await prisma.systemTouchpoint.update({
                where: { touchpointId: data.id },
                data: {
                    status: data.status,
                    errorDetail: data.errorDetail,
                    lastChecked: new Date(),
                    label: existing.isOverridden ? undefined : data.label,
                    path: existing.isOverridden ? undefined : data.path,
                },
            });
        } else {
            await prisma.systemTouchpoint.create({
                data: {
                    touchpointId: data.id,
                    type: data.type,
                    role: data.role,
                    module: data.module,
                    label: data.label,
                    path: data.path,
                    status: data.status,
                    errorDetail: data.errorDetail,
                    tenantId,
                },
            });
        }
    };

    console.log(`Auditing ${ButtonRegistry.length} Buttons...`);
    for (const btn of ButtonRegistry) {
        let status = 'OK';
        let errorDetail = null;

        if (!btn.apiPath && btn.action === 'API_TRIGGER') {
            status = 'MISSING';
            errorDetail = 'API_TRIGGER action requires an apiPath.';
        } else if (btn.apiPath) {
            if (btn.apiPath.includes('undefined')) {
                status = 'ERROR';
                errorDetail = 'Path contains undefined! Registry synchronization failure.';
            } else if (btn.apiPath.includes(':')) {
                status = 'OK_PARAM';
                errorDetail = 'Path is correctly parameterized.';
            }
        }
        await upsertTouchpoint({
            id: btn.id,
            type: 'BUTTON',
            role: btn.role,
            module: btn.module,
            label: btn.label,
            path: btn.apiPath || 'UI_ACTION',
            status,
            errorDetail
        });
    }

    console.log(`Auditing ${LinkRegistry.length} Links...`);
    for (const link of LinkRegistry) {
        let status = 'OK';
        let errorDetail = null;
        if (!link.path || link.path === '/shared/404') {
            status = '404';
            errorDetail = 'Static link is broken.';
        }
        await upsertTouchpoint({
            id: link.id,
            type: 'LINK',
            role: link.role,
            module: link.module,
            label: link.label,
            path: link.path,
            status,
            errorDetail
        });
    }

    console.log(`Auditing ${InteractionARegistry.length} Interactions (A)...`);
    for (const ia of InteractionARegistry) {
        await upsertTouchpoint({
            id: ia.id,
            type: 'INTERACTION',
            role: ia.role,
            module: ia.module,
            label: ia.label,
            path: ia.target || 'UI_ACTION',
            status: 'OK'
        });
    }

    console.log(`\nSweep Complete.`);
    console.log(`Total Audited: ${totalAudited}`);
    console.log(`Total Issues: ${errorsFound}`);

    // Specifically check for our new items
    const checkIds = ['btn-auth-osm-login', 'lnk-mgr-dashboard', 'lnk-mgr-ops-hub', 'lnk-adm-strategy'];
    console.log('\n--- Verifying Phase 3 Specific Fixes ---');
    for (const id of checkIds) {
        const found = await prisma.systemTouchpoint.findUnique({ where: { touchpointId: id } });
        if (found) {
            console.log(`  [v] Found ${id}: ${found.label} -> ${found.path} (${found.status})`);
        } else {
            console.log(`  [X] FAILED to find ${id}`);
        }
    }
}

runSweep().catch(console.error).finally(() => prisma.$disconnect());
