import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import supervisionRoutes from './supervision/supervision.routes';
import dailyReviewRoutes from './dailyReview/dailyReview.routes';

const rn = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// RN module-level middleware
rn.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});

// Routes
rn.route('/supervision', supervisionRoutes);
rn.route('/daily-review', dailyReviewRoutes);

// Placeholder for clinical/carePlans if they existed in legacy
// rn.route('/care-plans', carePlanRoutes);

export default rn;
