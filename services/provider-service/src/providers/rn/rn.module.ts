import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../bindings';
import { requireAuth } from '../../../_shared/middleware/auth';
import supervisionRoutes from './supervision/supervision.routes';
import dailyReviewRoutes from './dailyReview/dailyReview.routes';
import clinicalRoutes from './clinical/clinical.routes';
import marRoutes from './mar/mar.routes';
import woundCareRoutes from './wound-care/wound-care.routes';
import raiHcRoutes from './assessments/rai-hc.routes';
import patientsRoutes from './patients/patients.routes';

const rn = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// RN module-level middleware
rn.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// Routes
rn.route('/supervision', supervisionRoutes);
rn.route('/daily-review', dailyReviewRoutes);
rn.route('/clinical', clinicalRoutes);
rn.route('/mar', marRoutes);
rn.route('/wound-care', woundCareRoutes);
rn.route('/assessments', raiHcRoutes);
rn.route('/patients', patientsRoutes);

export default rn;
