import { OpenAPIHono } from '@hono/zod-openapi';
import { reportingRoutes } from './reporting.routes';

const app = new OpenAPIHono();

app.route('/', reportingRoutes);

export default app;
