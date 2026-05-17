import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requireAuth, requireRole } from '@primecare/security';
import registerRoutes from './routes/register';
import loginRoutes from './routes/login';
import sessionRoutes from './routes/session';
import adminRoutes from './routes/admin';
import onboardRoutes from './routes/onboard';
import osmRoutes from './routes/osm';
import forgotPasswordRoutes from './routes/forgot-password';

const authModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// ── Public Routes (No Auth Required) ─────────────────────────────────────────
authModule.route('/', loginRoutes);
authModule.route('/', registerRoutes);
authModule.route('/', forgotPasswordRoutes);

// ── Protected User Routes (Auth Required) ────────────────────────────────────
authModule.use('*', async (c, next) => {
  const secret = c.env.JWT_SECRET;
  if (!secret) return c.json({ error: 'Server configuration error' }, 500);
  
  // Public routes check (skip auth)
  const path = c.req.path;
  const isPublic = path.includes('/login') || path.includes('/register') || path.includes('/forgot-password');
  
  if (isPublic) {
    return await next();
  }

  return await requireAuth(secret)(c, next);
});

authModule.route('/', sessionRoutes);
authModule.route('/', onboardRoutes);
authModule.route('/', osmRoutes);

// ── Administrative Routes (High Authority Guard) ─────────────────────────────
// R6: Secure Administrative entry point with strict hierarchical RBAC
authModule.use('/admin/*', async (c, next) => {
  // Already passed requireAuth above
  return await requireRole('ADMIN')(c, next);
});
authModule.route('/admin', adminRoutes);

export default authModule;
