import { OpenAPIHono } from '@hono/zod-openapi';
import { carePlansRoutes } from './care-plans.routes';

const app = new OpenAPIHono();

app.route('/', carePlansRoutes);

export default app;
