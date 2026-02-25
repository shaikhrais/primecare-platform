import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import checkInRoutes from './check/in';
import checkOutRoutes from './check/out';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/', checkInRoutes);
r.route('/', checkOutRoutes);

export default r;
