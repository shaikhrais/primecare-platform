# Reviewed source amendments for communication integration

Reviewed at `ee0beb60059a3f4dbf8c3beffc6f6afce2e0e903`.

The contract-plan gate failed because five files changed after the historical
review. Those changes are now recorded as exact reversible amendments in
`workflow-contract-source-amendments.json`. The original review manifest, source
hashes, generated plans, declaration identities and operation stages are preserved.
This review grants no permission, endpoint activation or implementation credit.
It is a source-evidence reconciliation, not production business authority.

| Source | Reviewed change | Pending-contract conclusion |
| --- | --- | --- |
| `cloudflare/workers/src/auth.ts` | Tenant-bound session projection; current role/tenant comparison during session insertion; native tenant returned by login and `/me`. | Canonical identity reads remain reads. Refresh, role switch, whoami, OAuth, impersonation and provisioning contracts remain unresolved. |
| `cloudflare/workers/src/gateway.ts` | Exact registered communication method/path forwarding, with a 405 for other methods. | No wildcard mount, legacy workflow alias or resource permission is added. The target retains native session and endpoint/resource authorization. |
| `packages/flutter_core/lib/src/network/api_client.dart` | Existing Dio/session middleware composes the inherited communication hub and registered bindings. | No new identity, default access, cached mutation success, retry or pending-workflow implementation. |
| `scripts/register-method-capture-blockers.py` | Gateway fingerprint plus byte-exact recovery of the earlier gateway after removing its communication amendment. | Method/caller blocker identities, registration scope and dispositions stay unchanged. |
| `scripts/audit-api-reachability.mjs` | Same reviewed gateway fingerprint. | Existing classifications remain separate from implementation and verification credit. |

Each amendment pins the complete current file hash and historical baseline hash.
The checker reverses only the recorded, uniquely matching text hunks and requires
an exact match to the original baseline bytes. Extra drift, a source reversion
under a current amendment, an altered reconstruction, ambiguous matches, unknown
sources, unsafe paths, escaping symlinks, duplicate entries and nonzero credits
are rejected. An absent amendment does not permit source drift. Future changes
require their own review; there is no automatic hash refresh or fallback.

The checker loads amendments from the repository's fixed review path when source
validation is requested. The contract factory and bulk generator use the same
checker. Historical `sourceHashes` in generated descriptors identify the original
review, not the amended current bytes; the amendment file records that relationship.
Generated descriptors remain nonexecutable and are unchanged by this reconciliation.

Local validation passed:

- 15 contract-plan tests, including six amendment security cases.
- 15 contract-factory tests and seven bulk-generator tests.
- Ten method/caller registration tests using an in-memory isolated fixture.
- 26 Node tests for real gateway dispatch, native tenant projection, method/caller
  classification, denied methods and unchanged pending-operation counting.
- All three generated-artifact `--check` commands without regeneration.

The baseline remains 1,415 exact operations: 1,049 needing contracts, 14 blocked,
343 with unit evidence and nine retired with evidence. The 1,063 unresolved
operations retain their prior states and receive zero implementation or retirement
credit from this review. These are historical API-plan counts, not a current
production business-process catalogue or proof of completed workflows.

Runtime communication evidence for the reviewed source includes successful runs
[40007629056](https://github.com/shaikhrais/primecare-platform/actions/runs/40007629056)
and [40007629131](https://github.com/shaikhrais/primecare-platform/actions/runs/40007629131).
They exercise disposable PostgreSQL, browser messages/pictures/audio/mail flows
and denial/revocation. Provider delivery ports are synthetic; live Twilio/SMTP
acceptance, registered voice endpoints/policies, secure provider/model bindings,
production schema application and extension publication remain separate gates.
