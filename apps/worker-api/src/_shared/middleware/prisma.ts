import { createMiddleware } from 'hono/factory';
import { PrismaClient } from '../../../generated/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../../bindings';

let prismaInstance: any = null;

export const prismaMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        if (!prismaInstance) {
            const isProd = c.env.ENVIRONMENT === 'production';

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
                prismaInstance = new PrismaClient({ adapter });
            }
        }

        c.set('prisma', prismaInstance);

        // Context helper for permission checks
        c.set('can', async (action: string, resource: string, resourceId?: string) => {
            const payload = c.get('jwtPayload');
            if (!payload) return false;
            return payload.roles.includes('admin');
        });

        return await next();
    });
};
