# Central marketing operating model

User instruction: centrally manage digital marketing and consider a 5% marketing contribution. This local implementation adds a proposal preview to the existing growth dashboard and binds campaign review history to the budget being reviewed. It does not activate a contractual fee or launch an advertisement.

## Where to use it

Open Growth → business/finance. Owner, CEO and tenant administrator views show the **Central marketing model** panel with the current UTC reporting month, recorded net receipts, proposed contribution, advertising allocation, management allocation, responsibilities and activation prerequisites. Caller and campaign-specialist views do not expose the financial proposal. EN/FR/ES and the existing responsive layout are retained.

| Responsibility | Accountable role | In-app activity |
|---|---|---|
| Campaign preparation | Marketing team | Prepare source-scoped campaign brief, audience, creative, landing URL, dates and lead target |
| Budget and capacity | Franchise owner/CEO | Set the campaign budget, confirm capacity and review the submitted brief |
| Daily follow-up | Tenant administrator and callers | Assign lead work, record callbacks/outcomes, appointments, deadlines and conversion evidence |
| Performance review | Owner and operations team | Review existing funnel, source, task, acquisition-cost and manual finance reports |
| Monthly contribution planning | Owner and tenant administrator | Inspect the new estimate; reconcile source records before any contractual billing |

Central marketing staff currently require appropriately scoped accounts within each tenant. This change grants no global agency access and no additional ability to read client contacts. Existing territory routing still requires territory ownership, tenant launch approval, consent and recipient acceptance; it is not bypassed by a marketing plan.

## Proposed calculation

Policy `proposal-v1` uses 500 basis points total: 400 advertising and 100 management. The API calculates from that tenant's payment entries less refund entries with record dates in the current UTC calendar month. Invoice and expense entries, other tenants and out-of-period records are excluded. The current month is a running estimate, not a closed statement.

| Example | CAD |
|---|---:|
| Recorded payments less refunds | $50,000.00 |
| Proposed contribution | $2,500.00 |
| Advertising allocation | $2,000.00 |
| Management allocation | $500.00 |

Integer-cent arithmetic rounds the total and management allocation half up. Advertising receives the remainder, so both allocations always equal the total; at very small amounts its effective percentage can differ from 4%. Negative net receipts are shown, but produce a zero contribution estimate. Large aggregate values retain precision as decimal strings.

These are manually recorded receipts, not verified bank receipts or a defined contractual service-revenue base. Tax treatment, eligible revenue, adjustments, launch funding, fee frequency, service commitments and legal franchise terms require agreement before billing. The management allocation is revenue before costs, not profit. There is no invoice, debit, payable, fund contribution or expense created by viewing this model. It is not deducted from the existing cash-balance metric.

## Budget review correction

Every new campaign review event stores an immutable snapshot of the campaign budget, campaign version and CAD currency alongside its brief snapshot. A budget change resets any existing brief to draft and increments the brief version. The operator must resubmit and obtain a fresh owner decision; an old review version is rejected. A spend-only update leaves the brief review state unchanged. Both actions remain tenant-scoped and audited in the existing transaction, with campaign and brief locks in consistent order.

Previously recorded review snapshots are preserved and may lack budget fields. No earlier approval is rewritten as proof of budget review. An approved brief remains an administrative decision; it does not authorize a provider call, guarantee service capacity or prove delivery.

## Architecture and validation

The governance seed and registrar own the policy, controls, response contract and translations before implementation. `packages/shared/src/growth/marketing.ts` owns period and allocation arithmetic; the API queries the tenant ledger and returns the preview. The UI renders this result without SQL or percentage calculations. The existing authenticated GET growth route carries the new response; its OpenAPI schema and example describe the estimate and `billable: false` status.

Tests cover exact cents, rounding/reconciliation, negative/zero receipts, large values, invalid inputs, UTC rollover/leap-year periods, exclusions for prior/future dates and foreign tenants in text/UUID schemas, budget snapshot/reset, stale decision denial, spend-only retention and role/language/viewport browser rendering. Existing API scope and keyboard/accessibility checks remain in the combined suite.

## Remaining activation work

- Agreed and reviewed franchise terms, including the fee base and allocation/reporting rules.
- Authorized advertising-provider connections and controlled publishing.
- Capacity confirmation and an operational escalation process before campaigns run.
- Fund transaction records and reconciliation before claiming an unused balance or actual advertising allocation expenditure.
- Billing integration, approved central agency access if needed, deployment and human acceptance.

The current UI intentionally presents these amounts as a proposal. The existing source/conversion reports remain available, but no new closed monthly statement or automatic fee collection is claimed.

Local verification on 2026-10-17: 62 combined API/browser cases, 20 policy/unit cases and two text/UUID business SQL scenarios passed (84 total). Browser coverage uses English, French and Spanish at 320 and 1440 CSS pixels. TypeScript, the main browser bundle, governance regeneration checking and whitespace checking passed. PGlite SQL tests do not establish independent-connection PostgreSQL contention safety; CI and manual accessibility/release acceptance remain required.

## Monthly statement continuation

The business panel now includes a month selector, an on-screen statement and PDF download. `GET /growth/marketing-statement` and `/growth/marketing-statement/pdf` accept only `month` and `locale`. Months run from the governed minimum (2000-01) through the current UTC month; duplicates, invalid/future months, unknown fields and unsupported locales are rejected. Owner, CEO and tenant administrator business authority is checked from the active session on every request. Neither a tenant identifier nor a recipient is accepted.

The statement reports recorded payments, refunds, net receipts, the nonnegative estimate base and all three proposal amounts. Integer-cent values retain precision in localized currency text. The output includes tenant/month, generation time, current proposal version and explicit nonbillable/recalculation warnings. Past months are recalculated with the current proposal and current ledger records; this is not an immutable accounting close or evidence of fund payment. Read/download actions use existing audited, rate-limited report handling with no-store responses. No report email or provider action is introduced.

## Comparison with established franchises

Public sources reviewed on 2026-10-16 Toronto time support a division between central marketing and local franchise development. They do not establish our proposed 5% allocation as an industry-standard price or confirm Canadian contract terms:

- [Right at Home — current cost overview (US)](https://www.rightathomefranchise.com/educational-resources/cost-of-owning-a-franchise) lists a 5% royalty, 2% local marketing investment and separate brand-fund contributions. Royalty and marketing charges are distinct.
- [Right at Home — marketing support](https://www.rightathomefranchise.com/blog/tuesday-talk-marketing-support-with-brooke-wittrock) describes national brand advertising, locally tailored content and agency support for additional local paid campaigns.
- [Nurse Next Door — training and support](https://www.nursenextdoorfranchise.com/training-and-support) describes marketing/referral training, monthly metrics, planning tools, coaching and a 16-week post-launch growth plan. No specific marketing fee was verified from that page.

PrimeCare should retain central campaign preparation and transparent allocations, while keeping local relationships, response times, staffing capacity and client conversion accountable to each franchise. The proposal remains a pilot assumption until actual team costs, conversion performance and agreed terms validate it.

Statement verification: 63 combined API/browser cases, 21 policy/unit cases and two text/UUID finance scenarios passed (86 unique cases). Final scoped reruns cover report access and six owner language/viewport workflows after the narrow-screen table correction. All six owner workflows download localized PDFs; the generated English PDF was rendered and visually checked as one A4 landscape page. Text/UUID scenarios verify a prior-month report and PDF-compatible French currency grouping as well as current-month tenant/date exclusions. Local automated checks do not replace manual accessibility or production acceptance.
