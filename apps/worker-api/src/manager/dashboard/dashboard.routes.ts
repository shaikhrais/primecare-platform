import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import statsRoutes from './routes/stats';
import todayRoutes from './routes/today';
import kpiRoutes from './routes/kpi';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/', statsRoutes);
r.route('/', todayRoutes);
r.route('/', kpiRoutes);

export default r;
