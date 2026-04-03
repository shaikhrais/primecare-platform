import { Hono } from 'hono';
const app = new Hono();
app.get('/', (c) => c.text('Legacy Worker API Deactivated - Moved to Microservices'));
export default app;
