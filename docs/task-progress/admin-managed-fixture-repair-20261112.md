# Managed admin browser fixture repair

Batch summary: repair two existing isolated admin browser entries using the existing `presentPlatformFixture` shared test bootstrap, and report startup errors earlier in all three failing browser groups. Retain their visible-page, data, MFA, role, localization, responsive and independent database assertions. No production renderer, permission, registration, timeout, source hash or acceptance threshold changes.

## Confirmed failures and repair

Exact source `dc60d092c18e434f2187590f686b3d4cae1b61ba`, appearance run43154978862:

- Review job130972699823 times out on `workspace-overview`. Its entry installed the real manager but never registered its dispatcher entry. The same actual helper now registers and presents the existing route before calling workspace/admin.
- Approved-data job130972700036 times out on `.approved-directory tbody tr`. Its browser entry called `renderPlatformAdmin` without any Screen Manager. It now uses the same existing helper and canonical shared palette.
- Security job130972700022 times out on `platform-tenant-form` after MFA. This batch preserves the authentication/SQL/readback assertions and existing managed entry, adds the existing startup error guard around submit, and retains the original visible-form wait. Its remaining root cause requires fresh browser output; it is not claimed repaired.

No browser/native execution occurred locally. Browser and PostgreSQL verification remains in GitHub Actions. All original 30-second readiness deadlines remain; no sleep, inflated timeout or fabricated provider response was added.

## Local verification

- 75 Node model/fixture checks pass, including execution of both actual fixture entry strings with the real presentation bridge and manager on administration and dashboard routes.
- Three new regression groups fail against the published pre-repair fixture strings. Two verify missing entry integration; the third verifies startup diagnostics and preservation of security/readback assertions.
- All three edited browser scripts parse. Workflow YAML parses; the appearance workflow runs these fixture contracts before its existing actual browser checks and watches the bootstrap/startup inputs.
- Strict source findings remain previous0/current0/new removals0. All72 source mappings remain reconciled;0 fully accepted/72 pending,0/344 screens and0/147 workflows promoted.

## Pre-repair exact-head evidence

The same `dc60d092` source passed Theme Center43154978734 (native, website and all nine app consumers), boundary43154978645, contract43154978664 and tenant workspace43155287296 acceptance/publish. Those outcomes are not acceptance of this new fixture batch. Inspect its fresh appearance/security/data jobs before reporting a repair pass.

## Fresh browser feedback

Repair-head399364bc approved-data job130991262680 now renders all four directory rows. Its new readiness guard incorrectly used a multi-row strict locator; the follow-up selects `tr:first-child` while retaining the original first-row visible wait and separate exact four-row assertion. This is a fixture correction, not a production or assertion-threshold change. A new local regression locks both conditions; actual browser completion still requires fresh CI.
