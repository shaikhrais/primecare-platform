import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '../bindings';

export type Action = 'read' | 'update' | 'delete' | 'create';
export type Resource = 'Visit' | 'User' | 'ClientProfile' | 'PswProfile' | 'Invoice' | 'Incident' | 'Timesheet';

export interface PolicyContext {
    userId: string;
    roles: string[];
    tenantId: string;
    prisma: any;
}

export const policyMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        const payload = c.get('jwtPayload');
        const prisma = c.get('prisma');

        if (!payload) return c.json({ error: 'Unauthorized' }, 401);

        const ctx: PolicyContext = {
            userId: payload.sub,
            roles: payload.roles,
            tenantId: payload.tenantId,
            prisma
        };

        const can = async (action: Action, resource: Resource, resourceId?: string) => {
            // Admins bypass policy checks (Global override)
            if (ctx.roles.includes('admin') || ctx.roles.includes('staff')) return true;

            switch (resource) {
                case 'User':
                    if (resourceId === ctx.userId) return true;
                    // Only admins can update other users' roles (handled by admin bypass above, 
                    // but we can be explicit if needed)
                    break;

                case 'ClientProfile':
                    const client = await prisma.clientProfile.findUnique({ where: { userId: ctx.userId } });
                    if (client && (resourceId === client.id || !resourceId)) return true;
                    break;

                case 'PswProfile':
                    const psw = await prisma.pswProfile.findUnique({ where: { userId: ctx.userId } });
                    if (psw && (resourceId === psw.id || !resourceId)) return true;
                    break;

                case 'Visit':
                    if (!resourceId) return true; // List view handled by tenant middleware
                    const visit = await prisma.visit.findUnique({ where: { id: resourceId } });
                    if (!visit) return false;

                    if (ctx.roles.includes('client')) {
                        const client = await prisma.clientProfile.findUnique({ where: { userId: ctx.userId } });
                        if (visit.clientId === client?.id) return true;
                    }
                    if (ctx.roles.includes('psw')) {
                        const psw = await prisma.pswProfile.findUnique({ where: { userId: ctx.userId } });
                        if (visit.assignedPswId === psw?.id) return true;
                    }
                    break;

                // Add more resources as needed
            }

            return false;
        };

        // Attach to context variables if we add 'can' to Variables type
        // For now, we can use it inside the middleware or export the logic
        // Let's add it to context variables for easier use in routes
        (c.set as any)('can', can);

        await next();
    });
};
