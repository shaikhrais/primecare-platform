# Native authentication verification — 2026-10-10

All nine inherited auth shells compiled successfully on Windows, Android, iOS, macOS, and Linux: 45 release builds. The canonical Client app ran the three shared native integration tests successfully on each OS: 15 passing test executions. Shared UI analysis and its three widget tests also passed on every runner.

| Platform | Release builds | Native integration tests | Evidence |
| --- | --- | --- | --- |
| Windows | 9/9 passed | 3/3 passed | [Windows retry](https://github.com/shaikhrais/primecare-platform/actions/runs/38083131723) |
| Android | 9/9 passed | 3/3 passed | [Release builds](https://github.com/shaikhrais/primecare-platform/actions/runs/38082982568), [emulator retry](https://github.com/shaikhrais/primecare-platform/actions/runs/38083993614) |
| iOS | 9/9 passed | 3/3 passed | [iOS job](https://github.com/shaikhrais/primecare-platform/actions/runs/38082982568/job/114303548591) |
| macOS | 9/9 passed | 3/3 passed | [macOS job](https://github.com/shaikhrais/primecare-platform/actions/runs/38082982568/job/114303548507) |
| Linux | 9/9 passed | 3/3 passed | [Linux job](https://github.com/shaikhrais/primecare-platform/actions/runs/38082982568/job/114303548581) |

The nine apps are business development, Client, clinic, corporate, enterprise blueprint, franchise, governance, marketing, and support. Runtime verification uses Client and the shared inherited auth UI, rather than running every portal separately on each native OS.

## What ran

The first native integration test starts the real Client app, reaches the deployed Cloudflare auth health endpoint, signs in through the UI using an isolated production QA account, and signs out. The other two tests use a fixture transport to verify the inherited login/logout screen and the recovery/code-reset form transitions. Actual email delivery and password reset through the live API were covered by the earlier web E2E rollout; these native recovery checks test the forms, not email delivery.

Windows, macOS, and Linux tests ran as desktop applications. Android ran on an API 35 x86_64 Google APIs emulator. iOS ran on an available iPhone simulator on macOS 15. Physical devices were not tested.

## Corrections and cleanup

The initial Windows checkout failed on long paths in archived source. Sparse checkout now excludes that archive, and the Python launchers resolve the Windows Flutter executable. The Windows retry built all nine apps and passed all three integration tests.

The initial Android job built all nine APKs and passed live login/logout, but its recovery test tapped a button hidden by the keyboard. The shared test driver now dismisses keyboard focus, scrolls the control into view, and treats missed hit tests as failures. The Android test-only retry passed all three tests without repeating the successful nine release builds. The original multi-platform workflow therefore retains a failed aggregate status; the successful retries above supply the final Windows and Android evidence.

Cleanup logs confirm that all isolated QA accounts, tenants, sessions, and fixture login rate counters were removed, including the initially failed Android attempt. Release builds run before QA account creation, so uploaded release packages do not contain the test account credentials.

## Reproduction and artifacts

`scripts/prepare-native-hosts.py` creates fresh Flutter platform hosts outside the repository, copies the inherited app shells and shared models/core/UI packages, adds Android internet permission and macOS client-network entitlement, and installs the integration suite. `scripts/build-native-hosts.py` compiles all selected apps and writes per-app build results. No generated platform caches enter source control.

Use the manual `verify-native-auth.yml` workflow on `deploy/email-inbox-20261010` to repeat all five platforms. The Windows and Android retry workflows are also manual. Production QA setup uses the existing production environment database secret.

Release artifacts are attached to the main run for Android, iOS, macOS, and Linux, and to the Windows retry. They expire on 2026-10-11 at approximately 20:20–20:38 UTC. These are build verification outputs: iOS uses `--no-codesign`; Apple signing/notarization, distribution signing, installers, and installation of the archived release bundles were not verified. Native integration tests run Flutter's debug test builds.

This completes native build and shared authentication verification. It does not certify implementation of the archived business screens or merge the release branch into main.
