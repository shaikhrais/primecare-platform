import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import statsRoutes from './routes/stats';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/', statsRoutes);

export default r;
