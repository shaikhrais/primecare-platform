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
        await next();
    });
};
