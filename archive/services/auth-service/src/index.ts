import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Hello from auth-service'));
export default app;
