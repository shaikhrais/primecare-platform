import { Prisma } from '@prisma/client';

export const forensicExtension = (actorUserId?: string | null, deviceId?: string | null, ipAddress?: string | null) => {
    return Prisma.defineExtension({
        name: 'forensicExtension',
        query: {
            $allModels: {
                async $allOperations({ model, operation, args, query }: { model: string, operation: string, args: any, query: any }) {
                    // 1. Skip logging for SystemEvent itself to avoid circular references/recursion
                    if (model === 'SystemEvent') {
                        return query(args);
                    }

                    // Reconstruct/Determine Tenant ID
                    const result: any = await query(args);

                    const mutateOperations = ['create', 'createMany', 'update', 'updateMany', 'delete', 'deleteMany', 'upsert'];
                    if (!mutateOperations.includes(operation)) {
                        return result;
                    }

                    const tenantId = args?.data?.tenantId ||
                        args?.where?.tenantId ||
                        result?.tenantId ||
                        'system';

                    const finalEntityId = args?.where?.id || result?.id || (Array.isArray(result) ? 'batch' : undefined);

                    try {
                        // Use the prisma internal 'query' for SystemEvent
                        const prisma = (this as any);
                        if (prisma.systemEvent) {
                            prisma.systemEvent.create({
                                data: {
                                    tenantId,
                                    operation: operation.toUpperCase(),
                                    modelName: model,
                                    entityId: finalEntityId ? String(finalEntityId) : null,
                                    payload: args.data || args,
                                    actorUserId,
                                    deviceId,
                                    ipAddress,
                                    createdAt: new Date()
                                }
                            }).catch((err: any) => console.error('[FORENSIC_INTERNAL_ERROR]', err));
                        }
                    } catch (e) {
                        console.error('[FORENSIC_CAPTURE_ERROR]', e);
                    }

                    return result;
                },
            },
        },
    });
};
