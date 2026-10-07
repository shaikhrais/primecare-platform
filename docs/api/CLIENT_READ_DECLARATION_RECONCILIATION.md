# Client declaration reconciliation

Two stale POST declarations are retired, not counted as new API implementations. The baseline includes their historical identities through client-read-retirement-package.json. Canonical GET contracts and runtime behavior remain unchanged.

| Legacy operation | Disposition | Evidence |
| --- | --- | --- |
| POST /v1/client/home/profile | Retain retired tombstone ID235; use existing owner GET | No screen_api_links or screen_api_map; no executable method caller; clientSelf exact profile GET and 405 for writes |
| POST /v1/client/invoices | Retain retired tombstone ID239; use existing owner GET | No registered screen link/map; domain tenancy registry only supplies path; clientSelf owner invoice GET and 405 for writes |

Literal and API variable callers were checked across apps, services, packages/domain/src and packages/primecare_ui. Generated contract declarations, fixtures and historical reports are declaration artifacts, not executable caller proof. There are no corresponding api_registry or api_endpoint_registry rows for the two retired operations. The reconciliation script refuses changed identities, missing canonical ownership/schema contracts and newly registered screen callers. Reruns are safe. Retired endpoint rows remain as tombstones so existing foreign-key references are preserved; the active inventory excludes them and the finite ledger retains their historical identities.

Client feedback remains a genuine POST workflow: FormRegistry/client-forms.ts submits visitId, rating and comment. Existing GET /feedback authority does not authorize submission. No write is synthesized. POST /feedback/analytics and POST /feedback/surveys are captured by the generic feedback item GET pattern, not real analytics or survey workflows; these remain unresolved. POST /profile/medical-summary has no existing exact handler and remains unresolved.

Validation: 33 client-self unit tests passed, including gateway forwarding, owner/tenant isolation and mutation rejection. Existing scripts/test-client-self-postgres.mjs is the canonical read PostgreSQL suite; integration must retain its CI pass. Production was not contacted.
