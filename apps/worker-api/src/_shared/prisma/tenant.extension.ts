import { Prisma } from '@prisma/client';

export const tenantExtension = (tenantId: string) => {
    return Prisma.defineExtension({
        name: 'tenantExtension',
        query: {
            $allModels: {
                async $allOperations({ model, operation, args, query }) {
                    // List of models that ARE NOT tenant-scoped (e.g., global models)
                    const globalModels = ['Tenant', 'FAQ', 'Lead', 'BlogPost'];

                    if (globalModels.includes(model)) {
                        return query(args);
                    }

                    // Inject tenantId into where clause for read/update/delete operations
                    // R7: Added 'findUnique' — without it, users could bypass tenant isolation by ID lookup
                    if (['findUnique', 'findFirst', 'findMany', 'count', 'update', 'updateMany', 'delete', 'deleteMany', 'upsert'].includes(operation)) {
                        (args as any).where = { ...(args as any).where, tenantId };
                    }

                    // Inject tenantId into data for create operations
                    if (['create', 'createMany'].includes(operation)) {
                        const castArgs = args as any;
                        if (Array.isArray(castArgs.data)) {
                            castArgs.data = castArgs.data.map((item: any) => ({ ...item, tenantId }));
                        } else {
                            castArgs.data = { ...castArgs.data, tenantId };
                        }
                    }

                    return query(args);
                },
            },
        },
    });
};
