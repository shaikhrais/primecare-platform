import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { registerStandardMiddleware, createFetchWrapper } from '@primecare/infrastructure';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// R23: Apply Infrastructure Standard Security Mesh
registerStandardMiddleware(app);

app.get('/', (c) => c.text('Hello from scheduling-service (Standardized)'));

export default createFetchWrapper(app as any);
