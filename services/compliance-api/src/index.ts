import { OpenAPIHono } from '@hono/zod-openapi';
import { createFetchWrapper, registerStandardMiddleware } from '@primecare/infrastructure';
import { Bindings, Variables } from '@primecare/contracts';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Register all standard infrastructure middleware (CORS, Error Handling, CSRF, Tenant Isolation, Input Sanitization)
registerStandardMiddleware(app as any);

app.get('/', (c) => c.text('PrimeCare Compliance Service Operational'));
app.get('/health', (c) => c.json({ status: 'healthy', service: 'compliance-api' }));

// Wrap the entry point with our standard resilience fetch wrapper
export default createFetchWrapper(app as any);
