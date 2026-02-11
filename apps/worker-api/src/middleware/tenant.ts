import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '../bindings';

export const tenantMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        const payload = c.get('jwtPayload');
        const role = payload?.role;
        const userId = payload?.sub;

        if (!userId) return c.json({ error: 'Unauthorized' }, 401);

        // Admins and Staff bypass tenant isolation
        if (role === 'admin' || role === 'staff' || role === 'manager') {
            await next();
            return;
        }

        // For Clients: Ensure they only access their own profile/data
        // This is a basic implementation; more complex logic would go here
        // or inside a Prisma Client Extension for global scoping.

        await next();
    });
};
