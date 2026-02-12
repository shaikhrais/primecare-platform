import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import dashboardRoutes from './dashboard/dashboard.routes';
import bookingRoutes from './bookings/bookings.routes';
import carePlanRoutes from './carePlan/carePlan.routes';
import serviceRoutes from './services/services.routes';

const client = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Client module-level middleware
client.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
client.use('*', tenantMiddleware());

// Routes
client.route('/', dashboardRoutes);
client.route('/bookings', bookingRoutes);
client.route('/care-plan', carePlanRoutes);
client.route('/', serviceRoutes);

export default client;
