import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../bindings';
import { requireAuth } from '../../../_shared/middleware/auth';
import homeRoutes from './home/home.routes';
import scheduleRoutes from './schedule/schedule.routes';
import dailyEntryRoutes from './dailyEntry/dailyEntry.routes';
import incidentsRoutes from './incidents/incidents.routes';
import handoverRoutes from './handover/handover.routes';
import availabilityRoutes from './availability/availability.routes';
import payoutsRoutes from './payouts/payouts.routes';
import wellnessRoutes from './wellness/wellness.routes';
import mileageRoutes from './mileage/mileage.routes';
import trainingRoutes from './training/training.routes';
import visitNoteRoutes from './visitNote/visitNote.routes';
import marRoutes from './mar/mar.routes';
import carePlanRoutes from './careplan/careplan.routes';
import timesheetRoutes from './timesheet/timesheet.routes';
import earningsRoutes from './earnings/earnings.routes';

const psw = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// PSW module-level middleware
psw.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// Routes
psw.route('/home', homeRoutes);
psw.route('/schedule', scheduleRoutes);
psw.route('/daily-entry', dailyEntryRoutes);
psw.route('/incidents', incidentsRoutes);
psw.route('/handover', handoverRoutes);
psw.route('/availability', availabilityRoutes);
psw.route('/payouts', payoutsRoutes);
psw.route('/wellness', wellnessRoutes);
psw.route('/mileage', mileageRoutes);
psw.route('/training', trainingRoutes);
psw.route('/visit-notes', visitNoteRoutes);
psw.route('/mar', marRoutes);
psw.route('/care-plan', carePlanRoutes);
psw.route('/timesheets', timesheetRoutes);
psw.route('/earnings', earningsRoutes);

export default psw;
