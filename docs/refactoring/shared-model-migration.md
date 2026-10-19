# Shared API/UI model migration

The old Flutter-only location prevented Dart APIs from reusing domain classes
without importing Flutter. `primecare_models` is now the canonical pure-Dart
package for 16 existing domain/base classes. Eight original files remain as
compatibility exports. Existing fields, parsing, validation and serialization
were copied unchanged, including existing permissive behaviors.

946 exact duplicate state models now extend `BaseScreenState<T>`. Common
loading/error/data fields and typed copy behavior are implemented once. Their
constructors, const usage, subtype return and null-as-unchanged behavior remain
compatible. Generated models are screen states, not client-profile contracts.
No profile fields have been invented from screen names.

11 consumer packages declare the shared dependency. `server_core` re-exports
models so Dart services can use the same classes. Database mapping and actual
API responses still need endpoint-specific integration review. HTTP contracts,
authorization, route registration and TypeScript services were not rewritten.

The model-template seed script now emits inherited state. Existing persisted
governance templates were not overwritten; synchronize that template through
the governance lifecycle before regenerating screens from the database.

The migration manifest pins the original commit and records SHA-256 hashes.
Verification checks every converted template against that commit and checks
that moved domain sources preserve the original bytes. The repeatable converter
only rewrites exact templates and leaves custom models unchanged.

## Validation

- `python3 scripts/test_shared_model_migration.py -v`
- `python3 scripts/verify_shared_models.py` with Dart 3.11.3 on PATH
- In packages/primecare_models: `dart pub get`, `dart analyze`, `dart test`
- Run existing Flutter and API suites before merge/release.

## Local results

Dart 3.11.3 analysis: no issues. Three shared-model tests passed. All 946
inherited classes compiled and copy behavior verified. Five Python migration
tests passed, covering original-source preservation and dependency wiring.
Existing full Flutter/API regression suites have not run.

## Remaining full-project work

953 other `*_model.dart` files remain for contract and dependency review; some
are empty generated placeholders. Dashboard classes with Flutter dependencies,
custom controllers, repositories, business workflows and TypeScript service
contracts need individual migration. Adding inheritance does not implement
missing APIs or workflows. No production completeness or deployment is claimed.
