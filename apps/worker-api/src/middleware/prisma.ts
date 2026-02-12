import { createMiddleware } from 'hono/factory';
import { PrismaClient } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';

let prismaInstance: any = null;

export const prismaMiddleware = () => {
    return createMiddleware(async (c, next) => {
        if (!prismaInstance) {
            prismaInstance = new PrismaClient({
                datasourceUrl: c.env.DATABASE_URL,
            }).$extends(withAccelerate());
        }

        c.set('prisma', prismaInstance);

        // Mock 'can' function for now, or link to policy engine
        c.set('can', async (action: string, resource: string, resourceId?: string) => {
            const payload = c.get('jwtPayload');
            if (!payload) return false;
            // Basic role check or call policies
            return payload.roles.includes('admin');
        });

        await next();
    });
};
