import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Hello from provider-service'));
export default app;
