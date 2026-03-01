import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import dashboardRoutes from './dashboard/dashboard.routes';
import bookingRoutes from './bookings/bookings.routes';
import carePlanRoutes from './carePlan/carePlan.routes';
import serviceRoutes from './services/services.routes';
import profileRoutes from './profile.routes';

const client = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Client module-level middleware
client.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});

// Routes
client.route('/', dashboardRoutes);
client.route('/bookings', bookingRoutes);
client.route('/care-plan', carePlanRoutes);
client.route('/', serviceRoutes);
client.route('/', profileRoutes);

export default client;
