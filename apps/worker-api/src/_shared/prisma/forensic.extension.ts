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

                        // FETCH PREVIOUS HASH (Bank-Level Chain)
                        let previousChecksum = null;
                        if (prisma.systemEvent) {
                            const lastEvent = await prisma.systemEvent.findFirst({
                                where: { tenantId },
                                orderBy: { createdAt: 'desc' },
                                select: { checksum: true }
                            });
                            previousChecksum = lastEvent?.checksum || null;
                        }

                        const eventId = crypto.randomUUID();
                        const timestamp = new Date().toISOString();

                        // R8: Sanitize payload — strip sensitive fields before logging/storing
                        const SENSITIVE_FIELDS = ['passwordHash', 'password', 'token', 'secret', 'accessToken', 'refreshToken'];
                        const sanitizedPayload = JSON.parse(JSON.stringify(args.data || args));
                        for (const field of SENSITIVE_FIELDS) {
                            if (sanitizedPayload[field]) sanitizedPayload[field] = '[REDACTED]';
                        }

                        // Prepare the data to be hashed
                        const rawData = JSON.stringify({
                            tenantId,
                            operation: operation.toUpperCase(),
                            modelName: model,
                            entityId: finalEntityId ? String(finalEntityId) : null,
                            payload: sanitizedPayload,
                            actorUserId,
                            deviceId,
                            previousChecksum,
                            createdAt: timestamp
                        });

                        // COMPUTE SHA-256 CHECKSUM
                        const msgUint8 = new TextEncoder().encode(rawData);
                        const hashBuffer = await crypto.subtle.digest('SHA-256', msgUint8);
                        const hashArray = Array.from(new Uint8Array(hashBuffer));
                        const checksum = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');

                        const eventData = {
                            id: eventId,
                            tenantId,
                            operation: operation.toUpperCase(),
                            modelName: model,
                            entityId: finalEntityId ? String(finalEntityId) : null,
                            payload: sanitizedPayload,       // R8: Sanitized payload
                            actorUserId,
                            deviceId,
                            // R8: ipAddress removed from stored events (PII under PHIPA/PIPEDA)
                            checksum,
                            previousChecksum,
                            createdAt: timestamp
                        };

                        // Output structured JSON for flat-file log harvest (JSONL)
                        console.log(`[FORENSIC_TRACER_JSON] ${JSON.stringify(eventData)}`);

                        if (prisma.systemEvent) {
                            // R8: Await create to avoid lost events
                            await prisma.systemEvent.create({
                                data: eventData
                            }).catch((err: any) => { });  // Silent catch to avoid blocking main flow
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
