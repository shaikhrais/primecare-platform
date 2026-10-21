# Current auth deployment and PWA evidence boundary — 2026-10-20

Inspected remote main ddd7f87a19279b328595caed606f070793e9692a. Remote branch inventory contains main only.

## Completed validation
- Maintenance mutation contract and binding safety run [39524173446](https://github.com/shaikhrais/primecare-platform/actions/runs/39524173446), job 118974837956, passed client acknowledgement/session regressions and native PostgreSQL binding/transaction tests.
- Auth Gateway Verification run [39522694558](https://github.com/shaikhrais/primecare-platform/actions/runs/39522694558) passed for the Flutter identity repair at 4dd15072.
- All nine standalone Flutter web deployments at 4dd15072 completed successfully. Unified Dart CI and Linux distributions also passed. Android/iOS/Windows remained queued and macOS in progress at this inspection; earlier completed build batches do not establish completion of this newer batch.
- Follow-up gateway run [39524170230](https://github.com/shaikhrais/primecare-platform/actions/runs/39524170230) passed Dart service analysis/parity and native PostgreSQL credential login/logout. Remaining Flutter/portal jobs were running when inspected.

## Deployment mismatch
A read-only GET of https://primecare-clinic.pages.dev/?enable-semantics=true returned the Flutter shell (flutter_bootstrap.js), not the TypeScript id="app" shell used by the previously recorded browser producer. HTML SHA256: cb43110af44bd88da27effb2ca2b8d940f2b7cc355b82b9119132839fc7dcded.

The live manifest.json is valid JSON and declares standalone display, start_url ".", four icon entries and the existing default description "A new Flutter project." This is manifest evidence only, not proof of installation, offline safety, icon retrieval, service-worker lifecycle or device behavior.

Two workflows target the same Cloudflare Pages projects:
- _deploy-web.yml publishes Flutter output automatically through deploy-web-*.yml after shared Flutter auth changes.
- deploy-typescript-websites.yml publishes governed TypeScript output through release-primecare.yml.
Their concurrency groups differ. A successful later deployment can therefore replace the runtime covered by earlier source-bound browser receipts.

The TypeScript build currently contains no manifest link in websites/typescript/index.html and no service-worker registration in its source/build script. This observation does not imply the currently live Flutter shell lacks those features.

## Required next verification
Preserve historical passing receipts; do not apply their UI acceptance to the current Flutter shell. Bind a new deployed Flutter credential/recovery/session/browser-reload proof to the actual live build, then evaluate installed/PWA lifecycle and authentication-cache behavior. Reconcile the two publishing paths with the intended release authority before silently disabling or replacing either runtime. No production deployment, business policy, permission or acceptance status was changed by this inspection.

The last recorded production inventory remains 19 implemented-unverified, four policy-blocked and zero fully verified. No new live inventory transaction was available in this inspection. Protected bootstrap inputs, role-switch semantics, physical-device/manual assistive-technology checks and independent reviews remain open.
