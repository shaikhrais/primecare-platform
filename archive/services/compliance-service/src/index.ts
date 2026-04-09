import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Hello from compliance-service'));
export default app;