import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '../../bindings';
import { tenantExtension } from '../prisma/tenant.extension';

let prismaInstance: any = null;

export const prismaMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        // Skip for OPTIONS
        if (c.req.method === 'OPTIONS') return await next();

        if (!prismaInstance) {
            const dbUrl = c.env.DATABASE_URL;
            const isAccelerate = dbUrl?.startsWith('prisma://');

            try {
                console.log('[PRISMA_INIT_START]', { isAccelerate, dbUrlPrefix: dbUrl?.substring(0, 15) });
                if (isAccelerate) {
                    // @ts-ignore
                    const mod = await import('../../../generated/client/edge');
                    const PrismaClient = mod.PrismaClient || (mod.default ? mod.default.PrismaClient : mod.default);
                    // @ts-ignore
                    const { withAccelerate } = await import('@prisma/extension-accelerate');
                    prismaInstance = new PrismaClient({ datasourceUrl: dbUrl }).$extends(withAccelerate());
                    console.log('[PRISMA_INIT_SUCCESS] Accelerate');
                } else {
                    // Production Cloudflare Worker / Local with postgres://
                    // @ts-ignore
                    const mod = await import('../../../generated/client/wasm.js');
                    const PrismaClient = mod.PrismaClient || (mod.default ? mod.default.PrismaClient : mod.default);
                    // @ts-ignore
                    const { PrismaPg } = await import('@prisma/adapter-pg');
                    // @ts-ignore
                    const pg = await import('pg');

                    const pgPool = pg.default ? new pg.default.Pool({ connectionString: dbUrl }) : new (pg as any).Pool({ connectionString: dbUrl });
                    const adapter = new PrismaPg(pgPool);
                    prismaInstance = new PrismaClient({ adapter });
                    console.log('[PRISMA_INIT_SUCCESS] Direct (WASM)');
                }
            } catch (err: any) {
                console.error('[PRISMA_INIT_ERROR]', err.message, err.stack);
                throw err;
            }
        }

        let reqPrisma = prismaInstance;
        const payload = c.get('jwtPayload');
        const isSuperAdmin = payload?.roles?.includes('super_admin');
        let tenantId = payload?.tenantId || c.req.header('X-Tenant-ID');

        // Tenant Detection
        if (!tenantId && prismaInstance) {
            const host = c.req.header('Host') || '';
            const parts = host.split('.');
            if (parts.length >= 2 && !['www', 'api', 'admin', 'localhost'].includes(parts[0])) {
                const tenantSlug = parts[0];
                const tenant = await prismaInstance.tenant.findUnique({
                    where: { slug: tenantSlug },
                    select: { id: true }
                });
                if (tenant) tenantId = tenant.id;
            }
        }

        if (tenantId && !isSuperAdmin) {
            reqPrisma = reqPrisma.$extends(tenantExtension(tenantId));
        }

        c.set('prisma', reqPrisma);
        c.set('can', async () => (payload?.roles?.includes('admin') || payload?.roles?.includes('super_admin')) ?? false);

        return await next();
    });
};
