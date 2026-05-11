import { OpenAPIHono } from '@hono/zod-openapi';
import { handleMockUIEndpoint } from './mock_ui_service';
import { registerStandardMiddleware, createFetchWrapper } from '@primecare/infrastructure';
import { Bindings, Variables } from '@primecare/contracts';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Infrastructure Standard Setup - Enforces Observability, Security, and Resilience
registerStandardMiddleware(app as any);

// Health check
app.get('/health', (c) => c.json({ status: 'API Gateway is Operational', mode: 'Cloudflare Edge Proxy', version: '1.1.0' }));

// ----------------------------------------------------
// Service Mesh Proxy Handlers (Cloudflare Service Bindings)
// ----------------------------------------------------

// Route both /api/auth and /api/v1/auth to the AUTH_SERVICE
app.all('/api/auth/*', (c) => c.env.AUTH_SERVICE ? c.env.AUTH_SERVICE.fetch(c.req.raw) : c.text('AUTH_SERVICE offline', 502));
app.all('/api/v1/auth/*', (c) => c.env.AUTH_SERVICE ? c.env.AUTH_SERVICE.fetch(c.req.raw) : c.text('AUTH_SERVICE offline', 502));
app.all('/v1/auth/*', (c) => c.env.AUTH_SERVICE ? c.env.AUTH_SERVICE.fetch(c.req.raw) : c.text('AUTH_SERVICE offline', 502));

// Add direct mapping for governance routes used by UI
app.all('/v1/governance/*', (c) => c.env.AUTH_SERVICE ? c.env.AUTH_SERVICE.fetch(c.req.raw) : c.text('AUTH_SERVICE offline', 502)); // Note: Governance is currently inside Auth service in some architectures

app.all('/api/providers/*', (c) => c.env.PROVIDER_SERVICE ? c.env.PROVIDER_SERVICE.fetch(c.req.raw) : c.text('PROVIDER_SERVICE offline', 502));
app.all('/api/v1/providers/*', (c) => c.env.PROVIDER_SERVICE ? c.env.PROVIDER_SERVICE.fetch(c.req.raw) : c.text('PROVIDER_SERVICE offline', 502));

app.all('/api/clients/*', (c) => c.env.CLIENT_SERVICE ? c.env.CLIENT_SERVICE.fetch(c.req.raw) : c.text('CLIENT_SERVICE offline', 502));
app.all('/api/v1/clients/*', (c) => c.env.CLIENT_SERVICE ? c.env.CLIENT_SERVICE.fetch(c.req.raw) : c.text('CLIENT_SERVICE offline', 502));

app.all('/api/scheduling/*', (c) => c.env.SCHEDULING_SERVICE ? c.env.SCHEDULING_SERVICE.fetch(c.req.raw) : c.text('SCHEDULING_SERVICE offline', 502));
app.all('/api/v1/scheduling/*', (c) => c.env.SCHEDULING_SERVICE ? c.env.SCHEDULING_SERVICE.fetch(c.req.raw) : c.text('SCHEDULING_SERVICE offline', 502));

app.all('/api/visits/*', (c) => c.env.VISIT_SERVICE ? c.env.VISIT_SERVICE.fetch(c.req.raw) : c.text('VISIT_SERVICE offline', 502));
app.all('/api/v1/visits/*', (c) => c.env.VISIT_SERVICE ? c.env.VISIT_SERVICE.fetch(c.req.raw) : c.text('VISIT_SERVICE offline', 502));

app.all('/api/notes/*', (c) => c.env.NOTES_SERVICE ? c.env.NOTES_SERVICE.fetch(c.req.raw) : c.text('NOTES_SERVICE offline', 502));
app.all('/api/v1/notes/*', (c) => c.env.NOTES_SERVICE ? c.env.NOTES_SERVICE.fetch(c.req.raw) : c.text('NOTES_SERVICE offline', 502));

app.all('/api/billing/*', (c) => c.env.BILLING_SERVICE ? c.env.BILLING_SERVICE.fetch(c.req.raw) : c.text('BILLING_SERVICE offline', 502));
app.all('/api/v1/billing/*', (c) => c.env.BILLING_SERVICE ? c.env.BILLING_SERVICE.fetch(c.req.raw) : c.text('BILLING_SERVICE offline', 502));

app.all('/api/notifications/*', (c) => c.env.NOTIFICATION_SERVICE ? c.env.NOTIFICATION_SERVICE.fetch(c.req.raw) : c.text('NOTIFICATION_SERVICE offline', 502));
app.all('/api/v1/notifications/*', (c) => c.env.NOTIFICATION_SERVICE ? c.env.NOTIFICATION_SERVICE.fetch(c.req.raw) : c.text('NOTIFICATION_SERVICE offline', 502));

app.all('/api/compliance/*', (c) => c.env.COMPLIANCE_SERVICE ? c.env.COMPLIANCE_SERVICE.fetch(c.req.raw) : c.text('COMPLIANCE_SERVICE offline', 502));
app.all('/api/v1/compliance/*', (c) => c.env.COMPLIANCE_SERVICE ? c.env.COMPLIANCE_SERVICE.fetch(c.req.raw) : c.text('COMPLIANCE_SERVICE offline', 502));

app.all('/api/franchise/*', (c) => c.env.FRANCHISE_REPORTING_SERVICE ? c.env.FRANCHISE_REPORTING_SERVICE.fetch(c.req.raw) : c.text('FRANCHISE_REPORTING_SERVICE offline', 502));
app.all('/api/v1/franchise/*', (c) => c.env.FRANCHISE_REPORTING_SERVICE ? c.env.FRANCHISE_REPORTING_SERVICE.fetch(c.req.raw) : c.text('FRANCHISE_REPORTING_SERVICE offline', 502));

// ----------------------------------------------------
// UI Compatibility Layer: Mock interceptor for unimplemented v1 routes
// ----------------------------------------------------
app.all('/v1/*', async (c) => {
  return handleMockUIEndpoint(c);
});
app.all('/api/v1/*', async (c) => {
  return handleMockUIEndpoint(c);
});
app.all('/dashboard/*', async (c) => {
  return handleMockUIEndpoint(c);
});

// ----------------------------------------------------
// Swagger Hub: OpenAPI Federated Aggregator
// ----------------------------------------------------
app.get('/openapi.json', async (c) => {
  const merged = {
    openapi: '3.0.0',
    info: { title: 'PrimeCare Microservices Mesh', version: '1.0.0' },
    paths: {},
    components: { schemas: {} }
  };

  const bindings = [
    { key: 'AUTH_SERVICE', instance: c.env.AUTH_SERVICE },
    { key: 'PROVIDER_SERVICE', instance: c.env.PROVIDER_SERVICE },
    { key: 'CLIENT_SERVICE', instance: c.env.CLIENT_SERVICE },
    { key: 'SCHEDULING_SERVICE', instance: c.env.SCHEDULING_SERVICE },
    { key: 'VISIT_SERVICE', instance: c.env.VISIT_SERVICE },
    { key: 'NOTES_SERVICE', instance: c.env.NOTES_SERVICE },
    { key: 'BILLING_SERVICE', instance: c.env.BILLING_SERVICE },
    { key: 'NOTIFICATION_SERVICE', instance: c.env.NOTIFICATION_SERVICE },
    { key: 'COMPLIANCE_SERVICE', instance: c.env.COMPLIANCE_SERVICE },
    { key: 'FRANCHISE_REPORTING_SERVICE', instance: c.env.FRANCHISE_REPORTING_SERVICE }
  ];

  await Promise.all(bindings.map(async (b) => {
    if(!b.instance) return;
    try {
      const res = await b.instance.fetch(new Request('http://internal/openapi.json'));
      if(!res.ok) return;
      const spec = (await res.json()) as any;
      merged.paths = { ...merged.paths, ...(spec.paths || {}) };
      merged.components.schemas = { ...merged.components.schemas, ...(spec.components?.schemas || {}) };
    } catch(err) {
      console.warn('Failed to fetch OpenAPI from ' + b.key);
    }
  }));

  return c.json(merged);
});

export default createFetchWrapper(app as any);
