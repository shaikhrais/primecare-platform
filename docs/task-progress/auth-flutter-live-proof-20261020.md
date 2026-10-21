# Flutter auth research, repair and deployed proof

## Research before changes
- Flutter Semantics labels: https://api.flutter.dev/flutter/semantics/SemanticsProperties/label.html
- go_router URI query navigation: https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html
- OWASP password recovery: https://cheatsheetseries.owasp.org/cheatsheets/Forgot_Password_Cheat_Sheet.html

Compared guidance with existing registered recovery fields, safe-return validation, server password_reset/reauthenticationRequired contract and actual live Flutter accessibility tree. No new role, route, recovery policy or permission was created.

## Repairs
Preserve validated returnUrl and requested enable-semantics=true between existing auth pages, including semantics embedded in the original return destination. Drop unrelated/unsafe query data. Give recovery controls the existing stable recovery identifiers through Flutter semantics. On confirmed reset, clear local authority through the existing logout implementation only if the captured session still matches, preserving newer sessions.

Regression coverage includes safe navigation, localized recovery responses, failed-response draft preservation, confirmed reset logout and newer-session preservation. No test is called passed until CI executes it.

## Deployed proof
Reusable Flutter deployment writes a source/bundle hash stamp, uploads it as an artifact, and verifies the exact live bundle after propagation. The separate Flutter owned-inbox workflow uses that build rather than publishing TypeScript. Before synthetic data changes it checks production governance, expected commit, live source stamp and bundle hash. It then runs browser credentials, real receiving-Worker email/hash correlation, reset, old session/password denial, new login, replay denial, logout and reload across EN320/FR768/ES1440. It checks the live stamp again after the journey. Existing exact fixture and correlated-message cleanup remains in place; pre-existing inbox records are preserved.

This workflow shares the original owned-inbox concurrency group to serialize the dedicated QA mailbox. Source-bound results are pending its first run. Historical TypeScript receipts remain scoped historical evidence. Independent reviews, physical-device/manual accessibility acceptance, protected bootstrap inputs and role-switch policy are not approved by this change.
