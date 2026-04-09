import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import listRoutes from './routes/list';
import manageRoutes from './routes/manage';
import shiftRoutes from './routes/shifts';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/', listRoutes);
r.route('/', manageRoutes);
r.route('/', shiftRoutes);

export default r;
