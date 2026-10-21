# Flutter MFA repair — 2026-10-21

Current main contained the registered native Flutter MFA implementation (`dd85302f`), but verification run39677996502 stopped before the clinic release build: the routing test referenced removed `MfaState.isVerified`.

Commit241b8b9e replaces that assertion with the real authority boundary: no pending challenge, no authenticated actor and no session token when a code is submitted without a verifier. The test injects an initialized guest. The MFA workflow now triggers for core/UI/model, clinic and catalog/generator changes instead of only its two MFA test files.

Verification run39681510567 passed catalog reproduction, core MFA/session regression checks and localized UI/auth regression checks. Clinic routing/release build remained running at this checkpoint. Do not infer deployment or native device acceptance from these unit/widget checks.

The contract-plan CI exposed two stale source fingerprints introduced by the native MFA implementation. Reviewed the exact source diff (transient callback type, provisional-session confirmation method and existing MFA endpoint mapping), matched historical fingerprints to prior source, and moved the two affected literal line references. Regenerated the plan without changing operations, stages, decisions, eligibility or credits. Nine contract-plan tests and generator --check pass; 1063 unresolved operations retain their existing status, with zero implementation/retirement credits.

Earlier web verification remains documented separately in auth-full-web-verification-20261021.md. Its statement that Flutter MFA is a placeholder describes the earlier checkpoint; implementation now exists, with native release/build/device acceptance and independent reviews tracked separately. Lost-factor recovery and key rotation still require governed procedures.

## Completed build and deployment evidence

Verification39681510567 completed successfully: registered catalog reproduction, core/session tests, localized UI tests, clinic routing tests, release web build and artifact upload all passed. Deployment39681510710 also succeeded, including analysis, release build, Cloudflare Pages upload and exact live source-stamp/JavaScript hash comparison at source241b8b9e.

The dependent factory/bulk-code reports were regenerated after the source evidence refresh; all five changes are source/input fingerprints only. Local contract-plan (9), contract-factory (15), and bulk-codegen (7) tests pass, and all three generators pass --check. Independent reviews, lost-factor procedures and broader native device acceptance remain outstanding.
