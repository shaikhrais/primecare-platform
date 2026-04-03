import { Hono } from 'hono';

const app = new Hono();

// Global Middleware
app.use('*', async (c, next) => {
  const start = Date.now()
  await next()
  console.log(`[API Gateway] ${c.req.method} ${c.req.url} - ${Date.now() - start}ms`)
});

// Health check
app.get('/health', (c) => c.json({ status: 'API Gateway is Operational', version: '1.0.0' }));

// ----------------------------------------------------
// Microservice Proxy Routes (Service Bindings / Fetch)
// ----------------------------------------------------

/**
 * In a Cloudflare bound environment, you would use:
 * return c.env.AUTH_SERVICE.fetch(c.req.raw)
 */

app.all('/api/auth/*', (c) => {
  // Mock Proxy to Auth Service
  return c.text('Proxied to Auth Service');
});

app.all('/api/providers/*', (c) => {
  // Mock Proxy to Provider Service
  return c.text('Proxied to Provider Service');
});

app.all('/api/clients/*', (c) => {
  // Mock Proxy to Client Service
  return c.text('Proxied to Client Service');
});

app.all('/api/scheduling/*', (c) => {
  // Mock Proxy to Scheduling Service
  return c.text('Proxied to Scheduling Service');
});

app.all('/api/visits/*', (c) => {
  // Mock Proxy to Visit Service
  return c.text('Proxied to Visit Service');
});

export default app;