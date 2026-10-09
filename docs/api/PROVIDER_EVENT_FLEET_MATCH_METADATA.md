# Provider event, fleet and match metadata: batches 61–65

| Batch | GET route | Output |
| --- | --- | --- |
| 61 | `/v1/provider/visit-check-events`, `/{recordId}` | Event ID, stored type/result and timestamps |
| 62 | `/v1/provider/visit-check-events/summary` | Counts by stored result |
| 63 | `/v1/provider/fleet-status` | Singleton fleet ID, stored status, nullable battery level and heartbeat |
| 64 | `/v1/provider/visit-matches`, `/{recordId}` | Match ID, stored status and creation time |
| 65 | `/v1/provider/visit-matches/summary` | Counts by stored status |

All reads require active explicit bearer authentication, a matching non-null tenant and exactly one actor-owned provider profile. Event/match SQL binds provider profile ID and tenant. Fleet has no tenant column: every query joins the current owning provider profile and binds profile ID, tenant and actor user ID. This establishes current ownership rather than historical tenant attribution. No arbitrary provider, user, tenant or role selectors, new grants or mutations are included.

GPS coordinates, visit IDs, raw telemetry, rejection/override reasons and actors, client IDs and matching scores are excluded. Event results do not prove attendance; fleet status/heartbeat does not guarantee current availability or verified location; match status does not confer assignment, acceptance or patient access. No fleet default is fabricated. Absent fleet records return 404; duplicate records return 503. Battery level is a stored nullable integer, without invented ranges or quality guarantees.

Collections/summaries accept `limit` 1–100 (default 25) and `offset` 0–100000. Details and fleet singleton accept no query. Collections sort creation time descending then ID. Summaries paginate stored groups, so total counts groups. Empty collections/groups return 200; missing/unowned records/profiles return 404; invalid requests 400; inactive sessions 401; tenant mismatch 403; writes 405; source throttling 429; unavailable/malformed data 503. Reads use repeatable-read transactions and no-store caching.

OpenAPI: `provider-event-fleet-match-batches-61-65.openapi.json`. Reproducible governance registration validates schema/ownership columns and creates contracts plus existing screen links before runtime generation; API execution and page-blueprint metadata include the contracts without screen-readiness claims. Tests cover auth, projections, validation, gateways, ownership/tenant isolation, fleet ambiguity/current owner rebinding, paging and summaries. PostgreSQL gates cover UUID and text identities. No migration or deployment is included.

Model distinctions matter: `visit_check_events`, `visit_matches` and `fleet_status` refer to ProviderProfile; provider shift logs refer to User, while claims refer to InsuranceProvider. These routes do not reuse profile ownership for those distinct models.
