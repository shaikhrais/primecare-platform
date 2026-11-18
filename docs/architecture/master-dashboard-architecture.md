# Master Dashboard architecture

**Status:** TypeScript candidate, not connected to production. The implementation currently lives in the [isolated preflight patch](../../tests/fixtures/screen-manager-structure/tenant-dialog.patch). Tenant Admin is the only adapter in this candidate. The deployed Tenant Admin pilot predates this refactor.

## Structure and ownership

```text
Pinned PostgreSQL governance + existing API authorization
  → authorized dashboard projection
  → existing route registration / ScreenManager
  → TenantAdminDashboard extends MasterDashboard
  → shared shell, layout, navigation and scoped dialogs
  → authorized feature controls and existing workflow adapters
```

| Layer | Owns | Does not own |
| --- | --- | --- |
| Governance and server API | Registered screen definitions, actor and tenant permissions, workflow validation, persistence | Browser layout or client state |
| Transport and feature controller | Existing API calls, account/session freshness, operation receipts, feature data and commands, route history, save/discard policy | Generic shell or native dialog lifecycle |
| `ScreenManager` | Exact route/ID match, presentation connections, one dashboard presentation owner per root, cleanup when a registration changes | Authentication, granting access, calling APIs |
| `MasterDashboard` | Immutable dashboard configuration, validation of projected view IDs, shared shell, search entries, layout slot binding, and disposal | Feature workflows, API endpoints, secret data, authorizing a user |
| `DashboardDialogManager` | Native dialog creation, accessible name, focus, dirty-field tracking, dismissal and teardown | Navigation history, role checks, or permission to discard or submit |
| Thin feature subclass | Passes the existing catalog to `super` | Copying layout/navigation logic or adding local grants |

Inheritance is for the stable presentation entry point. Inside the base class, services are composed rather than stacked in an inheritance hierarchy. One behavior change can benefit inheriting dashboards after verification; an unmigrated dashboard is not changed.

### Candidate files

- `packages/primecare_ui/web/master-dashboard.ts`: protected constructor, `allowedViews(projection)`, `mount(binding)`, `dispose()`.
- `packages/primecare_ui/web/screen-manager.ts`: attaches the scoped dialog owner to an existing registered route.
- `packages/primecare_ui/web/dashboard-dialog-manager.ts`: native panel ownership and lifecycle.
- `websites/typescript/src/tenant-dashboard/dashboard-presentation.ts`: the thin Tenant Admin subclass.
- `websites/typescript/src/tenant-dashboard/index.ts`: feature data/commands, route history, policies and binding. Existing feature adapters are preserved.

## Adding or migrating a dashboard

1. Find the existing governed route, stable screen code, title, and view IDs. Do not create a parallel registry or infer a grant from catalog membership.
2. Extend `MasterDashboard` and pass that catalog to `super`. Existing presentation helpers build the authorized content. Do not copy shell markup, search behavior, or modal handlers into the subclass.
3. Feed the existing server-authorized view projection into `allowedViews` before choosing the active view. The existing controller owns the choice of default view and history. Supply active view, locale, account-scoped preference identity, named panel selectors, existing shell content, and a current-owner callback to `mount`.
4. Keep reads and writes in the feature controller and API adapter. Include authorized readback after a change. Keep pending-save and discard rules explicit. Do not make a panel responsible for mutating data.
5. Call `dispose` from the existing feature teardown. Keep old routes and compatibility adapters until the replacement has passed acceptance.

Existing Tenant Admin pattern:

```ts
export class TenantAdminDashboard extends MasterDashboard {
  constructor(root: HTMLElement, manager: ScreenManager,
    entry: Pick<ScreenRegistration, 'id' | 'route'>,
    panels: DashboardDialogOptions) {
    super(root, manager, entry, catalog, panels);
  }
}
```

The catalog is a declaration, not a capability token. A projection with unknown or duplicate view IDs, an unregistered route, or a duplicate active owner fails rather than falling back to broader access. The controller still has to suppress stale responses and recover safely from session or tenant changes. A panel host never grants access to data.

## Verification and rollout

- **Shared contract:** test valid subsets, missing/duplicate IDs, scope replacement, duplicate owners, subclass inheritance and disposal. Ordinary catalog-only changes should reuse these checks, not create a separate dashboard test framework.
- **Real web flow:** GitHub acceptance drives the Tenant Admin portal and existing API against a disposable PostgreSQL fixture. Preserve real click/keyboard, back/forward, unsaved draft, focus, readback, and tenant/actor behavior. Test clean browser storage separately from customized preferences. Do not treat a passing compile or rendered screenshot as acceptance.
- **Phone/tablet:** the web matrix checks Android phone/tablet in Chromium, and iPhone/iPad in WebKit, for touch, fit and accessible panel behavior. These are emulated browsers, not native Flutter or signed app tests. Android and Apple native acceptance remain separate; do not claim native support from this TypeScript candidate.
- **Release:** use exact-commit evidence and keep compatibility with the last known-good build. No production credential is used by this preflight. No next dashboard migration until the first adapter has passed relevant acceptance. Publishing the candidate needs the existing release gates and explicit rollout scope.

**Evidence:** [current preflight run](https://github.com/shaikhrais/primecare-platform/actions/runs/44228827957) · [previous production pilot release](https://github.com/shaikhrais/primecare-platform/actions/runs/44221091230). These are different commits and milestones.
