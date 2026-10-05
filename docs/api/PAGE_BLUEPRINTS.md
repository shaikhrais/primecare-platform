# Building pages from the governance API

`GET /v1/governance/page-blueprints?screen=ceo_dashboard` returns a paginated build specification from the deployed governance catalog. Use an active bearer session with existing inventory authority (CEO/governance). Optional X-Tenant-Id must match the actor. This endpoint exposes metadata, not patient records or live business data.

Supported filters: `screen` (exact screen code), `app`, `role`, `search`, `limit` (1–100), `offset` (0–100000). Duplicate or unknown parameters are rejected. A missing screen returns an empty list. Multiple pages can share a screen code: use app/role filters and the returned route to select the intended page.

```javascript
const url = new URL('/v1/governance/page-blueprints', gatewayUrl);
url.searchParams.set('screen', 'ceo_dashboard');
const response = await fetch(url, {headers: {Authorization: `Bearer ${sessionToken}`}});
if (!response.ok) throw new Error(`Blueprint request failed: ${response.status}`);
const {data, pagination, source} = await response.json();
```

Each item provides:

| Field | Builder use |
|---|---|
| screen, app, role, route | Identify the registered page |
| requirements | Business purpose, user story, acceptance criteria |
| sections | Ordered required sections and elements, types, labels, test identifiers and registered apiUsage |
| permissions | Registered view/create/edit/delete/export grants; these do not grant API authority |
| apis | Linked methods/routes, endpoint permission, implementation status, recorded health/tests, parsed request/response schemas |
| buildSteps | Requirements, layout, permissions, bindings, validation and verification checklist |
| pendingActions, blockers | Work required before completion |
| bindingEvidence, elementBindingsVerified | Registered evidence only; exact element bindings remain unverified |

Render only governed sections with approved shared components. Connect an element only when its registered apiUsage and endpoint schema establish the binding. If the mapping or schema is missing/ambiguous, register it first; do not invent field mappings. Enforce permission and tenant checks on every business endpoint. Handle loading, empty, validation, forbidden and backend error states. Complete API, browser and accessibility verification before updating readiness.

Schemas are parsed from governance.db. Missing or invalid JSON schemas are returned as null. Registered implementation/health flags are historical metadata, not live checks. The metadata catalog changes when regenerated and deployed; source.catalogVersion identifies that snapshot. Page production readiness is not promoted by this API.

Validation: 126 backend fixture tests pass locally, including exact blueprint projection/filtering, role/tenant/session denial, throttling and read-only behavior. Gateway uses the existing governance service prefix. OpenAPI: governance-batch-1.openapi.json (includes this new operation).
