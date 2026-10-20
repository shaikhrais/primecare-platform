# Live authentication and receiving-Worker verification — 2026-10-20

Real deployed recovery passed in Chromium in English at 320px, French at 768px and Spanish at 1440px. Each case sent a real recovery email to the dedicated owned QA address, read it through the deployed Cloudflare receiving Worker, matched the code hash to the native database, reset through the browser, and checked the resulting account/session state. This establishes those three deployed recovery journeys; it does not establish full acceptance of all authentication processes.

| Check | Result | Evidence |
| --- | --- | --- |
| Current auth UUID/text unit, type and native PostgreSQL matrix | Pass | [39462662300](https://github.com/shaikhrais/primecare-platform/actions/runs/39462662300) |
| Native partial-revocation fault proof against repaired source | Pass | [39462279819](https://github.com/shaikhrais/primecare-platform/actions/runs/39462279819) |
| Auth deployment of repaired source | Pass | [39463552242](https://github.com/shaikhrais/primecare-platform/actions/runs/39463552242) |
| Fresh pinned production acceptance read | Pass | [39467328308](https://github.com/shaikhrais/primecare-platform/actions/runs/39467328308) |
| Deployed public auth API and database checks | 22 passed | [39467328370](https://github.com/shaikhrais/primecare-platform/actions/runs/39467328370) |
| Current governed build and all nine portal deployments | Pass | [39467479327](https://github.com/shaikhrais/primecare-platform/actions/runs/39467479327) |
| Real email/browser/API/database/reload, EN/FR/ES | 3 cases passed | [39467479327](https://github.com/shaikhrais/primecare-platform/actions/runs/39467479327) |

The API smoke proved invalid-credential denial, identity GET/POST, authorized same-tenant account creation and persistence, created-account login, tenant-scoped dashboard/navigation, denied staff/foreign-tenant access, denied CEO escalation, deactivation and revocation, password change, old-session/password denial, new-password login and logout denial.

Each browser recovery case proved credential login, generic recovery acknowledgement without code disclosure, actual receiving-Worker inbox delivery and database hash correlation, password reset, old-session revocation, old-password denial, new-password browser login and identity reread, consumed-code replay denial, logout and post-logout denial, reset-code removal, responsive layout and browser reload returning to login. Exact temporary tenants/users, sessions, reset codes, audit and counters were removed; only the hash-matched received synthetic message was deleted. Pre-existing inbox entries were preserved. The machine receipts in evidence/auth-owned-inbox-20261020.json contain no passwords, session tokens or reset codes.

Receiver source is retained at docs/deployed-source/primecare-email-inbox.js; sender source is cloudflare/workers/src/email.ts. The producer reads the live receiver settings and source and verifies its allowed mailbox and append-only KV record schema before sending.

Two test-infrastructure repairs were necessary: add pinned-production preflight before synthetic mutations, and replace an obsolete deployment-reuse assertion with the existing governed current-source deployment pipeline. The first blocked browser attempt is preserved as run39467328204. No application email transport fix was needed. The separate contract-review CI failure came from stale source fingerprints after the auth repair; regenerated provenance preserves the 1063 unresolved operations, zero activation/implementation credit, unchanged authority and unchanged runtime code. Nine planning, fifteen factory and seven code-generation tests passed locally, along with reproducibility checks.

## Initial production acceptance snapshot (before account UI work)

The initial pinned catalogue contained 23 auth business processes: **0 verified, 11 implemented-unverified, 8 missing and 4 blocked**. These are acceptance states, not a count of failing positive-path tests. No production status or review approval was promoted by these tests.

At that initial snapshot, eight missing workflows were general governed account creation, account list/detail/update, another account's session list/revocation, and creation/management audit UI. Their existing APIs do not supply the absent registered controls and exact specification bindings. The production report requires a supported metadata writer and exact controls/resources before implementation.

Four blocked processes are the three protected bootstrap duties and role switching. Approved operator/environment bindings or multi-role tenant/session/audit policy remain unresolved. Bootstrapping real protected accounts is not part of this verification.

The eleven implemented processes still require their remaining registered negative paths, actor/platform coverage and independent acceptance gates. Localization registration does not establish reviewed/approved translations. Maintenance test-email delivery also has unresolved ambiguous-provider retry/idempotency and post-send audit semantics.

| Workflow | Current production acceptance |
| --- | --- |
| `auth.bootstrap-first-central-admin` | blocked |
| `auth.bootstrap-first-ceo` | blocked |
| `auth.bootstrap-first-platform-admin` | blocked |
| `auth.change-password` | implemented-unverified |
| `auth.create-tenant-account` | missing |
| `auth.credential-login` | implemented-unverified |
| `auth.forgot-password` | implemented-unverified |
| `auth.inspect-account` | missing |
| `auth.inspect-account-sessions` | missing |
| `auth.inspect-email-config` | implemented-unverified |
| `auth.inspect-own-sessions` | implemented-unverified |
| `auth.list-tenant-accounts` | missing |
| `auth.logout` | implemented-unverified |
| `auth.manage-account` | missing |
| `auth.read-creation-audit` | missing |
| `auth.read-current-session` | implemented-unverified |
| `auth.read-management-audit` | missing |
| `auth.reset-password` | implemented-unverified |
| `auth.revoke-account-sessions` | missing |
| `auth.revoke-own-sessions` | implemented-unverified |
| `auth.save-email-config` | implemented-unverified |
| `auth.switch-role` | blocked |
| `auth.test-maintenance-email` | implemented-unverified |

All work was published directly to main with expected-head checks. No new work branch or PR was created. Full auth is not declared complete.

## Account UI implementation and fresh production status

A later production read ([39476460788](https://github.com/shaikhrais/primecare-platform/actions/runs/39476460788)) found **23 auth business processes: 19 implemented-unverified, 0 missing, 4 blocked, 0 fully verified**. It supersedes the initial status table above. All eight previously missing account processes now have implementation bindings.

Five CEO read workflows were registered on existing dashboard705 and passed 36 checks per locale in English320px, French768px and Spanish1440px ([39472098668](https://github.com/shaikhrais/primecare-platform/actions/runs/39472098668)); machine receipts are in evidence/auth-account-reads-20261020.json. The corrected proof removed only its own temporary data. Bounded recovery also removed 84 stranded synthetic users across three exact test datasets after an earlier fixture cleanup type mismatch; no real account was changed.

Account API metadata1/11 was reconciled to the existing auth service, exact safe response contracts and approved role policy ([39472506674](https://github.com/shaikhrais/primecare-platform/actions/runs/39472506674)). Existing broad legacy grant rows were narrowed from128 to3 enabled rows: CEO/HR creation and CEO management. No grant was added or expanded. Historical runtime-artifact references remain unresolved; the exact quarantine carries both the isolated historical fingerprints and current narrowed fingerprints without asserting authority.

Creation controls for existing CEO705 and HR39, and CEO edit/revoke controls, were registered before implementation ([39473584835](https://github.com/shaikhrais/primecare-platform/actions/runs/39473584835)). The release bound canonical API steps and source references to the three existing business processes. Creation has116 resolved source links, management5 and revocation4. No independent review approval or production verified status was inferred.

The three protected bootstrap duties still need approved deployment operator/environment inputs. Role switching still needs approved multi-role assignment, tenant/session/grant and audit semantics. Remaining negative-path/platform coverage and independent architecture, database, security, accessibility, performance, localization, API, testing and documentation reviews remain acceptance gates.
