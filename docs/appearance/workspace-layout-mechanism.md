# Original PrimeCare workspace layout mechanism

Requirement: user, 2026-10-31: study the supplied theme's flexible layouts and implement equivalent mechanisms in the shared PrimeCare theme.

## Research and scope

Reviewed the user-supplied Fuse React v17 Vite skeleton archive, specifically its three layout configuration definitions, and the publisher's documentation:

- https://fuse-react-nextjs-demo.fusetheme.com/documentation/user-interface/theme-layouts
- https://fuse-react-nextjs-demo.fusetheme.com/documentation/configuration/settings
- https://fuse-react-nextjs-demo.fusetheme.com/documentation/configuration/routing
- https://fuse-react-nextjs-demo.fusetheme.com/documentation/user-interface/page-layouts/overview

The reference uses configuration-driven placement rather than unrestricted dragging of every interface element. Its principal features are vertical/horizontal navigation, navigation side/style/folding, container modes, configurable toolbar/footer, side panels and page-specific chrome. No vendor implementation, stylesheet, asset, component or dependency was copied into this change. The implementation below was written from basic DOM, CSS Grid and pointer/keyboard APIs.

| Capability | Original PrimeCare implementation in this change |
| --- | --- |
| Vertical/horizontal navigation | Left, right, top or bottom; existing navigation node is reused |
| Navigation visibility and width | Hidden option and validated 160–400px width |
| Full width, boxed, contained content | Three container modes; validated 960–1920px maximum width |
| Toolbar placement and scrolling | Top/bottom and sticky/static |
| Footer | Sticky/static/hidden; caller supplies existing footer |
| Page/content scrolling | Both modes in the core; mobile returns to page scrolling |
| Movable panels | Four docking edges, floating and hidden states |
| Pointer interaction | Drag a supplied handle; resize a supplied resize handle; cancel gesture with Escape |
| Keyboard interaction | Arrows move; Shift + arrows resize; Ctrl/Command + arrows dock |
| Undo/redo/reset | Bounded history; one history entry per pointer gesture |
| Save/restore | Caller-supplied account/tenant/role key, local browser storage or injected storage |
| Import/export | Strict data-only JSON, 32KiB maximum, allowlisted existing panel IDs |
| Mobile handling | Inline stacked panels; floating desktop coordinates preserved |
| Existing content and handlers | DOM nodes are moved, not cloned or recreated |
| Tabbed/folded navigation styling | Existing theme's compact mode remains separate; no new vendor-style tabbed navigation |
| Per-route layouts | Caller may pass separate scoped keys; automatic route policy binding is not implemented |
| Flutter renderer | Not implemented; data contract is portable, DOM renderer is web only |
| Production editor controls | Not mounted; governance registration and live interaction proof remain pending |

## Shared access

The web entry point exports `WorkspaceLayoutManager`, `defaultWorkspaceLayout`, `WorkspaceLayout`, `WorkspaceSlots` and `PanelDock`. The renderer-independent validator is `packages/domain/src/workspace_layout.ts`.

An integrating app supplies existing, authorized navigation, toolbar, main, optional footer, and panel DOM nodes. Slots must be distinct non-nested descendants of the supplied root. The engine creates structural docking containers only. It does not fetch data, create business widgets, grant permissions or change routes. Business authorization must happen before selecting the supplied panel registry, and an authorization-scope change must dispose the old manager before mounting the new scope. Original hidden attributes remain respected.

```ts
import {WorkspaceLayoutManager} from 'path/to/packages/primecare_ui/web';

const layout = new WorkspaceLayoutManager(shellElement, {
  navigation: existingNavigation,
  toolbar: existingToolbar,
  main: existingMain,
  footer: existingFooter,
  panels: permittedExistingPanels
}, `primecare-workspace:${tenantId}:${actorId}:${roleId}:${layoutScope}`);

layout.change({...layout.current, navigation: 'top', container: 'boxed'});
layout.dockPanel(permittedPanelId, 'floating');
layout.save();
// On unmount or authorization-scope change:
layout.dispose();
```

Use an already-approved focusable, labelled panel control with `data-layout-drag` or `data-layout-resize` to opt into interaction. These attributes are behavior hooks, not permissions. Caller-owned controls must expose governed `data-cy` identifiers and localized instructions. The fixture uses synthetic content and English labels only; do not ship its controls as production UI.

This engine is optional and is not mounted by the existing shared shell or Theme Center. The current `BaseLayoutManager` and its existing version-1 XML format remain unchanged. The new workspace contract is separate JSON; importing one format into the other is unsupported. Saved browser preferences do not sync across devices.

## Validation and preview

- `node --test scripts/test-workspace-layout-contract.mjs scripts/test-primecare-original-theme.mjs`
- `node scripts/test-workspace-layout.mjs` — Chromium interaction suite, including unsaved input, pointer/keyboard, cancellation, account scope, invalid input, mobile width, persistence and teardown.
- `node scripts/build-workspace-layout-preview.mjs` — rebuild the self-contained isolated preview at `docs/appearance/previews/workspace-layout.html`.

The preview is a synthetic layout laboratory, not a new business screen or production deployment. Test fixture IDs and data are isolated from production governance and contain no client records.

## Production activation gate

Repository policy in `.agents/AGENTS.md` requires: “Everything must exist in the pinned production governance database before implementation.” The policy also requires registered UI elements, localization resources and honest verification tags.

No new production controls or routes are activated by this change. A connection attempt through the existing pinned reader returned `MISSING_DATABASE_URL`. Therefore this change does not claim new production governance records, localization approval, permission bindings, Cypress success, Flutter availability or production readiness. To expose this mechanism in the live Theme Center, register the selected controls/options and EN/FR/ES resources in the pinned production database, export those approved identifiers, bind to the existing authorized shell and execute live browser/Cypress checks. Do not substitute the removed SQLite database.
