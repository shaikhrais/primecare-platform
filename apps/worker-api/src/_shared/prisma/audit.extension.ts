import { Prisma } from '@prisma/client';

export const auditExtension = (deviceId?: string | null) => {
    return Prisma.defineExtension({
        name: 'auditExtension',
        query: {
            auditLog: {
                async create({ args, query }: { args: any, query: any }) {
                    if (deviceId && !args.data.deviceId) {
                        args.data.deviceId = deviceId;
                    }
                    return query(args);
                },
                async createMany({ args, query }: { args: any, query: any }) {
                    if (deviceId) {
                        if (Array.isArray(args.data)) {
                            args.data = args.data.map((item: any) => ({
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
