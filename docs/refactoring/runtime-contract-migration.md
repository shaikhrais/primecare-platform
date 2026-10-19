# Shared runtime contracts and Flutter class files

The pure Dart primecare_models package now owns AuthState, its eight-field
BaseAuthenticationState parent, the sealed Result/Success/Failure hierarchy,
AuraEvent and the existing AuraEventType and ExecutionGateCategory enums.
AuraEvent inherits BaseEntity<String>. Result subclasses live in separate part
files so the sealed hierarchy stays inside one Dart library. Legacy Flutter
imports re-export the canonical types, retaining type identity for existing UI
and new Dart API consumers. Constructor defaults, nullable copy semantics,
error/value identity, enum order and borrowed event metadata are preserved.

AuthNotifier moves into an application controller part file. The original
public authProvider, authListenable, session revision checks, persistence queue,
logout revocation and route lookup remain in the same library. Storage and
Riverpod stay in Flutter. AuthState is presentation state; it does not replace
server authorization or verify bearer tokens.

AuraCommandService, AuraPulseService, AuraBehavioralTelemetry and
IntelligenceService have individual application service files. Existing imports
and the behavioral telemetry provider remain valid. IntelligenceService inherits
the existing BaseGuardedService, using its telemetry reference and guard method.
Its 800 ms delay, rule outputs, telemetry failure fallback and synthesized
occupancy message remain unchanged. Aura heartbeat timers, randomness and mock
predictions retain their original behavior and placeholder status.

The five existing Aura scalar controllers now have individual class files and
inherit BaseValueNotifier<T> for build/update lifecycle. Each declares its
original initial value. AuraPulseEventNotifier keeps its non-null update argument
through a covariant override. Provider creation, disposal and computed callbacks
remain at the original entry point; no provider declaration is regenerated.
ExecutionGateService moves to an infrastructure telemetry part file. Its debug
output and provider remain unchanged. These telemetry gates are logging hooks,
not newly enforced authorization rules.

scripts/refactor_runtime_contracts.py reproduces and verifies all moved source
from af61336bac522e2ab4a82cd61c562f2a57807258. The migration has six shared
classes, two shared enums, eleven Flutter class files and two new parents.
No screens, routes, permission grants or completed workflows are added.

Validation compares 1,127 authentication/result/event cases to pinned source.
Flutter comparisons cover 443 commands plus 12 suggestion contexts, scalar
provider lifecycle, pulse start/stop and 36 intelligence output/telemetry cases.
Legacy-import tests verify canonical types and provider identity. Existing auth
session, route guard, transport and telemetry tests run in CI along with all
shared-model tests, controller compilation and full-stack validation.
