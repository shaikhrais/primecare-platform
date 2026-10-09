# Complete generated-model inventory and remaining project boundaries

The first migration is merged in PR 160. This continuation gives 945 existing
empty generated DTOs one BaseEmptyModel superclass while preserving const
constructors, factory behavior and fresh empty JSON maps. Their original TODOs
and placeholder status remain unchanged. Inheritance is not workflow completion.

Existing dashboard DTOs are now pure Dart. InsightImpact has one shared definition,
re-exported from its former telemetry library so identity does not change.
Governance types, geometry, API metadata, deployment/store metadata, correction
tickets and three custom view models also have canonical shared implementations.
PrimeCareViewModel is shared; the Flutter binding adapter stays in primecare_ui.

Two legacy libraries both define PrimeCareApi. Both individual compatibility
imports retain their original classes. The common barrel exposes the metadata
version and hides the endpoint library's duplicate name; no existing class is
renamed or removed.

## Inventory of all 1,899 original *_model.dart files in apps/packages

| Category | Files | Result |
| --- | ---: | --- |
| Repeated loading/error/data states | 946 | BaseScreenState inheritance, merged in PR 160 |
| Empty generated DTO placeholders | 945 | BaseEmptyModel inheritance; still empty |
| Custom framework-independent model files | 5 | Shared canonical implementation and old-path export |
| Flutter-specific model files | 3 | Retained in UI: shortcut model and two financial forecasting screen files |

Shared domain, dashboard and metadata files are counted separately; their names
do not all end in *_model.dart. View/widget classes stay in Flutter, HTTP hosts
stay in services, and database adapters stay on the server. Sharing a business
model does not require UI widgets to inherit backend transport classes.

The full project is not converted merely because this model inventory is covered.
TypeScript APIs need generated equivalents of reviewed wire contracts rather
than Dart imports. Empty workflows need governance-defined fields, permissions
and tests. These tasks are not marked as implemented or as resolved APIs.

## Reproduction and checks

- scripts/refactor_remaining_models.py: exact empty-template conversion only.
- scripts/test_remaining_model_migration.py: pinned-source and dependency checks.
- scripts/verify_remaining_models.py: compile every inherited placeholder DTO.
- The shared package's Dart tests check enum identity, JSON behavior and inheritance.
- The existing pinned core-layer checker resolves compatibility exports and checks
  original code behavior, including the declared dashboard import substitution.

Local checks: all 945 placeholder classes and all 946 state classes compile;
6 shared-model Dart tests pass; Dart analyzer reports no issues; 8 Python tests
pass across both migration suites; the prior core-layer behavior checker passes.
Full host CI must pass before merge.
