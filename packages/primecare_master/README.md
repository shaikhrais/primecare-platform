# PrimeCare master web entry

The nine currently hosted TypeScript portals import private PrimeCare code through
this package's generated `web/` gateways. Existing class names, method names,
named/default exports and import aliases remain unchanged. Gateways re-export the
canonical implementation; they do not duplicate models or change authenticated
transports, URLs, tenant restrictions or permissions.

`node tools/package_master/web_boundary.mjs` verifies every web consumer import,
registered gateway and private-package dependency direction. `--write` changes
only import module specifiers; existing names and application logic stay intact.
The catalog and composition registry are exposed by `@primecare/master` and
`@primecare/master/catalog`. The base registry permits explicit local or remote
service adapters without silently falling back after a remote failure.

This release covers the live TypeScript web portals. The separately reconstructed
Flutter apps and Dart service hosts are not part of this publication. Their full
master-only migration remains in the integration checkpoint until its independent
migration and release checks pass. Existing production API Workers remain the
portals' backend.


## Developer kitchen-sink entry points

The master now forwards the three private kitchen-sink packages. Use
`@primecare/master/kitchen-sink` in browser build hosts and
`package:primecare_master/kitchen_sink.dart` in the Flutter example host. Shared
factory names and canonical types are retained. The Dart manifest is currently a
Flutter developer profile; existing service-host migration is still pending.
See [package structure](../../docs/architecture/package-structure.md) for all 20
source packages, 13 service hosts, ownership and the dependency direction.
