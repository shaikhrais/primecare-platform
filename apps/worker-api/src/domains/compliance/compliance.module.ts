import { OpenAPIHono } from '@hono/zod-openapi';
import { complianceRoutes } from './compliance.routes';

const app = new OpenAPIHono();

app.route('/', complianceRoutes);

export default app;
