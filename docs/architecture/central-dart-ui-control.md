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

Dart service initialization and routes remain in each host's createHandler. Shared
startup chooses PORT/default port and starts the listener. Existing logging and CORS
order are retained. Dockerfiles use repository-root context and copy both shared
packages; Compose contexts are updated for these Dart services. No deployment is
performed by this source refactor.

## Extend the hierarchy

Import package:flutter_core/controllers.dart for UI parents. A live dashboard
subclass supplies initialState and endpoint; its state implements create. A scaffold
subclass stays non-executable until its approved workflow is implemented. Do not
override inherited loading/action methods to bypass the shared lifecycle.

Import package:server_core/server_core.dart for a Dart service host. Implement
createHandler and optionally onStarted; preserve authorization in handler middleware
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
