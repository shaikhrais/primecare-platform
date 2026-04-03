import { OpenAPIHono } from '@hono/zod-openapi';
import { intakeRoutes } from './intake.routes';

const app = new OpenAPIHono();

app.route('/', intakeRoutes);

export default app;
