# Central business core and file hierarchy

The runtime parents now cover app roots, UI controllers, Dart hosts and HTTP
pipelines, plus the repeated business-service, repository, model-identity and
permission-cache behavior. Each runtime has its own parent hierarchy. Public
imports remain compatible through small export files at the old paths.

| Layer | Implementation directory | Shared parent | Product responsibility |
| --- | --- | --- | --- |
| App root | primecare_ui/lib/src/application | BasePrimeCareApp | Router, title, tenant branding |
| UI controller | flutter_core/lib/src/controllers | BaseDashboardController / BaseScaffoldController | State type, endpoint, implemented workflow |
| Business service | flutter_core/lib/src/application/services | BaseBusinessService / BasePreferenceService | Existing operation, projection, telemetry events and fallback |
| Repository | flutter_core/lib/src/infrastructure/repositories | BaseApiRepository | Response contract and domain-specific query |
| Identity model | flutter_core/lib/src/domain/models | BaseEntity | Identity type, fields, parser, serialization, equality |
| Response envelope | flutter_core/lib/src/domain/models | BaseResponseEnvelope | Concrete response factory and validation |
| UI permission policy | flutter_core/lib/src/security/policies | BasePermissionPolicy | Cache/endpoint names, synchronization and established fallback |
| Dart API host | server_core/lib/src | BaseServiceHost / BaseHttpServiceHost | Initialization, routes and ordered middleware policy |
| Worker API/gateway | cloudflare/workers/src/core | BaseWorker | Existing domain handlers and verified authority checks |

Import `package:flutter_core/business_core.dart` for the new extension points.
Existing service/model/repository imports continue to expose the same names.
ProviderProfile and ReportData now live with domain models; their former service
imports also export those models. Factories, constructor parameter names, JSON
keys, endpoint strings, HTTP methods, payloads, projections, telemetry messages and
existing result/fallback behavior are preserved by a pinned transformation check.

## Central control

BaseGuardedService owns asynchronous Result.guardFuture behavior and the injected
telemetry dependency. BaseBusinessService owns the injected ApiRepository;
BasePreferenceService owns the injected SharedPreferences. Business HTTP calls
use the inherited repository forwarders, so shared transport changes apply across
these services. They do not store a
current user or tenant globally. Concrete methods retain their approved behavior.
No new workflow success or completion is inferred from this source refactor.

BaseApiRepository owns the injected ApiClient and the five existing HTTP method
forwarders. It adds no owner IDs, tenant claims, query parameters or caching rules.
OwnNotificationsRepository retains a narrow public load interface and factory;
its private implementation inherits transport access and retains its complete
response validation/projection. Existing provider-profile and transport tests
continue to verify their original contracts through compatibility imports.

BaseEntity stores a typed identity in one place. Eleven existing identity-bearing
models inherit it; their factories, toJson methods and copy methods remain local.
Models without that common identity, generated/freezed models and unrelated data
shapes retain their existing types. BaseResponseEnvelope centralizes the four
existing domain-envelope fields and their JSON output without inventing a generic
parser for all model shapes.

BasePermissionPolicy owns permission-cache loading, remote synchronization,
serialization and fallback mechanics. RoutePermissionPolicy supplies the existing
RouteGuard integration and immutable PermissionPolicyConfiguration. Default names
remain primecare_role_permissions and systemPermissions. This is a UI navigation
policy: backend checks remain the source of access authority. Existing fallback
behavior is retained and is not a new backend grant.

Backend role, source-limit and rate-limit policy data remain in their existing
account-policy.json, auth-source-policy.json and auth-security-policy.json files.
Their verified consumers retain permission/tenant/ownership and transaction checks.
MFA, session handling, interception, custom controllers and bespoke workflows keep
their distinct protocols; no security implementation is replaced by an empty base.

## Extension rules

1. Add domain data models under src/domain/models. Inherit BaseEntity when the
   model has the same typed identity contract; keep schema validation explicit.
2. Add data access under src/infrastructure/repositories. Inherit transport access
   from BaseApiRepository and validate the exact server envelope in the repository.
3. Add application workflows under src/application/services. Inherit dependency and
   result handling; use existing endpoint configuration and verified operations.
4. Add UI permission policies under src/security/policies. Supply explicit cache,
   endpoint and fallback configuration; never make UI policy a server authority.
5. Keep stable public exports when moving existing types. Change callers only when
   their contract changes deliberately, with relevant workflow tests.
6. Extend central registry/configuration where an existing runtime already owns it.
   Preserve domain-specific authorization and transactions in the approved handlers.

## Verification and remaining scope

core-layer-migration.json pins twelve original files and enumerates allowed
extractions. check-core-layer-migration.py reconstructs expected code from the
pinned commit and compares tokens after formatting, including split model/service
files and compatibility exports. Existing controller/HTTP/app-root checks remain.

This migration organizes common mechanisms across the requested layers. It does
not move every bespoke/generated feature file or complete pending API contracts.
Known scaffold workflows and simulated legacy services retain their implementation
status. Additional behavior changes require their defined authorization and tests;
no API completion is counted for rearranging files or adding inheritance.
