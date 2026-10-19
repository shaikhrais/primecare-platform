# Campaign readiness and owner capacity confirmation

This implements the next central-marketing operating step requested through “Continue”: show campaign preparation gaps and let an owner record time-limited operational capacity. It adds no paid-ad launch, billing collection or clinical scheduling authority.

## User workflow

1. Open **Growth → Campaigns → campaign brief** for a Google Ads, Facebook or Instagram campaign.
2. Prepare and submit the client campaign brief. The owner/CEO reviews the current brief and budget using the existing campaign decision workflow.
3. The owner records additional client slots, an expiry expressed in UTC and operational evidence. The confirmation must expire within 30 days; zero slots explicitly means no additional clients can be accepted.
4. Review five server-owned checks: current owner budget approval, unspent budget, unexpired campaign dates, current capacity confirmation and advertising-provider launch connection.

The provider gate remains unavailable and `canLaunch` remains false. A completed preparation check means ready to address provider setup, not authorization to advertise. Tenant launch approval, territory ownership/routing, consent and provider/account controls remain separate requirements. No provider integration or spending is activated by this feature.

Capacity is an owner's operational statement. It does not reserve staff or slots across campaigns, verify clinical credentials, calculate safe workloads or guarantee care delivery. Partner-recruitment briefs do not require client capacity, and show that check as not applicable.

## Authority and stale evidence

Only the current active owner/CEO can record capacity in its own tenant. Tenant administrators and marketing staff can inspect readiness for campaigns they can already see; they cannot confirm capacity. Staff source restrictions and foreign-tenant concealment remain enforced.

A confirmation is bound to an approved client brief version. Readiness requires a recorded owner/CEO approval for that version whose immutable budget snapshot matches the current campaign budget. Legacy approvals without this evidence do not satisfy the gate; edit/resubmit and obtain a fresh owner decision. Changing a brief or its budget makes the earlier capacity confirmation stale. Spending updates preserve the brief decision but can exhaust the budget gate.

Capacity also fails closed after expiry, zero available slots, inactive/moved confirmer accounts or a confirmer role that no longer has owner authority. Historical successful retry responses do not renew capacity or extend expiry. Current owner authority is checked before serving a privileged retry response.

The UI shows the latest slots, expiry and version. Free-text evidence remains in immutable capacity history and existing transactional audit rather than being copied into specialist dashboards. Users are instructed not to enter client or health details.

## API, schema and governance

- `PUT /v1/governance/growth/capacity/{campaignId}` accepts exactly `version`, `briefVersion`, `clientSlots`, `expiresAt` and `evidence`, with an authenticated session and idempotency key.
- `version=0` creates the first record; subsequent requests must match the latest capacity version. A stale brief/record or unapproved/expired brief returns 409; invalid slots, expiry or fields return 400; unauthorized roles return 403 and concealed foreign resources return 404.
- Migration `20261017_growth_capacity.sql` adds append-only `growth_campaign_capacity`, a latest-version index and an immutable-history trigger. It supports existing text/varchar/UUID tenant identifiers and actor identifiers using the established migration pattern. Apply it after growth brief/review migrations.
- A campaign-scoped advisory lock plus consistent campaign/brief locking serializes confirmations, brief changes and budget decisions. The audit, append and retry record remain in the existing API transaction. Audit failure rolls back the confirmation.
- If the migration is unavailable, existing campaign views remain accessible with capacity unavailable; writes return 503 and the capacity gate remains blocked.
- The governance seed owns policy, fields, role scope, API contract, registered controls and EN/FR/ES resources before runtime implementation. The UI renders API readiness/capabilities and sends commands; it contains no SQL or authorization rules.

## Verification and release limits

Tests cover bounded inputs, expiry, zero slots, exhausted budgets, expired campaign dates, missing legacy approval evidence, role restrictions, stale brief/record versions, retries after role downgrade, tenant isolation, immutable history, audit rollback and missing-schema fallback. Browser cases exercise a real owner confirmation and check owner/operator forms in EN/FR/ES at 320 and 1440 CSS pixels. Text/UUID SQL scenarios apply the additive migration twice and verify identifier compatibility.

Local tests use synthetic records and a PostgreSQL-compatible adapter. Actual independent-connection contention, production migration/deployment, provider authorization and human/accessibility acceptance remain pending. No production record was created or changed.

Final local results: 64 combined API/browser cases, 23 policy/unit cases and two text/UUID SQL scenarios passed (89 unique cases). A final seven-case API/owner-browser rerun covers the current generated EN/FR/ES labels and captures readiness panels at 320/1440 CSS pixels. The owner browser workflow records a real synthetic confirmation and verifies the latest stored slots. Governance regeneration, TypeScript, the main browser bundle and whitespace checks passed. The registrar refreshes only unapproved capacity/readiness translations and preserves approved human translations.
