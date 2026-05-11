import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Hello from notification-service'));
export default app;
