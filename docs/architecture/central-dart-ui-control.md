# Central Dart and UI control

This migration moves 1,161 repeated controllers and all 13 Dart service launchers
onto shared parents. It retains public class/provider/state identities, dashboard
endpoint strings, Dart route ordering, SQL literals and default service ports.
The existing Worker hierarchy remains the TypeScript backend foundation.

| Layer | Shared parent | Feature responsibility |
| --- | --- | --- |
| Dashboard state | DashboardState | Concrete state factory preserves its type |
| Dashboard controller | BaseDashboardController | Existing read endpoint and initial state |
| Scaffold controller | BaseScaffoldController | Concrete name/provider only; unsupported actions fail |
| HTTP service pipeline | BaseHttpServiceHost / BaseCorsServiceHost | Ordered middleware policy and route creation |
| Dart service host | BaseServiceHost | Existing handler, middleware, initialization and startup log |
| Worker host | BaseWorker | Existing ServiceWorker/GatewayWorker hooks |
| Flutter screen | Existing governed widget classes | Feature layout and declared requirements |

## Central behaviour

Dashboard loading, success/error transitions, refresh, disposal and response
ordering now live in one file. Passing error: null clears an old error; omitting
error preserves it. Late responses cannot overwrite a newer refresh, and disposed
controllers never publish late state. Existing ApiClient remains the network
adapter and backend handlers remain the authority for permissions and tenant scope.

The 651 scaffold controllers previously returned synthetic success and action
completion after timers. They now publish not_implemented with disabled/not-loaded
flags and return an UnsupportedError state for actions. No endpoint, write or grant
is invented. These are scaffold migrations, not completed business workflows.

Dart service initialization and routes remain in each HTTP host's createRoutes.
BaseHttpServiceHost builds the middleware pipeline centrally. BaseCorsServiceHost
retains the former default CORS policy for ten APIs. Auth keeps logging only;
gateway keeps its configured origin/credentials/headers; governance retains its
custom CORS middleware before logging. Route authorization remains unchanged. Shared
startup chooses PORT/default port and starts the listener. Existing logging and CORS
order are retained. Dockerfiles use repository-root context and copy both shared
packages; Compose contexts are updated for these Dart services. No deployment is
performed by this source refactor.

## Extend the hierarchy

Import package:flutter_core/controllers.dart for UI parents. A live dashboard
subclass supplies initialState and endpoint; its state implements create. A scaffold
subclass stays non-executable until its approved workflow is implemented. Do not
override inherited loading/action methods to bypass the shared lifecycle.

Import package:server_core/server_core.dart for a Dart service host. Extend BaseHttpServiceHost or BaseCorsServiceHost and implement
createRoutes and optionally onStarted; preserve authorization in handler middleware
and business services. Never put current actor/tenant into a shared singleton.

The old nuke_and_restore_controllers.js command now validates the hierarchy rather
than deleting/recreating reviewed controllers. Two pinned migration manifests and
check-controller-inheritance.py track original identity and compatibility. The
compile harness imports all 1,161 controllers and checks their public providers,
concrete state factories and unsupported scaffold actions.

## Remaining scope

One custom executive control-center controller is excluded because it has a distinct
state/workflow. Feature models, custom controllers, layouts, repositories and domain
transactions retain their current types. Some existing routes remain scaffolds.
This migration does not certify complete business implementation, all-app builds,
new API completion, changed permission policy or production readiness. Further
extraction must follow verified contracts and tested workflow equivalence.

## Application root inheritance

All eight product roots inherit BasePrimeCareApp, which owns MaterialApp router
construction, localization binding and shell placement. BaseThemedPrimeCareApp
adds PrimeTheme; BaseStandardPrimeCareApp retains telemetry draining for client,
support, franchise, marketing and business development. Clinic retains its tenant
theme without a shell boundary, corporate retains its branding without PrimeTheme,
and governance retains light mode. Product router providers, class names and main
bootstrap/application overrides are unchanged. The separate enterprise blueprint
demo remains excluded. The pinned app-shell migration check verifies this boundary.
