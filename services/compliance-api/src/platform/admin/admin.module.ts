/**
 * Admin Module — Federated Domain Architecture
 *
 * Previously: 44 direct imports, duplicate route mounts, God Module.
 * Now: 6 domain sub-apps, each with clear ownership.
 *
 * Domain Sub-Apps:
 *   /v1/admin/*  (core)     → users, settings, search, registries, staff-groups
 *   /v1/admin/*  (ops)      → visits, timesheets, incidents, clients, leads
 *   /v1/admin/*  (clinical) → evv, consent, authorizations, pharmacy, discharge
 *   /v1/admin/*  (finance)  → financial, payroll, claims, erp
 *   /v1/admin/*  (content)  → content, dam, marketing, telehealth
 *   /v1/admin/*  (infra)    → system-data, webhooks, cron, interop, ai-iot
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requireAuth } from '@primecare/security';
import { requireRole } from '@primecare/security';;

// Domain Sub-Apps
import coreApp from './domains/core.app';
import clinicalApp from './domains/clinical.app';
import financeApp from './domains/finance.app';
import opsApp from './domains/ops.app';
import contentApp from './domains/content.app';
import infraApp from './domains/infra.app';

// Inline OpenAPI route handlers (too small to be their own sub-app)
import { statsRoute, handleAdminStats } from './admin-stats';
import { opsCenterRoute, handleOpsCenter } from './ops-center';

const admin = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// ── Admin module-level middleware ────────────────────────────────────────────
admin.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
admin.use('*', requireRole(['admin']));

// ── Mount Domain Sub-Apps ───────────────────────────────────────────────────
// Each sub-app owns its own route namespace.
// Routes are mounted at the admin root so existing paths are preserved.
// e.g., core.app registers '/users' → final path is /v1/admin/users (unchanged)
admin.route('/', coreApp);
admin.route('/', opsApp);
admin.route('/', clinicalApp);
admin.route('/', financeApp);
admin.route('/', contentApp);
admin.route('/', infraApp);

// ── Inline Stats/Ops Routes ─────────────────────────────────────────────────
admin.openapi(statsRoute, handleAdminStats);
admin.openapi(opsCenterRoute, handleOpsCenter);

export default admin;
