import { OpenAPIHono } from '@hono/zod-openapi';
import { createFetchWrapper, registerStandardMiddleware } from '@primecare/infrastructure';
import authRoutes from './auth/auth.routes';
import userRoutes from './user/user.routes';
import { Bindings, Variables } from '@primecare/contracts';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Infrastructure Standard Setup - Enforces CSRF, Tenant Isolation, and Prisma context
registerStandardMiddleware(app as any);

// Mount routes to match the gateway's expected structure
app.route('/api/v1/auth', authRoutes);
app.route('/api/v1/user', userRoutes);

// Compatibility fallback for direct /v1/auth calls
app.route('/v1/auth', authRoutes);
app.route('/v1/user', userRoutes);

app.get('/', (c) => c.text('PrimeCare Auth Service Operational'));
app.get('/health', (c) => c.json({ status: 'healthy', service: 'auth-api' }));

export default createFetchWrapper(app as any);
