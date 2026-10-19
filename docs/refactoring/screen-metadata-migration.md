# Shared screen and navigation contracts

ScreenMetadata inherits BaseScreenMetadata<IconData> from primecare_models.
Its shared parent inherits BaseEntity<String> and owns the existing fields,
constructor defaults, aliases, readiness predicate, JSON serialization and
pure Dart parsing. API consumers can use BaseScreenMetadata<String> with their
own icon identifiers. PrimeCareNavigationItem likewise inherits the generic
BaseNavigationItem<IconData>. Both existing Flutter import paths remain valid,
and const construction, icon types, copyWith and fromJson subtype results remain
compatible. Flutter copy/factory adapters preserve their original public API.

No fields, route names, permissions, screens or workflows are invented. The
existing canImplement predicate is retained; it is not an authorization check.
JSON still omits icon and designSize; fromJson still defaults them. Constructor
routePath and allowedRoles aliases retain precedence, and list references remain
borrowed. designSizeValue remains ignored as in the original constructor.
Placeholder readiness flags and workflow implementation status are unchanged.

scripts/refactor_screen_metadata.py reproduces the extraction from commit
6e11e02852785a3aa55430b978b193bae75147e5 and checks exact output. The parity
runner compares all stored fields, per-field copy overrides, malformed and missing
JSON values, constructor aliases, readiness combinations, mutable list ownership
and navigation metadata against that original. The same 587 cases run in pure
Dart and Flutter; Flutter uses real IconData and verifies subtype inheritance.
The API-consumer tests compile these contracts without Flutter dependencies.
