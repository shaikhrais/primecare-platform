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

const PermissionMap: Record<string, string[]> = {
    'admin': ['*'],
    'staff': ['read:User', 'read:Visit', 'read:ClientProfile', 'read:PswProfile', 'read:Incident', 'read:Timesheet'],
    'coordinator': ['read:User', 'read:Visit', 'read:Incident', 'update:Visit', 'create:Incident'],
    'finance': ['read:Invoice', 'read:Timesheet', 'update:Invoice'],
    'psw': ['read:Visit', 'update:Visit', 'read:PswProfile', 'update:PswProfile'],
    'client': ['read:Visit', 'create:Visit', 'read:ClientProfile', 'update:ClientProfile', 'read:Invoice']
};

export const policyMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        const payload = c.get('jwtPayload') as any;
        const prisma = c.get('prisma');

        if (!payload) return c.json({ error: 'Unauthorized' }, 401);

        const ctx: PolicyContext = {
            userId: payload.sub,
            roles: payload.roles,
            tenantId: payload.tenantId,
            prisma
        };

        const can = async (action: Action, resource: Resource, resourceId?: string) => {
            // Full Admin override
            if (ctx.roles.includes('admin')) return true;

            // Check granular permissions across all roles
            const hasPermission = ctx.roles.some(role => {
                const perms = PermissionMap[role] || [];
                return perms.includes('*') || perms.includes(`${action}:${resource}`);
            });

            if (hasPermission) return true;

            switch (resource) {
                case 'User':
                    const targetUser = await prisma.user.findUnique({ where: { id: resourceId || ctx.userId } });
                    if (targetUser && targetUser.tenantId === ctx.tenantId) {
                        if (resourceId === ctx.userId || ctx.roles.includes('admin') || ctx.roles.includes('staff')) return true;
                    }
                    break;

                case 'ClientProfile':
                    const client = await prisma.clientProfile.findUnique({
                        where: resourceId ? { id: resourceId } : { userId: ctx.userId }
                    });
                    if (client && client.tenantId === ctx.tenantId) {
                        if (client.userId === ctx.userId || ctx.roles.includes('admin') || ctx.roles.includes('staff') || ctx.roles.includes('rn')) return true;
                    }
                    break;

                case 'PswProfile':
                    const psw = await prisma.pswProfile.findUnique({
                        where: resourceId ? { id: resourceId } : { userId: ctx.userId }
                    });
                    if (psw && psw.tenantId === ctx.tenantId) {
                        if (psw.userId === ctx.userId || ctx.roles.includes('admin') || ctx.roles.includes('staff') || ctx.roles.includes('rn')) return true;
                    }
                    break;

                case 'Visit':
                    if (!resourceId) return true;
                    const visit = await prisma.visit.findUnique({ where: { id: resourceId } });
                    if (!visit || visit.tenantId !== ctx.tenantId) return false;

                    if (ctx.roles.includes('admin') || ctx.roles.includes('staff') || ctx.roles.includes('rn') || ctx.roles.includes('coordinator')) return true;

                    if (ctx.roles.includes('client')) {
                        const clientProf = await prisma.clientProfile.findUnique({ where: { userId: ctx.userId } });
                        if (visit.clientId === clientProf?.id) return true;
                    }
                    if (ctx.roles.includes('psw')) {
                        const pswProf = await prisma.pswProfile.findUnique({ where: { userId: ctx.userId } });
                        if (visit.assignedPswId === pswProf?.id) return true;
                    }
                    break;

                case 'Invoice':
                    if (!resourceId) return true;
                    const invoice = await prisma.invoice.findUnique({ where: { id: resourceId } });
                    if (!invoice || invoice.tenantId !== ctx.tenantId) return false;

                    if (ctx.roles.includes('admin') || ctx.roles.includes('finance')) return true;

                    if (ctx.roles.includes('client')) {
                        const clientProf = await prisma.clientProfile.findUnique({ where: { userId: ctx.userId } });
                        if (invoice.clientId === clientProf?.id) return true;
                    }
                    break;

                case 'Incident':
                    if (!resourceId) return true;
                    const incident = await prisma.incident.findUnique({ where: { id: resourceId } });
                    if (!incident || incident.tenantId !== ctx.tenantId) return false;

                    if (incident.reporterId === ctx.userId) return true;
                    if (ctx.roles.includes('admin') || ctx.roles.includes('staff') || ctx.roles.includes('coordinator') || ctx.roles.includes('rn')) return true;
                    break;

                case 'Timesheet':
                    if (!resourceId) return true;
                    const timesheet = await prisma.timesheet.findUnique({ where: { id: resourceId } });
                    if (!timesheet || timesheet.tenantId !== ctx.tenantId) return false;

                    if (ctx.roles.includes('admin') || ctx.roles.includes('finance')) return true;

                    if (ctx.roles.includes('psw')) {
                        const pswProf = await prisma.pswProfile.findUnique({ where: { userId: ctx.userId } });
                        if (timesheet.pswId === pswProf?.id) return true;
                    }
                    break;
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
