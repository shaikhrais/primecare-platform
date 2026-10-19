# ChatGPT screen review and disposable accounts

This review changes source code and checks the locally rendered website. It does not certify the deployed website or complete every registered business workflow. ChatGPT reviews screenshots directly; the optional private vision provider is not required for this workflow.

## Changes

- Existing workspace pages inherit heading icons, section icons and readable role names from the shared media catalog.
- Task pages display their declared task sections before the generic account overview.
- The large delivery inventory starts collapsed and stays open during searching and filtering.
- Compact screens have a smaller, non-sticky toolbar. Status badges move below mobile headings. Long governed labels wrap instead of overflowing.
- Login links to the existing forgot-password and reset-password APIs through accessible English, French and Spanish forms. Reset responses require reauthentication; secrets are not stored by the recovery form.

## Test scope

The role audit creates one isolated operator fixture, then provisions every other registered role through the real platform administration handler and signs in through the real authentication handler. Workspace data comes from the real workspace API handler. Only test-domain addresses are used; no email is sent. Domain dependencies that are absent from the isolated schema return an explicit unavailable response.

All account, session, tenant and audit records live in a disposable schema. A `finally` block drops that schema and verifies its removal. These are local test accounts, not accounts created on the live website. Local PostgreSQL-compatible runs use PGlite; CI is configured to run the unchanged audit against PostgreSQL 16.

The catalog has 952 screens. Coverage is divided as follows:

| Surface | Registered screens | Evidence |
| --- | ---: | --- |
| Generic workspace | 943 | Every page at 320 and 1440 px; real role/account APIs; representative screenshot review |
| Founder, platform admin and look manager | 3 | Dedicated persisted workflow tests; synthetic AI reports test the approval contract |
| Public enquiry | 1 | Dedicated anonymous intake and reload tests |
| Forgot and reset password | 2 | Seven transport and browser tests in EN/FR/ES; delivery responses are synthetic |
| Maintenance configuration | 1 | Shared style inheritance; no new rendered workflow acceptance claim |
| Consent and MFA | 2 | Pending; no complete new website implementation certified |

Successful browser layout checks are not individual AI rubric approvals, human admin approvals, clinical workflow completion or native-device review. Existing governance readiness and delivery blockers remain authoritative. No registered API denominator or legacy completion credit changes.

Additional checks: 31 workspace, recovery and portal-media tests; 43 dedicated founder, public enquiry, partner/tenant and review-manager tests; eight backend recovery tests; nine-portal build and TypeScript typecheck. Browser dependency inspection found no server database runtime in the website bundle; its two worker-directory imports are shared JSON configuration. Separate legacy Flutter database modules have not been removed.

## Production limits

The live portal remains behind sign-in. There is no authenticated production admin session or operator provisioning credential in this workspace. Recovery email delivery, actual account recovery, live account creation/deletion, production screens and native device appearance were not exercised. Human admin approvals are not recorded by these tests.

The source changes are local and have not been published. The earlier automatic approval review rejected repository publication; this review does not bypass that block.

## Repeat the checks

Run `node scripts/build-typescript-websites.mjs`, the three web test scripts, and `node scripts/audit-workspace-role-browser.mjs` with `GROWTH_TEST_DATABASE_URL` pointing to a disposable test database. Playwright requires Chromium; `GROWTH_BROWSER_EXECUTABLE` optionally selects an installed executable. Never point the role audit at production.

Final counts, cleanup evidence and screenshot review notes are recorded in `chat-review/summary.json` and `chat-review/screens.csv`.

The final sweep passed all 1,886 checks. It provisioned 73 accounts through the admin API plus one bootstrap fixture, signed in all 73 provisioned accounts, verified access for 74 roles and removed all 74 accounts with their test schema. Twenty workspace screenshots were captured; seven were directly inspected alongside recovery, partner provisioning and the Look manager. The remaining source-label and disconnected-domain findings prevent a production appearance approval.
