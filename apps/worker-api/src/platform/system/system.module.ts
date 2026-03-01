import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import notificationRoutes from './notifications/notifications.routes';
import paymentRoutes from './payments/payments.routes';
import storageRoutes from './storage/storage.routes';
import voiceRoutes from './voice/voice.routes';
import platformRoutes from './platform/platform.routes';
import stripeRoutes from './platform/stripe.routes';

const system = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// System module-level middleware
system.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});

// Routes
system.route('/notifications', notificationRoutes);
system.route('/payments', paymentRoutes);
system.route('/storage', storageRoutes);
system.route('/voice', voiceRoutes);
system.route('/platform', platformRoutes);
system.route('/platform/stripe', stripeRoutes);

export default system;
