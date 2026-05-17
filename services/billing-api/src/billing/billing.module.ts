import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requireAuth, requireRole } from '@primecare/security';
import journalRoutes from './finance/ledger/journal.routes';

const billingModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// ── Authentication Layer ─────────────────────────────────────────────────────
billingModule.use('*', async (c, next) => {
  const secret = c.env.JWT_SECRET;
  if (!secret) return c.json({ error: 'Server configuration error' }, 500);
  return await requireAuth(secret)(c, next);
});

// ── Financial Ledger Module (High Authority Guard) ───────────────────────────
// R2: Secure the Journal and P&L endpoints for the Finance Director role hierarchy
billingModule.use('/ledger/*', async (c, next) => {
  return await requireRole('FINANCE_DIRECTOR')(c, next);
});

billingModule.route('/ledger', journalRoutes);

export default billingModule;
