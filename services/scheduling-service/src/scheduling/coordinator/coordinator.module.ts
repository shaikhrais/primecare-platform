import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requireAuth } from '@primecare/shared-auth';
import coordinatorRoutes from './coordinator.routes';
import fleetRoutes from './fleet.routes';
import shiftSwapRoutes from './shift-swap.routes';
import sosRoutes from './sos.routes';
import waitlistRoutes from './waitlist.routes';
import callInRoutes from './scheduling/call-ins.routes';
import visitsRoutes from './visits/visits.routes';

const coordinator = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Coordinator module-level middleware
coordinator.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// Routes
coordinator.route('/', coordinatorRoutes);
coordinator.route('/fleet', fleetRoutes);
coordinator.route('/shift-swap', shiftSwapRoutes);
coordinator.route('/sos', sosRoutes);
coordinator.route('/waitlist', waitlistRoutes);
coordinator.route('/call-ins', callInRoutes);
coordinator.route('/visits', visitsRoutes);

export default coordinator;
