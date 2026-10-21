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

## Final executed results

[Gateway run39527621336](https://github.com/shaikhrais/primecare-platform/actions/runs/39527621336) passed all eleven jobs for source fa18ab5824321141a30b8e247a70dcc5cde987e8. Flutter job118986105382 passed103 UI tests,294 core auth/transport tests and3 clinic routing tests:400 total. All eight portal analyze/test/build jobs, Dart service analysis/parity and real PostgreSQL credential login/logout passed.

The maintenance test's first run failed because its long ListView had not built the offscreen account controls. The corrected response-contract fixture renders those controls; all four maintenance scenarios passed, including ignoring a reply after actor replacement. Earlier failed evidence is retained in run39527235574; it is not counted as a pass.

[Deployed Flutter run39527235423](https://github.com/shaikhrais/primecare-platform/actions/runs/39527235423) uploaded the603d63f0 source successfully, then failed its live-source check with HTTP403. A matching local default-Python probe returned plain error code1010. Cloudflare documents1010 as a client-signature access denial: https://developers.cloudflare.com/support/troubleshooting/http-status-codes/cloudflare-1xxx-errors/error-1010/ . No user-agent spoofing, protection disabling or alternate-route bypass was applied. The verify job was skipped: no synthetic account or recovery email was created by this run, and no new deployed Flutter email acceptance is claimed.

Fresh production snapshot39526605713 remains23 auth processes:19 implemented-unverified,4 policy-blocked,0 fully verified. Approved bootstrap operator/environment bindings, role-switch policy, independent review IDs and complete actor/device/PWA/manual accessibility coverage remain open. Machine evidence is in evidence/auth-flutter-repair-20261020.json. Remote branch inventory remains main only; there are no open work pull requests.
