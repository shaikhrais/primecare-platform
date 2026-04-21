import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '@primecare/contracts';
// import { tenantExtension } from '@primecare/database';
// import { auditExtension } from '@primecare/database';
// import { forensicExtension } from '@primecare/database';
import { PrismaClient } from '@primecare/database';
import { withAccelerate } from '@prisma/extension-accelerate';
// import { Pool } from 'pg';
// import { PrismaPg } from '@prisma/adapter-pg';

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

            try {
                let edgeUri = dbUrl;
                
                if (!edgeUri) {
                    throw new Error("CRITICAL STARTUP FAILURE: DATABASE_URL is utterly undefined in the Cloudflare Edge scope. Prisma cannot evaluate routing without an active secret key.");
                }

                if (edgeUri.includes('db.prisma.io') && edgeUri.startsWith('postgres://')) {
                    const urlObj = new URL(edgeUri);
                    const apiKey = urlObj.username ? `${urlObj.username}:${urlObj.password}` : urlObj.password;
                    edgeUri = `prisma://accelerate.prisma-data.net/?api_key=${apiKey}`;
                }

                if (edgeUri.startsWith('prisma://') || edgeUri.startsWith('prisma+postgres://')) {
                    const baseClient = new PrismaClient({ datasourceUrl: edgeUri });
                    prismaInstance = baseClient.$extends(withAccelerate());
                } else {
                    prismaInstance = new PrismaClient({ datasourceUrl: edgeUri }).$extends(withAccelerate());
                }
            } catch (err: any) {
                // We must store the error so we can return it if init fails
                c.set('prismaError' as any, err.message);
                console.error('[PRISMA_INIT_ERROR]', err.message);
                // DON'T throw — let route handlers handle null prisma gracefully OR fail here
            }
        }

        let reqPrisma = prismaInstance;
        if (!reqPrisma) {
            // Prisma failed to init. Passing null down into the route closure allows built-in dynamic Mock Synthesizers (Offline Testing) inside route catches to execute safely without hard-locking the entire Edge node.
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
            if (parts.length >= 2 && !['www', 'api', 'admin', 'localhost', 'primecare-api'].includes(parts[0]!)) {
                const tenantSlug = parts[0];
                let tenant = null;
                try {
                    tenant = await prismaInstance.tenant.findUnique({
                        where: { slug: tenantSlug },
                        select: { id: true }
                    });
                } catch (e: any /* Audit 63 Notice: Should be unknown */) {
                    console.error('[TENANT_SLUG_LOOKUP_ERROR]', e.message);
                }
                if (tenant) tenantId = tenant?.id;
            }
        }

        if (tenantId && !isSuperAdmin) {
            // reqPrisma = reqPrisma.$extends(tenantExtension(tenantId as string));
        }

        // Skip heavy extensions for GET requests and light routes (avoids CPU timeout)
        // Forensic SHA-256 hashing is only relevant for mutations
        const isMutation = c.req.method !== 'GET' && c.req.method !== 'HEAD';
        if (!isLightRoute && isMutation) {
            const currentDeviceId = c.get('deviceId');
            const clientIp = c.req.header('CF-Connecting-IP') || '127.0.0.1';
            const actorUserId = payload?.sub;
            // reqPrisma = reqPrisma.$extends(auditExtension(currentDeviceId));
            // reqPrisma = reqPrisma.$extends(forensicExtension(actorUserId, currentDeviceId, clientIp));
        }

        c.set('prisma', reqPrisma);
        c.set('can', async () => (payload?.roles?.includes('admin') || payload?.roles?.includes('super_admin')) ?? false);

        return await next();
    });
};
