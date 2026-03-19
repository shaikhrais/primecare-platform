import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import profileRoutes from './profile.routes';
import passwordRoutes from './password.routes';
import messagingRoutes from './messaging.routes';
import sharedTrainingRoutes from './training.routes';
import incidentRoutes from './incidents.routes';
import evvRoutes from './evv.routes';

const user = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// All /v1/user routes require authentication
user.use('*', async (c, next) => {
    const secret = c.env.JWT_SECRET || 'local-mock-secret-key-123';
    if (!secret) return c.json({ error: 'Server configuration error' }, 500);
    const middleware = requireAuth(secret);
    return await middleware(c, next);
});

user.route('/profile', profileRoutes);
user.route('/', passwordRoutes);
user.route('/messaging', messagingRoutes);
user.route('/training', sharedTrainingRoutes);
user.route('/incidents', incidentRoutes);
user.route('/evv', evvRoutes);

export default user;
