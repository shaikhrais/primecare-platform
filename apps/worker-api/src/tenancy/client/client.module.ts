import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import homeRoutes from './home/home.routes';
import bookingRoutes from './bookings/bookings.routes';
import carePlanRoutes from './carePlan/carePlan.routes';
import serviceRoutes from './services/services.routes';
import relationshipRoutes from './relationship/relationship.routes';
import engagementRoutes from './client_engagement.routes';
import familyRoutes from './family/family.routes';
import billingRoutes from './billing/billing.routes';
import feedbackRoutes from './feedback/feedback.routes';
import portalRoutes from './portal/portal.routes';
import paymentRoutes from './payments/payments.routes';
import inboxRoutes from './inbox/messages.routes';
import careTeamRoutes from './careTeam/careTeam.routes';
import pulseRoutes from './pulse/pulse.routes';

const client = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Client module-level middleware
client.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// Routes
client.route('/home', homeRoutes); // stats at /home/stats, profile at /home/profile
client.route('/bookings', bookingRoutes);
client.route('/care-plan', carePlanRoutes);
client.route('/', serviceRoutes);
client.route('/', relationshipRoutes); // support/feedback at /support/feedback
client.route('/engagement', engagementRoutes); // feed at /engagement/feed
client.route('/family', familyRoutes);
client.route('/billing', billingRoutes);
client.route('/feedback', feedbackRoutes);
client.route('/payments', paymentRoutes);
client.route('/inbox', inboxRoutes);
client.route('/care-team', careTeamRoutes);
client.route('/pulse', pulseRoutes);
client.route('/', portalRoutes);

export default client;
