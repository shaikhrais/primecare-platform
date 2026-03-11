import { Prisma } from '@prisma/client';

export const tenantExtension = (tenantId: string) => {
    return Prisma.defineExtension({
        name: 'tenantExtension',
        query: {
            $allModels: {
                async $allOperations({ model, operation, args, query }) {
                    // List of models that ARE NOT tenant-scoped (e.g., global models) or have implicit tenant scope
                    const globalModels = ['Tenant', 'FAQ', 'Lead', 'BlogPost', 'SystemEvent', 'UserDevice'];

                    if (globalModels.includes(model)) {
                        return query(args);
                    }

                    // For findUnique, injecting tenantId into 'where' causes Prisma validation errors 
                    // since tenantId is not part of the unique index constraint. Instead, we query normally 
                    // and then verify the tenant isolation post-fetch.
                    if (['findUnique', 'findUniqueOrThrow'].includes(operation)) {
                        const result: any = await query(args);
                        if (result && result.tenantId && result.tenantId !== tenantId) {
                            if (operation === 'findUnique') return null;
                            throw new Error('Record not found');
                        }
                        return result;
                    }

                    // For update, delete, upsert - injecting tenantId into 'where' also breaks the unique constraint requirements
                    // So we must manually fetch the record first, verify tenantId, and then execute the operation unmodified.
                    if (['update', 'delete', 'upsert'].includes(operation)) {
                        // findFirst safely queries without requiring a unique index
                        const existingRecord: any = await (this as any)[model].findFirst({
                            where: { ...(args as any).where, tenantId }
                        });
                        
                        if (!existingRecord) {
                            throw new Error(`Record not found or unauthorized for ${operation}`);
                        }
                        return query(args);
                    }

                    // Inject tenantId into where clause for other read operations (findFirst, findMany, count, updateMany, deleteMany)
                    if (['findFirst', 'findMany', 'count', 'updateMany', 'deleteMany'].includes(operation)) {
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
