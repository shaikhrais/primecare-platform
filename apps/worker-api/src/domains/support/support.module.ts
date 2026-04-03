import { OpenAPIHono } from '@hono/zod-openapi';
import { supportRoutes } from './support.routes';

const app = new OpenAPIHono();

app.route('/', supportRoutes);

export default app;
