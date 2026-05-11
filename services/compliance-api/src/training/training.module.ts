import { OpenAPIHono } from '@hono/zod-openapi';
import { trainingRoutes } from './training.routes';

const app = new OpenAPIHono();

app.route('/', trainingRoutes);

export default app;
