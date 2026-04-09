import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import operationsRoutes from './shifts/operations';
import assignmentRoutes from './shifts/assignment';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

r.route('/', operationsRoutes);
r.route('/', assignmentRoutes);

export default r;
