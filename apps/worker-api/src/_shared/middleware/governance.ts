import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '../../bindings';

/**
 * Middleware to enforce Network (VPN) and Device Governance.
 */
export const governanceMiddleware = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        const prisma = c.get('prisma');
        const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
        const deviceId = c.req.header('X-Device-ID');
        c.set('deviceId', deviceId);
        const clientIp = c.req.header('CF-Connecting-IP') || '127.0.0.1';

        if (!tenantId) {
            return await next();
        }

        // 1. Fetch Tenant Security Config
        const tenant = await prisma.tenant.findUnique({
            where: { id: tenantId },
            select: {
                enforceVpn: true,
                allowedVpnRanges: true,
                requireDeviceApproval: true,
                maxDevicesPerUser: true
            }
        });

        if (!tenant) {
            return await next();
        }

        // 2. VPN Enforcement
        if (tenant.enforceVpn && tenant.allowedVpnRanges.length > 0) {
            const isAllowed = tenant.allowedVpnRanges.some((range: string) => {
                // Support exact match or prefix match for simple CIDR-like behavior
                if (range.endsWith('*')) {
                    return clientIp.startsWith(range.slice(0, -1));
                }
                return clientIp === range;
            });

            if (!isAllowed) {
                console.warn(`[GOVERNANCE] Blocked IP ${clientIp} for Tenant ${tenantId} (VPN Required)`);
                return c.json({
                    error: 'Network Access Restricted',
                    message: 'Please connect to the company VPN to access this resource.'
                }, 403);
            }
        }

        // 3. Device Enforcement (Only for authenticated requests)
        const jwtPayload = c.get('jwtPayload' as any);
        if (jwtPayload && deviceId) {
            const userId = (jwtPayload as any).sub;
            const device = await prisma.userDevice.findUnique({
                where: {
                    userId_deviceId: { userId, deviceId }
                }
            });

            if (!device) {
                // If device approval is required, block unknown devices
                if (tenant.requireDeviceApproval) {
                    return c.json({
                        error: 'Unauthorized Device',
                        message: 'This device is not registered. Please contact your administrator for approval.'
                    }, 403);
                }
            } else {
                // Check if device is blocked or revoked
                if (device.status === 'blocked' || device.status === 'revoked') {
                    return c.json({ error: 'Device Blocked', message: 'Access from this device has been revoked.' }, 403);
                }

                // Check authorization if required
                if (tenant.requireDeviceApproval && !device.isAuthorized) {
                    return c.json({ error: 'Device Pending Approval', message: 'Your device is awaiting administrator approval.' }, 403);
                }

                // Check temporary expiration
                if (device.isTemporary && device.expiresAt && new Date() > device.expiresAt) {
                    return c.json({ error: 'Access Expired', message: 'Temporary access for this device has expired.' }, 403);
                }

                // Update last active
                await prisma.userDevice.update({
                    where: { id: device.id },
                    data: { lastActiveAt: new Date(), lastIp: clientIp }
                });
            }
        }

        await next();
    };
};
