import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Hello from franchise-reporting-service'));
export default app;