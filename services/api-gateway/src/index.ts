import { Hono } from 'hono';

type Bindings = {
  AUTH_SERVICE: Fetcher;
  PROVIDER_SERVICE: Fetcher;
  CLIENT_SERVICE: Fetcher;
  SCHEDULING_SERVICE: Fetcher;
  VISIT_SERVICE: Fetcher;
  NOTES_SERVICE: Fetcher;
  BILLING_SERVICE: Fetcher;
  NOTIFICATION_SERVICE: Fetcher;
  COMPLIANCE_SERVICE: Fetcher;
  FRANCHISE_REPORTING_SERVICE: Fetcher;
};

const app = new Hono<{ Bindings: Bindings }>();

// Global Middleware
app.use('*', async (c, next) => {
  const start = Date.now();
  await next();
  console.log(`[API Gateway] ${c.req.method} ${c.req.url} - ${Date.now() - start}ms`);
});

// Health check
app.get('/health', (c) => c.json({ status: 'API Gateway is Operational', mode: 'Cloudflare Edge Proxy', version: '1.0.0' }));

// ----------------------------------------------------
// Service Mesh Proxy Handlers (Cloudflare Service Bindings)
// ----------------------------------------------------

app.all('/api/auth/*', (c) => c.env.AUTH_SERVICE ? c.env.AUTH_SERVICE.fetch(c.req.raw) : c.text('AUTH_SERVICE offline', 502));
app.all('/api/providers/*', (c) => c.env.PROVIDER_SERVICE ? c.env.PROVIDER_SERVICE.fetch(c.req.raw) : c.text('PROVIDER_SERVICE offline', 502));
app.all('/api/clients/*', (c) => c.env.CLIENT_SERVICE ? c.env.CLIENT_SERVICE.fetch(c.req.raw) : c.text('CLIENT_SERVICE offline', 502));
app.all('/api/scheduling/*', (c) => c.env.SCHEDULING_SERVICE ? c.env.SCHEDULING_SERVICE.fetch(c.req.raw) : c.text('SCHEDULING_SERVICE offline', 502));
app.all('/api/visits/*', (c) => c.env.VISIT_SERVICE ? c.env.VISIT_SERVICE.fetch(c.req.raw) : c.text('VISIT_SERVICE offline', 502));
app.all('/api/notes/*', (c) => c.env.NOTES_SERVICE ? c.env.NOTES_SERVICE.fetch(c.req.raw) : c.text('NOTES_SERVICE offline', 502));
app.all('/api/billing/*', (c) => c.env.BILLING_SERVICE ? c.env.BILLING_SERVICE.fetch(c.req.raw) : c.text('BILLING_SERVICE offline', 502));
app.all('/api/notifications/*', (c) => c.env.NOTIFICATION_SERVICE ? c.env.NOTIFICATION_SERVICE.fetch(c.req.raw) : c.text('NOTIFICATION_SERVICE offline', 502));
app.all('/api/compliance/*', (c) => c.env.COMPLIANCE_SERVICE ? c.env.COMPLIANCE_SERVICE.fetch(c.req.raw) : c.text('COMPLIANCE_SERVICE offline', 502));
app.all('/api/franchise/*', (c) => c.env.FRANCHISE_REPORTING_SERVICE ? c.env.FRANCHISE_REPORTING_SERVICE.fetch(c.req.raw) : c.text('FRANCHISE_REPORTING_SERVICE offline', 502));

export default app;
