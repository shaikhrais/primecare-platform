---
description: How to add a new feature end-to-end across the PrimeCare platform (Prisma, API, UI, registries)
---

# Add Feature Workflow

## Quick Start (Scaffold CLI)

The fastest way to add a new feature is the scaffold CLI:

```bash
# turbo
node scripts/scaffold-feature.mjs --name <FeatureName> --role <role> --type full
```

This generates: page component, barrel export, API handler, test stub, and prints registry snippet instructions.

**Options:**
- `--name` — PascalCase name (required), e.g. `ShiftSwap`
- `--role` — Target role: admin, psw, rn, coordinator, manager, client, staff
- `--type` — `page` | `api` | `test` | `full` (default: full)
- `--dry` — Preview without writing files

## Manual Steps (after scaffold or from scratch)

### 1. Database Layer

Add a Prisma model if the feature needs persistence:

```
// turbo
npx prisma format
```

### 2. API Registry

Add the endpoint path to `packages/shared/src/apps/web-admin/ApiRegistry.ts`:

```typescript
YOUR_FEATURE: '/v1/<role>/your-feature',
```

### 3. API Route Handler

If not using scaffold, create `apps/worker-api/src/tenancy/<feature>/index.ts`:

```typescript
import { Hono } from 'hono';
import { requirePermission } from '../../_shared/middleware/rbac';

const app = new Hono();
app.get('/', requirePermission('view_dashboard'), async (c) => {
    return c.json({ data: [] });
});
export default app;
```

Wire it into the parent Hono app in `apps/worker-api/src/tenancy/index.ts`:

```typescript
import yourFeature from './your-feature';
app.route('/your-feature', yourFeature);
```

### 4. Route Registry

Add the frontend route to `packages/shared/src/apps/web-admin/RouteRegistry.ts`:

```typescript
YOUR_FEATURE: '/<role>/your-feature',
```

### 5. Permission Registry (if new permission needed)

Add to `packages/shared/src/registries/PermissionRegistry.ts`:

1. Add the permission string to the `Permission` type
2. Add it to the relevant role(s) in `ROLE_PERMISSIONS`

### 6. Button Registry (sidebar link)

Add to `LINK_ENTRIES` in `packages/shared/src/registries/ButtonRegistry.ts`:

```typescript
{ id: 'lnk-<role>-your-feature', label: 'Your Feature', role: '<role>',
  module: '<MODULE>', type: 'link', action: 'UI_NAVIGATION',
  path: RouteRegistry.YOUR_FEATURE, description: '...' },
```

### 7. Page Component

If not using scaffold, create `apps/web-admin/src/app/routes/<routeGroup>/pages/<feature>/`:

- `YourFeature.tsx` — main component using `useRegistryQuery`
- `index.tsx` — barrel re-export

### 8. Route Wiring

Add lazy import + `<Route>` to the appropriate routes file (e.g., `AdminRoutes.tsx`):

```typescript
const YourFeature = lazy(() => import('./pages/your-feature'));
// Inside <Routes>:
<Route path="your-feature" element={<YourFeature />} />
```

### 9. Tests

If not using scaffold, create `apps/web-admin/src/test/YourFeature.test.ts`.

### 10. Verify & Deploy

```bash
# turbo
cd apps/web-admin && npx vitest run
```

```bash
cd apps/web-admin && npm run deploy
```

```bash
cd apps/worker-api && npm run deploy
```
