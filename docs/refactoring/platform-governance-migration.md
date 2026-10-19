# Platform governance skeleton conversion

The platform role enum and four existing platform classification enums move into the pure Dart model package. Existing Flutter import paths re-export the same canonical types. All role values, indices, display names, snake-case names, aliases, route mapping, label translations, and unknown-role behavior remain unchanged.

Tenant, module, application, and role-definition metadata now inherit four shared generic parents. API consumers can use ordinary Dart metadata types; Flutter adapters retain their existing ThemeData, IconData, PlatformRole, and PrimeCareScreen types. Each of the six existing governance classes has its own part file, preserving the original public library and private dynamic-module visibility. Role resolution and navigation methods remain in their existing Flutter adapters. The shared metadata declarations introduce no authorization grants or new policies.

DataLogisticsHub moves from the mixed model file to application/services. Its existing fetch/fallback behavior and synthetic blueprints are preserved. Moving these examples does not implement authoritative data workflows.

The deterministic migration check compares every extracted file with the pinned source. The Dart runtime harness compares 1,109 role, route, enum, label, and fallback cases. The Flutter harness compares explicit and dynamic governance definitions, authorized modules, and navigation against the original code across every existing platform role. Pure Dart tests demonstrate that the shared parents can be consumed without Flutter types. No new completed API or business workflow is counted.
