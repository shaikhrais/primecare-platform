import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Hello from billing-service'));
export default app;
