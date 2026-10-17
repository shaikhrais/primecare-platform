# Public marketing forms with territory delivery

This continuation connects the first platform bundle's enquiry routing to existing website, offline QR and referral enquiry links. It is a local implementation; no public form, campaign or production enquiry was created.

## How to use it

1. In **Growth and marketing → Website enquiries**, create a client enquiry link. Choose **Selected tenant inbox** for the existing direct flow, or **Match service territory** for the new platform routing flow. Select a valid same-tenant link owner and source; offline/referral links require attribution. Delivery mode cannot be changed after creation. To use a different mode, create another link and disable the old one.
2. Share the link or its existing QR code through an approved campaign. This implementation does not publish, send invitations or start advertisements.
3. A visitor uses the existing public form without signing in. Territory forms additionally require a Canadian postal code, PSW/home-care selection, and explicit consent to share the contact details with the matching provider. English, French and Spanish labels and language-change draft retention are supported.
4. The API routes the enquiry to the active, administratively launch-approved owner of the matching sold service territory. An enquiry with no eligible match stays in the platform administrator's review queue. It is not silently sent to another territory or copied into the source tenant's lead inbox.
5. The receiving tenant opens **Platform administration → Tenant launch & support → Territory lead routing**. It sees masked offer details before accepting. Acceptance creates its own growth lead and retains the original website/offline/referral source, originating link and attribution. The source campaign remains associated with its source link; a foreign campaign ID is not inserted into the destination tenant's CRM.

## Policy and data flow

The existing intake-manager permission controls creation: CEO, marketing, local marketing and tenant admin, within their own active tenant. The selected owner must be an active same-tenant account eligible for enquiries. Territory delivery is restricted to the client pipeline. A tenant cannot choose or submit a recipient tenant ID, overwrite territory ownership, bypass launch approval or access another tenant's offers. The link owner's identity controls link health; it is not represented as the anonymous visitor performing the submission.

Legacy links migrate to `direct`. Existing direct client and partner links retain their original response-consent payload and assigned-owner delivery. Territory forms use the same public URL family and QR generation, with server-authoritative form configuration. They require both `contact-response-v1` and `territory-sharing-v1` consent versions. The database prevents delivery-mode changes, and the existing PATCH contract accepts only active status and version.

Anonymous submissions use the same matching, deadline, deduplication and consent-withdrawal protections as staff-captured enquiries. Anonymous capture stores `created_by=NULL`; the immutable receipt records the originating link/source tenant, enquiry, request fingerprint, response/sharing consent versions, receipt time and internal first/repeat classification. It does not invent a human administrator as the submitting actor. Business state and receipt commit together; receipt failure rolls back capture.

A repeated request with the same idempotency key returns the generic acknowledgement without a second receipt. A changed payload under that key conflicts. A new submission matching an existing routed contact receives the same generic acknowledgement, records a separate receipt, and does not change the existing enquiry, reoffer an accepted/withdrawn contact, reset its deadline, change its first-touch attribution or clear an opt-out. The system conservatively treats shared household contacts as duplicates; resolving distinct people sharing contact details is a separate human workflow.

The originating tenant sees **total submission counts only** for territory links, not contacts, matched recipients, enquiry IDs or first/repeat classifications. Suppressing those classifications avoids letting a link owner infer whether a contact is already present elsewhere in the platform. Direct links retain their own existing new/repeat counters. Submission totals are not client conversions, billable care or campaign ROI; a cross-tenant acquisition/conversion report remains future work.

## Architecture and contracts

- New migration: `20261016_territory_intake.sql`, after growth intake/offline and platform-bundle migrations. It adds delivery mode, anonymous/source provenance and immutable territory receipts. It supports UUID or text tenant keys and is repeatable.
- Existing endpoints are extended; no new public endpoint is added. See [growth.openapi.json](growth.openapi.json).
- `POST /growth/intake-links` accepts optional `routingMode=direct|territory` (default direct).
- `GET /growth/enquiries/{key}` provides territory mode and sharing-consent version only for territory links. Direct-link configuration remains unchanged.
- `POST /growth/enquiries/{key}` requires postal code, service and explicit sharing consent only for territory links. Direct links reject those extra fields. Both return the same generic `202 {"accepted":true}` acknowledgement.
- All validation, matching, scope, deduplication, recipient acceptance, deadlines, transactions and audit/receipts remain in API code. Public requests omit session credentials; no database connection or server routing module is included in the browser bundle.
- Public source and link limits remain 20 and 100 attempts/minute. Invalid validated submissions count toward those limits. Disabled links or inactive/unqualified owners stop new submissions.
- The global routing advisory lock serializes both staff and anonymous captures/acceptances. Production throughput and independent-connection PostgreSQL validation remain required.
- Governance registration is `scripts/register-territory-intake.py`; it registers policy/controls after the existing growth registration and exports the affected OpenAPI schemas from persisted API rows. EN/FR/ES resources are exported by the existing growth registrar. Existing form, dropdown and checkbox adapters, tokens and stable `data-cy` selectors are reused. Implementation tags remain partial/human-pending.

## Verification

`scripts/test-public-territory-intake.mjs` tests the actual growth/public intake and platform API handlers. Its browser flow creates a marketing link, submits the public form anonymously, verifies masked recipient details, and accepts into the destination growth pipeline in EN/FR/ES at 320 and 1440 CSS pixels. It also tests consent, source/owner scope, immutable delivery mode and receipts, replay, deduplication, withdrawal, unmatched territory, direct/partner compatibility, rollback, rate limiting and source-data minimization. Tests use synthetic records, then drop their schema and verify absence.

```bash
python3 scripts/register-growth-governance.py
python3 scripts/register-territory-intake.py
python3 scripts/register-territory-intake.py --check
PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-public-territory-intake.mjs
PLATFORM_TEST_DATABASE_URL=postgresql://… PLATFORM_TEST_IDENTITY=text node --test scripts/test-public-territory-intake.mjs
```

The platform acceptance workflow runs both tenant-key variants against PostgreSQL. Local compatible-adapter runs skip the independent-connection race test. Physical-device/native Flutter parity, full Cypress/WCAG acceptance, human approval, provider connections, production-volume verification and deployment remain pending. No live outreach, production records or release publication is claimed.

Local results on 2026-10-16: **36 new checks passed** across UUID/text tenant variants, including **12 browser handoff cases** in EN/FR/ES at 320/1440 CSS pixels. **25 first-bundle regression checks and two legacy direct-intake SQL scenarios passed**. Three independent-connection cases were skipped locally; the PostgreSQL acceptance workflow includes them. All nine website variants built, TypeScript 5.9.3 checks passed, and governance/OpenAPI verification passed against both the working database and a clean committed database snapshot. Screenshots under `test-results/territory-intake/` use synthetic data.
