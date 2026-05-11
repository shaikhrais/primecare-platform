import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requireAuth } from '@primecare/security';
import profileRoutes from './profile.routes';
import passwordRoutes from './password.routes';
import messagingRoutes from './messaging.routes';
import sharedTrainingRoutes from './training.routes';
import incidentRoutes from './incidents.routes';
import evvRoutes from './evv.routes';
import dispatchRoutes from './dispatch.routes';
import analyticsRoutes from './analytics.routes';

const user = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// All /v1/user routes require authentication
user.use('*', async (c, next) => {
    const secret = c.env.JWT_SECRET || 'local-mock-secret-key-123';
    if (!secret) return c.json({ error: 'Server configuration error' }, 500);
    const middleware = requireAuth(secret);
    return await middleware(c, next);
});

user.route('/profile', profileRoutes);

// GEOLOCATED CONTACT DIRECTORY
user.openapi(createRoute({
    method: 'get',
    path: '/directory',
    responses: {
        200: { description: 'Global Contact Directory', content: { 'application/json': { schema: z.any() } } },
        401: { description: 'Unauthorized' }
    }
}), async (c) => {
    const usr = c.var.user as any;
    if (!usr) return c.json({ error: 'Unauthorized' }, 401);

    const contacts = await c.var.prisma.user.findMany({
        where: { tenantId: usr.tenantId },
        select: {
            id: true,
            email: true,
            roles: true,
            clientProfile: { select: { fullName: true } },
            providerProfile: { select: { fullName: true } }
        }
    });
    
    // Map to a deterministic displayName
    const directory = contacts.map((c: any) => ({
        id: c.id,
        email: c.email,
        roles: c.roles,
        displayName: c.clientProfile?.fullName || c.providerProfile?.fullName || c.email.split('@')[0]
    }));

    return c.json(directory, 200);
});
user.route('/', passwordRoutes);
user.route('/messaging', messagingRoutes);
user.route('/training', sharedTrainingRoutes);
user.route('/incidents', incidentRoutes);
user.route('/evv', evvRoutes);
user.route('/dispatch', dispatchRoutes);
user.route('/analytics', analyticsRoutes);

export default user;
