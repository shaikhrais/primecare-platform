import { createMiddleware } from 'hono/factory';
import { PrismaClient } from '../../../generated/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../../bindings';

let prismaInstance: any = null;

export const prismaMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        if (!prismaInstance) {
            prismaInstance = new PrismaClient({
                datasourceUrl: c.env.DATABASE_URL,
            }).$extends(withAccelerate());
        }

        c.set('prisma', prismaInstance);

        // Context helper for permission checks
        c.set('can' as any, async (action: string, resource: string, resourceId?: string) => {
            const payload = c.get('jwtPayload');
            if (!payload) return false;
            return payload.roles.includes('admin');
        });

        await next();
    });
};
