import { Prisma } from '@prisma/client';

export const auditExtension = (deviceId?: string | null) => {
    return Prisma.defineExtension({
        name: 'auditExtension',
        query: {
            auditLog: {
                async create({ args, query }) {
                    if (deviceId && !args.data.deviceId) {
                        args.data.deviceId = deviceId;
                    }
                    return query(args);
                },
                async createMany({ args, query }) {
                    if (deviceId) {
                        if (Array.isArray(args.data)) {
                            args.data = args.data.map(item => ({
                                ...item,
                                deviceId: item.deviceId || deviceId
                            }));
                        }
                    }
                    return query(args);
                }
            }
        }
    });
};
