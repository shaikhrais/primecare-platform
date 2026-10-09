# Shared data model conversion

`UserModel` and `ClinicalArticle` move from Flutter-specific source locations to the pure Dart `primecare_models` package. Both API and UI code can import the same definitions. `UserModel` stores its existing string identity through `BaseEntity<String>`; constructor fields, display name, and copy behavior are unchanged. `ClinicalArticle` retains its exact JSON keys, generated equality/copy/serialization code, and summary behavior. Existing Flutter imports re-export the canonical classes. Generated article parts move alongside their library so there is only one implementation.

The user management notifier retains its existing simulation and remains an unfinished workflow. This change does not add persistence, serialization rules for users, endpoints, or authorization policy.

`refactor_shared_data_models.py --check` checks the move against the pinned source and rejects duplicate generated implementations. Pure Dart model tests cover article serialization/equality/copy/summary behavior and user identity/copy behavior. CI also compiles both legacy Flutter import paths against the shared type identities.

Article generator dependencies are declared in the shared package. Regenerate its parts from `packages/primecare_models` with `dart run build_runner build --delete-conflicting-outputs`; review generated contract changes deliberately. This migration moves the existing generated code without regenerating or changing its wire contract.
