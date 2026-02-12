import { createMiddleware } from 'hono/factory';
import { Bindings, Variables } from '../bindings';

const TENANT_AWARE_MODELS = [
    'user',
    'clientProfile',
    'pswProfile',
    'visit',
    'service',
    'auditLog',
    'dailyEntry',
    'incident',
    'timesheet',
    'invoice',
    'messageThread'
];

export const tenantMiddleware = () => {
    return createMiddleware<{ Bindings: Bindings; Variables: Variables }>(async (c, next) => {
        const payload = c.get('jwtPayload');
        const role = payload?.role;
        const tenantId = payload?.tenantId;

        if (!payload?.sub) return c.json({ error: 'Unauthorized' }, 401);

        const prisma = c.get('prisma');

        // Admins and Staff bypass global tenant isolation if they don't have a tenantId 
        // OR we can allow them to see everything. For now, let's say they bypass if role is admin/staff.
        if (role === 'admin' || role === 'staff') {
            await next();
            return;
        }

        if (!tenantId) {
            return c.json({ error: 'Tenant context missing' }, 403);
        }

        // Extend Prisma client with tenant scoping
        const scopedPrisma = prisma.$extends({
            query: {
                $allModels: {
                    async $allOperations({ model, operation, args, query }: any) {
                        const modelName = model.charAt(0).toLowerCase() + model.slice(1);

                        if (TENANT_AWARE_MODELS.includes(modelName)) {
                            // Inject tenantId into 'where' for read/update/delete
                            if (['findMany', 'findFirst', 'findUnique', 'count', 'update', 'updateMany', 'delete', 'deleteMany', 'upsert'].includes(operation)) {
                                args.where = { ...args.where, tenantId };
                            }
                            // Inject tenantId into 'data' for create
                            if (['create', 'createMany'].includes(operation)) {
                                if (operation === 'create') {
                                    args.data = { ...args.data, tenantId };
                                } else {
                                    if (Array.isArray(args.data)) {
                                        args.data = args.data.map((d: any) => ({ ...d, tenantId }));
                                    }
                                }
                            }
                            // Special case for upsert
                            if (operation === 'upsert') {
                                args.create = { ...args.create, tenantId };
                                args.update = { ...args.update, tenantId };
                            }
                        }

                        return query(args);
                    },
                },
            },
        });

        // Replace the prisma instance in context with the scoped one
        c.set('prisma', scopedPrisma);

        await next();
    });
};
