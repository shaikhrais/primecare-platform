# Personal metadata APIs: batches 41–45

All routes use GET, active explicit bearer authentication and the current owning User tenant. No role grants, mutations or UI changes are included. These source tables lack tenant columns: historical tenant attribution is unavailable, so scope is derived from the owning user on every query.

| Batch | Route | Output |
| --- | --- | --- |
| 41 | `/v1/auth/me/health-ids`, `/{recordId}` | Health-ID record ID, stored status and timestamps |
| 42 | `/v1/auth/me/health-ids/summary` | Counts by stored status |
| 43 | `/v1/auth/me/survey-submissions`, `/{recordId}` | Submission ID, opaque survey ID and creation time |
| 44 | `/v1/auth/me/survey-submissions/summary` | Counts by opaque survey ID |
| 45 | `/v1/auth/me/group-memberships`, `/{recordId}` | Membership ID, opaque group ID, stored role and creation time |

DIDs, public keys, survey answers, survey definitions and group contents are excluded. Health-ID status does not establish identity verification. Membership roles do not confer API authorization. Summary totals count distinct groups, not records. Use returned survey/group IDs only as opaque references; these endpoints do not grant access to related resources.

Collections and summaries accept `limit` (1–100, default 25) and `offset` (0–100000). Details accept no query. Collections order by creation time descending, then ID descending; summaries order by registered group key. Empty collections/summaries return 200; unowned or missing details return 404. Malformed requests return 400, inactive sessions 401, tenant mismatch 403, writes 405, throttling 429 and unavailable/malformed data 503. Responses use `Cache-Control: no-store`.

OpenAPI: `personal-metadata-batches-41-45.openapi.json`. Governance page blueprints and API execution inventory contain the registered contracts and account-screen links. Screen links describe available APIs, without certifying a complete page. Local unit evidence is recorded separately from real PostgreSQL CI and production verification. No deployment or migration is included.
