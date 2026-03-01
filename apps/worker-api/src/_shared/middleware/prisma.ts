import { createMiddleware } from 'hono/factory';

import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../../bindings';
import { tenantExtension } from '../prisma/tenant.extension';

let prismaInstance: any = null;

export const prismaMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        // Skip Prisma initialization for OPTIONS requests (CORS preflight)
        if (c.req.method === 'OPTIONS') {
            return await next();
        }

        if (!prismaInstance) {
            // Assume production/edge if DATABASE_URL doesn't look local or ENVIRONMENT is set
            const isProd = c.env.ENVIRONMENT === 'production' ||
                (c.env.DATABASE_URL && !c.env.DATABASE_URL.includes('localhost'));

            if (isProd) {
                const { PrismaClient } = await import('../../../generated/client/edge');
                prismaInstance = new PrismaClient({
                    datasourceUrl: c.env.DATABASE_URL,
                }).$extends(withAccelerate());
            } else {
                const { PrismaClient } = await import('@prisma/client');
                const pg = await import('pg');
                const { PrismaPg } = await import('@prisma/adapter-pg');

                const pool = new pg.default.Pool({ connectionString: c.env.DATABASE_URL });
                const adapter = new PrismaPg(pool);
                prismaInstance = new (PrismaClient as any)({ adapter });
            }
        }

        let reqPrisma = prismaInstance;
        const payload = c.get('jwtPayload');
        const roles = payload?.roles || [];
        const isSuperAdmin = roles.includes('super_admin');
        const apiKey = c.req.header('X-API-Key');
        let tenantId = payload?.tenantId || c.req.header('X-Tenant-ID');

        // 1. API Key Auth (High Priority)
        if (apiKey && !tenantId) {
            const keyRecord = await prismaInstance.apiKey.findUnique({
                where: { key: apiKey, status: 'active' },
                select: { tenantId: true, id: true }
            });
            if (keyRecord) {
                tenantId = keyRecord.tenantId;
                // Update last used time asynchronously
                prismaInstance.apiKey.update({
                    where: { id: keyRecord.id },
                    data: { lastUsedAt: new Date() }
                }).catch(() => { });
            }
        }

        // Host-based detection (for public pages or discovery-less login)
        if (!tenantId) {
            const host = c.req.header('Host') || '';
            const parts = host.split('.');
            // Logic: if host is {slug}.primecare.com or {slug}.localhost
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

        // Context helper for permission checks
        c.set('can', async (action: string, resource: string, resourceId?: string) => {
            const payload = c.get('jwtPayload');
            if (!payload) return false;
            return payload.roles.includes('admin') || payload.roles.includes('super_admin');
        });

        return await next();
    });
};

