# Administrative attention queue

Open **Platform administration → Tenant launch & support → Attention queue**. This extends the selected first bundle with one place to find outstanding work and navigate to its existing workflow. No production data or notifications were created.

## What appears

| Workflow | Inclusion | Deadline treatment |
| --- | --- | --- |
| Support | An unresolved ticket whose first platform response or resolution is overdue | Earliest outstanding deadline; active eligible support owner is indicated; inactive/ineligible assignments require reassignment |
| Documents | Latest revision per tenant and document kind that is pending, rejected, expired, or expires within 30 calendar days | Expiry is inclusive through its Toronto date; overdue begins the following midnight. Pending/rejected documents outside the renewal window have no invented review deadline |
| Lead offers | Expired pending offers and unmatched enquiries | Expired offers retain their acceptance deadline; unmatched enquiries have no deadline and remain global-only |
| Launch | A submitted administrative launch review | No deadline is invented; waiting for review is not classified as overdue |

Counts are work items, not unique tenants or employees. A tenant may have several items. Missing documents that have never been uploaded, missing setup records, late completed work and other care/workforce operations are outside this queue; the existing tenant setup overview, launch checklist and support history continue to show those details where applicable. This is not a clinical-readiness check or an automated employee-pay/disciplinary decision.

## Scope and workflow

Central and platform administrators receive the global queue. Tenant administrators receive only their own tenant's items, totals and search results. The top-bar tenant selection deliberately does not filter the queue; the page explains its scope. Unmatched enquiries have no recipient tenant and are not exposed to tenant administrators.

Use a workflow filter or search by tenant name, tenant code/slug or record ID. Searches are literal and case-insensitive. Pages contain at most 20 items, ordered by overdue status, deadline and stable record identity. Summary counts cover the whole filtered result.

**Open workflow** selects the permitted tenant and opens Documents, Support, Territory lead routing or Launch. Support and offer links filter the destination by record ID. The link preserves a tenant outside the top-bar's initial hundred records. Documents open that tenant's revision history; launch opens its checklist. Existing API permissions still determine what the user can change. Opening an item neither completes nor approves it.

After correcting work, return to the queue or refresh it to recompute eligibility. Resolved support tickets leave the active queue, superseded document revisions do not produce duplicate renewal items, and accepted/declined offers are excluded. A failed refresh clears stale queue counts/items while preserving the filter draft.

## API and governance

`GET /v1/governance/platform/bundle/attention`

Allowed query parameters: `kind=all|support|documents|offers|launch`, `search` (maximum 100 characters), and `offset` (integer 0–100000). Unknown/repeated parameters, tenant overrides and unsupported methods are rejected. The endpoint shares the first bundle's active bearer-session, role, home-tenant and 120-read/minute policy. Aggregates and pages are read in one repeatable-read transaction. No new operational tables or migration are required beyond the existing bundle.

The queue projects only workflow type, reason, record ID, tenant name/code, deadline, overdue flag, support-assignment flag and destination. It excludes client contacts, ticket subjects/messages, document filenames/content and employee contact details. File bytes are not selected by the query. All eligibility, scoping, deadlines and database reads remain in the API. The browser renders API results and calls the existing correction workflows.

The policy, read contract, controls, approved component maps, stable test IDs and EN/FR/ES text are registered by `scripts/register-platform-bundle.py`. The response schema and query parameters are in [openapi.json](openapi.json). The shared theme and responsive card/list presentation are reused. Controls and the overall implementation remain partial/human-pending until the repository's full acceptance gates are met.

## Verification

`scripts/test-platform-attention.mjs` checks role/scope boundaries, exact totals, contact minimization, Toronto expiry boundaries, latest revisions, response versus resolution deadlines, literal filtering, pagination and canonical text IDs. Six browser cases use EN/FR/ES at 320 and 1440 CSS pixels. They find a tenant beyond the first hundred, open its exact support record by keyboard, resolve it, confirm removal from the queue, and exercise failed-refresh recovery. Synthetic schemas are removed and absence is verified.

```bash
python3 scripts/register-platform-bundle.py
python3 scripts/register-platform-bundle.py --check
PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-platform-attention.mjs
```

The PostgreSQL acceptance workflow now includes this suite. Local SQL verification uses an explicit PGlite adapter and headless Chromium. Standard PostgreSQL CI, production-volume performance, full Cypress/WCAG and screen-reader acceptance, physical devices/native Flutter, human review and deployment remain pending. Screenshots are local synthetic evidence under `test-results/platform-attention/`.

### Verified local results — 2026-10-16

- Attention queue: 13 passed, 0 failed, 0 skipped, including six browser cases across EN/FR/ES at 320 and 1440 CSS pixels.
- Existing first bundle: 25 passed; public intake and routing: 18 passed. Combined with the attention suite, 56 local checks passed. Two independent-connection PostgreSQL contention cases were skipped locally and remain for standard PostgreSQL CI.
- All nine website variants built successfully. TypeScript checking, whitespace validation, and governance registration checks against both the working database and a clean committed snapshot passed.
- Browser evidence uses synthetic records and headless Chromium. These results do not establish production deployment, physical-device coverage, or completed human acceptance.
