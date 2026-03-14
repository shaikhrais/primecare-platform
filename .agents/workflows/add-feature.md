---
description: How to add a new feature end-to-end across the PrimeCare platform (Prisma, API, UI, registries)
---

# Adding a New Feature — Complete Workflow

This workflow ensures every new feature is fully integrated across all layers. Missing any step will be caught by the `FeatureIntegrityChecker`.

## Architecture Quick Reference

The platform has **8 registries** in `packages/shared/src/registries/`:

| Registry | Purpose |
|----------|---------|
| `ButtonRegistry.ts` | **Unified** interactive elements (buttons, links, interactions, touchpoints) |
| `PageRegistry.ts` | Master page catalogue (dashboards, forms, lists, hubs, wizards, reports, tools) |
| `FormRegistry.ts` | Form definitions with fields, API endpoints, and inline-creation dependencies |
| `PageActionRegistry.ts` | Maps pages → their action buttons |
| `ContentRegistry.ts` | UI strings and localized content |
| `ApiRegistry.ts` | All API endpoint path constants |
| `ThemeRegistry.ts` | CSS variable tokens for dynamic theming |
| `DataRegistry.ts` | Shared enums (roles, statuses) |

The `ButtonRegistry` is the **unified** registry for ALL interactive elements. Entries are distinguished by their `type` field:
- `'primary' | 'secondary' | 'ghost' | 'danger'` → Action buttons
- `'link'` → Navigation links (formerly `LinkRegistry`)
- `'interaction'` → Click/hover/submit triggers (formerly `InteractionARegistry`)
- `'touchpoint'` → Response Bot health-check entries (formerly `InteractiveElementRegistry`)

## Steps

### 1. Database Layer (if needed)
- Add/modify model in `apps/worker-api/prisma/schema.prisma`
- Run `npx prisma generate` and `npx prisma db push`

### 2. API Endpoint Path
- Add the endpoint constant to `packages/shared/src/registries/ApiRegistry.ts` (or the appropriate sub-file)
- Example: `YOUR_FEATURE: '/v1/admin/your-feature'`

### 3. API Route Handler
- Create route file in `apps/worker-api/src/` under the appropriate domain folder
- Use Hono + Zod OpenAPI pattern:
```typescript
import { createRoute, z } from '@hono/zod-openapi';
const route = createRoute({ method: 'get', path: '/your-endpoint', ... });
```
- Wire into the parent router

### 4. Frontend Route
- Add route path to `packages/shared/src/apps/web-admin/RouteRegistry.ts`
- Example: `YOUR_FEATURE: '/platform/admin/your-feature'`

### 5. Page Registry Entry
- Add entry to the appropriate sub-file under `packages/shared/src/registries/PageRegistry/`
- Choose the correct type: `dashboard`, `form`, `list`, `hub`, `wizard`, `detail`, `settings`, `report`, `tool`, `portal`
- If the page is a form, set `formRegistryId` to link to `FormRegistry`

### 6. Form Registry Entry (for form pages)
- Add to the appropriate sub-file under `packages/shared/src/registries/FormRegistry/`
- Include: `id`, `label`, `route`, `apiEndpoint`, `method`, `dataCyPrefix`, `fields[]`, `dependencies[]`, `category`

### 7. Button Registry Entry
- Add button to the appropriate sub-file under `packages/shared/src/registries/ButtonRegistry/`:
  - `platform-buttons.ts` — platform-level admin/scrum-master buttons
  - `tenancy-buttons.ts` — tenant-level role buttons (manager, psw, rn, etc.)
  - `operations-buttons.ts` — operational action buttons
- For navigation links, add to `LINK_ENTRIES` in `ButtonRegistry.ts` with `type: 'link'`
- For interactions, add to `INTERACTION_ENTRIES` in `ButtonRegistry.ts` with `type: 'interaction'`

### 8. Page Action Registry
- Wire buttons to the page in `packages/shared/src/registries/PageActionRegistry/`
- Example:
```typescript
'admin.your-page': { primary: 'btn-your-primary-action', actions: ['btn-secondary-1', 'btn-secondary-2'] },
```

### 9. UI Component
- Create React component in `apps/web-admin/src/app/routes/` under the correct role folder
- Use `data-cy` attributes for all interactive elements
- Import registry data: `const { ContentRegistry, RouteRegistry } = AdminRegistry;`
- Use `PcButton` component with `registryId` prop for action buttons

### 10. Content Registry
- Add UI labels to the appropriate sub-file under `packages/shared/src/registries/ContentRegistry/`

## Validation

After completing all steps, run the Feature Integrity Checker:
```
POST /scrum/registry/integrity
```

This cross-validates:
- Page → Form: every form page has a matching FormRegistry entry
- Page → Buttons: every page has at least one button in PageActionRegistry
- Button → API: every API-action button has a valid apiPath
- Form → API: every form has a valid apiEndpoint
- Form → Route: every form has a valid route
- Link → Path: every link points to a valid (non-empty) path

## File Size Rule

**No file may exceed 200 lines.** If a file grows beyond 200 lines:
1. Extract data/logic into sub-files under a directory named after the main file
2. The main file becomes a "skeleton" that imports and re-exports from sub-files
3. Example: `ButtonRegistry.ts` imports from `ButtonRegistry/platform-buttons.ts`, `ButtonRegistry/tenancy-buttons.ts`, etc.

## Helper Functions

```typescript
// Buttons & Links
getButtonById(id)              // Find any interactive element by ID
getButtonsByRole(role)          // All elements for a role
getButtonsForPage(pageCode)     // Buttons mapped to a specific page
getLinksForRole(role)           // Navigation links for a role
getTouchpointsForSweep()        // Response Bot health-check entries
getInteractionsByTrigger(type)  // Interactions by trigger type ('click', 'hover', 'submit')

// Pages
getPageById(id)                 // Page by ID
getPagesByType(type)            // Pages by type ('dashboard', 'form', etc.)
getPagesByOwner(owner)          // Pages by role owner

// Forms
getFormById(id)                 // Form by ID
getFormsByCategory(category)    // Forms by category
getFormsWithDependencies()      // Forms with inline creators

// Integrity
runIntegrityCheck()             // Full cross-registry validation report
```
