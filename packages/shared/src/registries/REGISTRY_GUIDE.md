# PrimeCare Registry Architecture Guide

## Registry Overview (8 Files)

| Registry | Purpose | Entry Count |
|----------|---------|-------------|
| `ButtonRegistry.ts` | **Unified** interactive elements (buttons, links, interactions, touchpoints) | ~200+ |
| `PageRegistry.ts` | Master page catalogue (dashboards, forms, lists, hubs, etc.) | All pages |
| `FormRegistry.ts` | Form definitions with fields, API endpoints, dependencies | All forms |
| `PageActionRegistry.ts` | Maps pages → action buttons | Per page |
| `ContentRegistry.ts` | UI strings and localized content | All labels |
| `ApiRegistry.ts` | API endpoint paths | All endpoints |
| `ThemeRegistry.ts` | CSS variable keys for dynamic theming | Theme tokens |
| `DataRegistry.ts` | Shared enums (roles, statuses, provinces) | Static data |

> **Supporting:** `CorsRegistry.ts` (CORS config), `FeatureIntegrityChecker.ts` (validation)

---

## The Unified ButtonRegistry

### Before (5 separate files, now deleted)

```
ButtonRegistry.ts    → ButtonDef      { id, label, role, module, type, action, apiPath }
LinkRegistry.ts      → LinkDef        { id, label, role, module, path }
InteractionARegistry → InteractionADef { id, label, role, module, trigger, consequence }
InteractiveElementRegistry → InteractiveElement { id, label, role, module, checkType }
InteractiveRegistry.ts     → Re-export wrapper (no data)
```

**Problem:** ~500 redundant field declarations. Same `id, label, role, module, description` repeated everywhere.

### After (1 unified file)

```typescript
interface ButtonDef {
    // ── Core (always present) ──
    id: string;
    label: string;
    role: string;
    module: string;
    action: string;
    description: string;

    // ── Type discriminator ──
    type: 'primary' | 'secondary' | 'ghost' | 'danger'  // action buttons
        | 'link'                                          // navigation (was LinkRegistry)
        | 'interaction'                                   // triggers (was InteractionARegistry)
        | 'touchpoint';                                   // health checks (was InteractiveElementRegistry)

    // ── Button-specific ──
    apiPath?: string;
    routeKey?: string;
    routeParams?: string[];

    // ── Link-specific (type: 'link') ──
    path?: string;
    isExternal?: boolean;

    // ── Interaction-specific (type: 'interaction') ──
    trigger?: 'click' | 'hover' | 'submit';
    consequence?: string;
    target?: string;

    // ── Touchpoint-specific (type: 'touchpoint') ──
    checkType?: 'ROUTE' | 'API' | 'EXTERNAL';
    expectedStatus?: number;
    category?: 'button' | 'link' | 'submit' | 'tab' | 'navigation' | 'action';
}
```

### Backward Compatibility

Old imports still work — they're exported as aliases:

```typescript
import { LinkRegistry } from 'prime-care-shared';         // ✅ Still works
import { InteractionARegistry } from 'prime-care-shared';  // ✅ Still works
import { ButtonRegistry } from 'prime-care-shared';        // ✅ Contains EVERYTHING
```

---

## How to Add New Features

### Adding a Navigation Link

Add to `LINK_ENTRIES` in `ButtonRegistry.ts`:

```typescript
{ id: 'lnk-your-feature', label: 'Your Feature', role: 'admin', module: 'YOUR_MODULE',
  type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.YOUR_FEATURE,
  description: 'Description of what this link does.' },
```

### Adding an Action Button

Add to the appropriate sub-file (`platform-buttons.ts`, `tenancy-buttons.ts`, or `operations-buttons.ts`):

```typescript
{ id: 'btn-your-action', label: 'Do Something', role: 'admin', module: 'YOUR_MODULE',
  type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.ADMIN.YOUR_ENDPOINT,
  description: 'What this button does.' },
```

Then wire it to a page in `PageActionRegistry`:

```typescript
'admin.your-page': { primary: 'btn-your-action', actions: [] },
```

### Adding an Interaction

Add to `INTERACTION_ENTRIES` in `ButtonRegistry.ts`:

```typescript
{ id: 'ia-your-interaction', label: 'Trigger Something', role: 'admin', module: 'YOUR_MODULE',
  type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger',
  target: ApiRegistry.ADMIN.YOUR_ENDPOINT, description: 'What this interaction does.' },
```

---

## Complete Feature Checklist

When building a new feature, ensure ALL layers are connected:

| # | Layer | File | What to Add |
|---|-------|------|-------------|
| 1 | **Database** | `prisma/schema.prisma` | Model definition |
| 2 | **API Endpoint** | `ApiRegistry.ts` | Endpoint path constant |
| 3 | **API Route** | `worker-api/src/` | Hono route handler |
| 4 | **UI Route** | `RouteRegistry.ts` | Frontend route path |
| 5 | **Page** | `PageRegistry/` | Page entry with type and owner |
| 6 | **Form** | `FormRegistry/` | Form fields, API endpoint, dependencies |
| 7 | **Button** | `ButtonRegistry/` | Action button(s) for the page |
| 8 | **Page Actions** | `PageActionRegistry/` | Wire buttons → page |
| 9 | **UI Component** | `web-admin/src/` | React component with `data-cy` |
| 10 | **Content** | `ContentRegistry/` | UI labels and strings |

### Automated Validation

Run the integrity checker to catch missing steps:

```
POST /scrum/registry/integrity
```

Returns:

```json
{
  "errors": [
    { "category": "MISSING_FORM", "message": "Page 'admin.intake' references form 'intake.admission' but it doesn't exist" }
  ],
  "warnings": [
    { "category": "MISSING_BUTTON", "message": "Page 'admin.reports' has no buttons in PageActionRegistry" }
  ],
  "summary": {
    "pages": 85,
    "buttons": 120,
    "forms": 45,
    "orphanButtons": 3
  }
}
```

---

## Helper Functions

```typescript
// Buttons
getButtonById('btn-admin-user-invite')     // Find button by ID
getButtonsByRole('admin')                   // All buttons for a role
getButtonsForPage('admin.dashboard')        // Buttons mapped to a page
getLinksForRole('manager')                  // Navigation links for a role
getTouchpointsForSweep()                    // Response Bot touchpoints
getInteractionsByTrigger('click')           // Interactions by trigger type

// Pages
getPageById('admin.dashboard')              // Page by ID
getPagesByType('form')                      // All form pages
getPagesByOwner('rn')                       // All RN pages

// Forms
getFormById('auth.login')                   // Form by ID
getFormsByCategory('admin')                 // Admin forms
getFormsWithDependencies()                  // Forms with inline creators

// Integrity
runIntegrityCheck()                         // Full cross-registry validation
```
