# Automated test suite renderer-review repair

## Failure and scope

PR #222 head: `13928fc9bcc2acc2bea72dad26c3da7a4d7ed50c`.
Main baseline: `df27a32822e6255709c48bfcf71be5f9bbccc6ac`.
CI run: https://github.com/shaikhrais/primecare-platform/actions/runs/42115579784
Job: https://github.com/shaikhrais/primecare-platform/actions/runs/42115579784/job/127554209600

CI checked merge commit `1d8717cdd3b3720644a07b67b16d07f07018504c`. It failed at the Python screen-governance regression gate, before either Maven test stage. The current renderer SHA-256 is `f39d904cca48b3db41fc3a0a1a8d16436b9e80f805d1611854a4ffc3051847ad`; the gate only recognized the two previous reviewed versions.

The introducing commit is `13928fc9`. Its renderer delta changes unavailable-error state from a stored translated string to a boolean and resolves the label during rendering. Review confirmed that identity scope, server request, route/page selection, registered section iteration, section rendering, card rendering and semantics are unchanged. The intended locale/live-text fix is retained.

## Focused repair

- Add only the exact reviewed localized-error renderer hash to the existing full-source allowlist.
- Keep all pre-existing reviewed hashes and fail-closed classification behavior.
- Add a regression reversing the five exact presentation substitutions (including both failure assignments) and requiring the exact prior reviewed digest. This proves the reviewed change is bounded to error presentation.
- Add rejection tests for further source drift, authentication-gate drift and route-selection drift. Existing section-loop/card mutation, registry identity, missing-section, metadata archive and readiness tests remain.
- No application code, workflow skip, permission policy, live database, production state or readiness approval changes.

## Validation

- Main baseline: 12/12 Python audit regressions passed.
- Unpatched head: 11/12 passed; the same current-renderer digest assertion failed as CI.
- Patched head: 14/14 passed on Python 3.12 and Python 3.13.
- Reconstructed only the explicitly allowed historical CI fixture using `prepare-ci-fixture.py`, fixture mode and no production credentials. Its SHA-256 remains `42d350b6b3ab46540cbc58f2696d896f3afe6658b1f5153bec410dfce87d1262`.
- Derived-fixture reconciliation and read-only check passed on both main and patched head. Full JSON reports are identical: 948 active screens/files, 945 static structures, zero metadata drift and zero production-ready promotions. The three existing `no_state_evidence` warnings are for consent, mfa and reset_password.
- Java 21 and the repository-bundled Maven were available. The PageObjectCoverageTest attempt stopped before compilation because Maven Central DNS lookup failed while resolving `maven-resources-plugin:3.3.1`; the offline attempt confirmed it was not cached. No Java tests ran. SharedWebsiteSetupTest was not separately attempted because it uses the same blocked build dependencies.
- Flutter/Dart runtime validation, staging/browser verification, a fresh remote CI run and release approval are not established by this patch.

## Integration limits

Prepared as a local patch only. No branch, commit, push, merge, deployment or production mutation was performed. Apply to the exact reviewed head only after checking for concurrent renderer changes, then rerun the complete automated workflow and relevant Flutter tests before claiming CI success.
