# Shared skeleton equivalents: source reconciliation

Seven reviewed proposal mappings resolve to existing original PrimeCare web and Flutter APIs. The historical developer catalogue marks six of these missing because their proposal source lists are empty; that does not mean these shared implementations are absent. This report adds current API mappings without changing historical proposal hashes or granting acceptance.

| Reference capability | Shared web API | Shared Flutter API | Supported subset |
|---|---|---|---|
| `core.FuseCountdown` | `countdown(` | `class PrimeCountdown ` | Absolute deadline; expiry once; disposal |
| `core.FuseDialog` | `modal(` | `class PrimeCatalogueModal ` | Owned modal; confirmation; focus return |
| `core.FuseExample` | `preview(` | `Widget preview(` | Caller-created preview; no dynamic source execution |
| `core.FuseHighlight` | `code(` | `class PrimeCodePreview ` | Literal code tokens and copy; no HTML execution |
| `core.FuseLoading` | `state(` | `Widget state(` | Loading state using active shared theme |
| `core.FuseSplashScreen` | `state(` | `Widget state(` | Splash variant of scoped loading state |
| `core.FuseSuspense` | `asyncRegion<` | `class PrimeAsyncBoundary<` | Scoped asynchronous loading/error/empty/content states |

Web owner: `packages/primecare_ui/web/component-catalogue.ts`. Flutter owner: `packages/flutter_core/lib/component_catalogue/prime_component_catalogue.dart`. Public Flutter entry: `package:primecare_ui/component_catalogue.dart`.

Use the existing scoped factory/kit and governed labels. Reuse the existing implementation rather than creating a per-app copy. Source availability is unverified for current runtime adoption. Each feature still requires its host binding, role/API decisions where applicable, localization/accessibility review and current native/browser acceptance. Vendor variants and whole-feature parity are not implied. No new registration, grant, route, production activation or ready-screen credit is created.

Reproduce: `python3 scripts/audit-shared-skeleton-equivalents.py --check`. Behavior tests remain in the existing component-catalogue web/native suites.
