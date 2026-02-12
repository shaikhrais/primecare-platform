import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import notificationRoutes from './notifications/notifications.routes';
import paymentRoutes from './payments/payments.routes';
import storageRoutes from './storage/storage.routes';
import voiceRoutes from './voice/voice.routes';

const system = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// System module-level middleware
system.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
system.use('*', tenantMiddleware());

// Routes
system.route('/notifications', notificationRoutes);
system.route('/payments', paymentRoutes);
system.route('/storage', storageRoutes);
system.route('/voice', voiceRoutes);

export default system;
