import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '../../bindings';
import { tenantExtension } from '../prisma/tenant.extension';
import { auditExtension } from '../prisma/audit.extension';
import { forensicExtension } from '../prisma/forensic.extension';
import { PrismaClient } from '../../../generated/client';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';

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
                const pool = new Pool({ connectionString: dbUrl });
                const adapter = new PrismaPg(pool);
                prismaInstance = new PrismaClient({ adapter });
            } catch (err: any) {
                // We must store the error so we can return it if init fails
                c.set('prismaError' as any, err.message);
                console.error('[PRISMA_INIT_ERROR]', err.message);
                // DON'T throw — let route handlers handle null prisma gracefully OR fail here
            }
        }

        let reqPrisma = prismaInstance;
        if (!reqPrisma) {
            // Prisma failed to init — stop execution before it hits route logic and throws null reference errors
            const errorMessage = c.get('prismaError' as any) || 'Database connection failed';
            
            // R20: We can't rely on the route's error handler if we want to be safe globally
            // Let's return a 503 response immediately.
            const response = new Response(JSON.stringify({ 
                error: 'Database Service Unavailable', 
                message: errorMessage 
            }), {
                status: 503,
                headers: { 'Content-Type': 'application/json' }
            });
            c.res = response;
            return;
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
