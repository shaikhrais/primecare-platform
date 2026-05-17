import { OpenAPIHono } from '@hono/zod-openapi';
import inboxRoutes from './inbox.routes';

const app = new OpenAPIHono();

app.route('/', inboxRoutes);

export default app;
