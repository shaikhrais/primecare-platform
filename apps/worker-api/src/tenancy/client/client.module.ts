import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import operationsRoutes from './operations/operations.routes';
import bookingRoutes from './bookings/bookings.routes';
import carePlanRoutes from './carePlan/carePlan.routes';
import serviceRoutes from './services/services.routes';
import relationshipRoutes from './relationship/relationship.routes';
import engagementRoutes from './client_engagement.routes';
import familyRoutes from './family/family.routes';
import billingRoutes from './billing/billing.routes';
import feedbackRoutes from './feedback/feedback.routes';
import portalRoutes from './portal/portal.routes';

const client = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Client module-level middleware
client.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// Routes
client.route('/operations', operationsRoutes); // stats at /operations/stats, profile at /operations/profile
client.route('/bookings', bookingRoutes);
client.route('/care-plan', carePlanRoutes);
client.route('/', serviceRoutes);
client.route('/', relationshipRoutes); // support/feedback at /support/feedback
client.route('/engagement', engagementRoutes); // feed at /engagement/feed
client.route('/family', familyRoutes);
client.route('/billing', billingRoutes);
client.route('/feedback', feedbackRoutes);
client.route('/', portalRoutes);

export default client;
