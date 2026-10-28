# CEO marketing and business readiness

Updated 2026-10-28 (America/Toronto). This is the current operating checklist; historical “built locally” notes in the numbered task list describe earlier snapshots.

## Open the working board

Sign in at <https://primecare-clinic.pages.dev/login> with an existing authorized CEO/owner or marketing account, then open **Founder Growth Dashboard**. Direct destination: <https://primecare-clinic.pages.dev/growth?enable-semantics=true>. The API determines which actions the current role can use; Code Administrator access does not grant CEO authority.

The generic organization overview and the operational marketing board are separate screens. Sidebar and universal-search selections must open the operational renderer, with campaigns, leads and follow-up controls.

## Business sequence

| Step | Where to work | Result to verify |
| --- | --- | --- |
| 1 | Targets and plan | CEO/owner saves a dated plan with explicit client and partner pipeline targets. Targets are plans, not booked revenue. |
| 2 | Campaigns | Record source, reference and approved budget; prepare the audience, offer, creative, dates, landing URL and accountable owner. |
| 3 | Campaign brief review | Submit the current version and record an authorized decision with evidence. Budget or brief changes require fresh approval. |
| 4 | Capacity/readiness | Review the current campaign gates. Owner capacity evidence expires and does not reserve clinical staff or launch ads. |
| 5 | Intake links | Create an authorized website, event or referral form/QR link and test a synthetic enquiry. Check attribution, consent, owner assignment and inbox receipt before sharing the link. |
| 6 | Leads, calls and appointments | Assign follow-up and a due date, record outcomes, respect do-not-contact preferences and advance only with the required evidence. Manual call logging does not place a phone call. |
| 7 | Partner or client handoff | Review partner onboarding and use the existing activation process. Client care handoff links an existing same-tenant visit; it does not schedule clinical work. |
| 8 | Finance and performance | Record supported manual CAD entries with references; review actual receipts, outstanding balances and acquisition metrics. Download the period report/PDF. |

## Verified repairs and checks

- Fixed an out-of-order refresh defect: an earlier successful response could overwrite newer CEO figures, and an earlier failed response could replace the successful dashboard with an error. Both regressions failed before the fix and pass after it.
- Fixed workspace navigation that rendered a generic overview for `/growth`. CEO sidebar and universal search now hand off to the working marketing screen. Dedicated growth landings use the same handoff.
- [Marketing audit on source `34bc2f63`](https://github.com/shaikhrais/primecare-platform/actions/runs/40630769201) passed: 37 contract/workforce/refresh-order tests, eight native PostgreSQL groups, 34 marketing browser cases, eight partner/admin browser cases and six loading/retry cases. These counts overlap earlier evidence and are not distinct business workflows.
- The refresh fix was [published successfully](https://github.com/shaikhrais/primecare-platform/actions/runs/40630769096).
- [Continuation on runtime source `63e1a0f2`](https://github.com/shaikhrais/primecare-platform/actions/runs/40631136226) passed the growth, workspace, account, tenant and client jobs. Tenant evidence includes 159 authority tests, 16 database/browser cases and 120 native PostgreSQL checks per identifier format. Client evidence includes 296 API tests and 329 native PostgreSQL checks per identifier format. Both text and UUID auth identities were tested. The client checks cover selected booking mutations and scoped record reads; they do not establish every client workflow.
- The workspace suite passed 43 checks, including the two navigation regressions. A follow-up test-harness correction supplies JSDOM's missing desktop media query and explicitly rejects uncaught navigation event errors; all 43 checks passed locally with a clean event log. It changes no application code.

The navigation correction was [published successfully](https://github.com/shaikhrais/primecare-platform/actions/runs/40631136202) from runtime source `63e1a0f2`.

## Remaining live-business dependencies

| Dependency | Current boundary |
| --- | --- |
| Google Ads / Meta | No connected provider launch is implemented in this board. `canLaunch` remains false. Preparation and approval do not publish ads or spend money. |
| Outbound communications | Synthetic provider checks are not evidence of live SMS, email, reminder or Vapi delivery. Verify the selected production provider path separately. |
| Payment collection | Manual invoice/payment records do not charge a card or reconcile a bank. The marketing contribution statement is a proposal and is not billable. |
| Production acceptance | Passing disposable tests does not verify the company's production setup, real enquiry delivery, clinical capacity or formal human approvals. |

No advertisements, marketing messages, calls, invitations or payments were sent by this audit. No real tenant or client record was created or changed.

Priority is CEO marketing first, then tenant and client workflows. Broader unimplemented API contracts remain open; this checklist does not mark them complete.
