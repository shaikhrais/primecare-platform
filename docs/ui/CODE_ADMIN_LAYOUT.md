# Code Admin visual composition

Define the frame first and place existing content into it. `code-admin-layout.ts` owns the page title, breadcrumb, content canvas and grouping of already-visible navigation links. `platform-admin.ts` continues to own permissions, selected tenant, screen data, business actions and existing test IDs.

| Zone | Layout | Content fitted into it |
| --- | --- | --- |
| Navigation | 256px desktop rail; existing compact/right/mobile settings retained | Organization, Business, Tools and My account groups; existing permitted links only |
| Utilities | Compact top bar | Universal search, tenant icon, language flag, More menu |
| Page header | Breadcrumb, icon, title and description | Current screen identity, separated from account role |
| Content | Bounded 1320px canvas; 12-column grid | Existing dashboard, tenant/account/master forms, tables, audit, reports, operations, territories, bundle, training, calls, Vapi and Account |
| Dashboard | Full-width overview and metrics; two organization setup panels below | Existing API-derived totals and activity, unchanged source data |
| Forms/tables | Two-column fields where space allows; contained table overflow | Existing handlers, inputs, confirmations and authorization |
| Small screen | Single-column content, existing mobile sidebar | Full labels, 44px controls and no page overflow |

The shared solid theme supplies colours and panel edges. This composition does not add a route, permission, domain operation or data source. Empty counters and unavailable data remain explicit. The beginner guide remains visible from the dashboard and within Training. Business panels mount in the common content canvas, rather than appending outside the frame. Screenshots and browser checks are produced by the Code Admin appearance workflow.
