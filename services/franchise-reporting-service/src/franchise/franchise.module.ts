import { OpenAPIHono } from '@hono/zod-openapi';
import { franchiseRoutes } from './franchise.routes';

const app = new OpenAPIHono();

app.route('/', franchiseRoutes);

export default app;
