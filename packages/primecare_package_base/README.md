# PrimeCare package base and master

One composition contract for all existing packages, with generated Dart and
JavaScript catalogs. No Flutter, HTTP or database dependency is needed by the
base. This allows future package splits without coupling the base to UI or a host.

`PackageDescriptor` identifies a source package, kind, adapter contract revision
and runtime dependencies. `PackageCatalog` validates the graph and supplies a
dependency-first order. `PackageMaster` selects one registered implementation
per ID, caches it per master instance and detects recursive factory resolution.
It does not eagerly start every package. Keep masters scoped to the lifetime
appropriate for their adapters; never cache request identities in a process-wide
adapter. Provider factories are synchronous; their returned adapters may expose
asynchronous operations. Lifecycle and HTTP hosting continue to use the existing
`BaseServiceHost` and `BaseHttpServiceHost` in `server_core`.

The catalog includes every directory with content under `packages/` and
`services/`, as present in this release. Runtime and development
dependencies are separate. Source-only directories without manifests are
identified honestly; they are not declared buildable or hosted.

## Integration

Public Dart consumers declare a dependency on the selected `primecare_master`
profile and import `package:primecare_master/primecare_master.dart`. This base
is private implementation behind that facade.

```dart
final master = PackageMaster(createPrimeCarePackageCatalog());
master.register<ClientRepository>(
  'client_api',
  contractVersion: 1,
  local: () => existingLocalRepository,
  remote: (binding) => existingAuthenticatedRemoteAdapter(binding.endpoint),
);
final repository = master.resolve<ClientRepository>('client_api');
```

The names of the application interface, repository and transport above illustrate
injection; use the existing registered service's real contract and adapters. The
base intentionally supplies no invented business API or remote implementation.

Public JavaScript/TypeScript consumers use `@primecare/master` and the generated
`@primecare/master/catalog` subpath:

```js
import {PackageMaster, remoteBinding} from '@primecare/master';
import {createPrimeCarePackageCatalog} from '@primecare/master/catalog';

const master = new PackageMaster(createPrimeCarePackageCatalog(), {
  client_api: remoteBinding(config.clientServiceOrigin, 1),
});
master.register('client_api', {
  contractVersion: 1,
  local: () => existingLocalRepository,
  remote: binding => existingAuthenticatedRemoteAdapter(binding.endpoint),
});
const repository = master.resolve('client_api');
```

Only `service` entries permit a remote binding. Libraries, models, UI, themes and
assets remain imported packages; a web host serves the compiled application.
Configuration is trusted host configuration, never client-controlled URL input.
HTTPS endpoints must contain no credentials, query or fragment. Credentials stay
in the existing authenticated transport. Configuration is copied at construction:
create a new master to change placement; an existing master does not silently
switch servers while operations are active.

The number `contractVersion` describes this composition adapter contract. It is
not proof of API schema compatibility, production registration or release review.
Unknown packages, cycles, duplicate providers, missing remote adapters and
contract mismatches fail explicitly. Remote failures never invoke the local
factory as a fallback. There is no network transport, retry policy, service URL
discovery, permission grant or authentication bypass in this package.

## Grow and split safely

1. Keep each package's public interface stable and its implementation private.
2. Add a package under `packages/` or a host under `services/` with an honest
   manifest; regenerate the master catalog. Fix missing dependencies and cycles.
3. Keep callers on their interface. For a server move, implement the existing
   contract using the approved authenticated transport and tenant context.
4. Reuse the existing server lifecycle and production release procedures. Verify
   schema compatibility, authorization, timeouts, errors, idempotency and data
   ownership before independently deploying the extracted service.
5. Select its remote binding in trusted host configuration and run integration
   and E2E tests against that exact deployment. Preserve the prior deployment and
   explicitly revert configuration when rollback is necessary.

Code placement does not split database authority or move data automatically.
Pinned production governance remains authoritative. No business registrations,
roles, grants, API routes, themes or user settings are created by the catalog.

## Regenerate and verify

Run from the repository root with Python 3 and PyYAML installed:

```sh
python3 tools/package_master/catalog.py
python3 tools/package_master/catalog.py --check
python3 -m unittest tools.package_master.test_catalog
node --test packages/primecare_package_base/test/registry.test.mjs
dart packages/primecare_package_base/test/registry_test.dart
dart analyze packages/primecare_package_base/lib packages/primecare_package_base/test/registry_test.dart
```

The generator checks exact source paths and declared names. It writes `catalog.json`,
`lib/src/package_catalog.g.dart` and `src/catalog.g.mjs` deterministically. Regenerate
after any package addition or dependency change. Keep the generated output in
source control together with the associated manifests.

## Current delivery boundary

This foundation is prepared against the restored source tree: 26 packages
(including this base and the master facade) and 13 service hosts. Its Dart and JavaScript registry tests
exercise local/remote selection using test adapters with no outbound requests.
Public application and service-host imports now enter through master gateways;
existing canonical implementations and connections are preserved. Individual
business interfaces are not automatically registered as new local/remote
factories in the composition registry. Independently
hosted servers, full migration publication and production E2E are not delivered
by these foundation tests. Do not mistake source inventory for completed rollout.
