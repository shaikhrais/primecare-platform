import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '../../bindings';
import { tenantExtension } from '../prisma/tenant.extension';
import { auditExtension } from '../prisma/audit.extension';
import { forensicExtension } from '../prisma/forensic.extension';

let prismaInstance: any = null;

export const prismaMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        // Skip for OPTIONS
        if (c.req.method === 'OPTIONS') return await next();

        // Check if this is a light route BEFORE attempting Prisma WASM init
        // WASM import can exceed Cloudflare's CPU limit and kill the isolate
        const path = c.req.path;
        const isLightRoute = path.startsWith('/v1/public/') || path.startsWith('/v1/debug/') || path.startsWith('/v1/marketing/') || path === '/v1/health';

        if (!prismaInstance && isLightRoute) {
            // Don't load WASM for light routes — use fallback data
            c.set('prisma', null as any);
            c.set('can', async () => false);
            return await next();
        }

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
                console.error('[PRISMA_INIT_ERROR]', err.message);
                // DON'T throw — let route handlers handle null prisma gracefully
                // prismaInstance stays null, next request will retry init
            }
        }

        let reqPrisma = prismaInstance;
        if (!reqPrisma) {
            // Prisma failed to init — let route handler deal with null
            c.set('prisma', null as any);
            c.set('can', async () => false);
            return await next();
        }
        const payload = c.get('jwtPayload');
        const isSuperAdmin = payload?.roles?.includes('super_admin');
        let tenantId = payload?.tenantId || c.req.header('X-Tenant-ID');

        // Tenant Detection — skip for public/debug/auth routes (path/isLightRoute declared above)

        if (!tenantId && prismaInstance && !isLightRoute) {
            const host = c.req.header('Host') || '';
            const parts = host.split('.');
            if (parts.length >= 2 && !['www', 'api', 'admin', 'localhost', 'primecare-api'].includes(parts[0])) {
                const tenantSlug = parts[0];
                const tenant = await prismaInstance.tenant.findUnique({
                    where: { slug: tenantSlug },
                    select: { id: true }
                });
                if (tenant) tenantId = tenant.id;
            }
        }

        if (tenantId && !isSuperAdmin) {
            reqPrisma = reqPrisma.$extends(tenantExtension(tenantId as string));
        }

        // Skip heavy extensions for GET requests and light routes (avoids CPU timeout)
        // Forensic SHA-256 hashing is only relevant for mutations
        const isMutation = c.req.method !== 'GET' && c.req.method !== 'HEAD';
        if (!isLightRoute && isMutation) {
            const currentDeviceId = c.get('deviceId');
            const clientIp = c.req.header('CF-Connecting-IP') || '127.0.0.1';
            const actorUserId = payload?.sub;
            reqPrisma = reqPrisma.$extends(auditExtension(currentDeviceId));
            reqPrisma = reqPrisma.$extends(forensicExtension(actorUserId, currentDeviceId, clientIp));
        }

        c.set('prisma', reqPrisma);
        c.set('can', async () => (payload?.roles?.includes('admin') || payload?.roles?.includes('super_admin')) ?? false);

        return await next();
    });
};
