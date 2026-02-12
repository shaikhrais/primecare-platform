import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import supervisionRoutes from './supervision/supervision.routes';
import dailyReviewRoutes from './dailyReview/dailyReview.routes';

const rn = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// RN module-level middleware
rn.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
rn.use('*', tenantMiddleware());

// Routes
rn.route('/supervision', supervisionRoutes);
rn.route('/daily-review', dailyReviewRoutes);

// Placeholder for clinical/carePlans if they existed in legacy
// rn.route('/care-plans', carePlanRoutes);

export default rn;
