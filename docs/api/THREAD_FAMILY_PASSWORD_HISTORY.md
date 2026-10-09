# Owned metadata and password history: batches 46–50

| Batch | GET route | Projection |
| --- | --- | --- |
| 46 | `/v1/client/conversation-threads`, `/{recordId}` | Thread ID, stored thread type, creation time |
| 47 | `/v1/client/conversation-threads/summary` | Counts by stored thread type |
| 48 | `/v1/client/family-links`, `/{recordId}` | Link ID, stored relationship, creation/update times |
| 49 | `/v1/client/family-links/summary` | Counts by stored relationship |
| 50 | `/v1/auth/me/password-history`, `/{recordId}` | Audit event ID, recorded action, creation time |

Client APIs require an active explicit bearer, a unique client profile belonging to that actor and a matching non-null tenant. Every query binds both profile ID and tenant; unassigned threads, other clients and other tenants are excluded. Duplicate profiles fail closed. No provider IDs, message contents, family names, phone/email, linked user IDs, access levels or notification flags are returned. A thread or family-link reference does not grant access to messages, proxy consent or emergency authority.

Password history derives ownership from the active session user and derives tenant from the current owning User on every query, since the audit table lacks a tenant column. It reads existing `auth_password_audit` events only; it does not create history or imply that missing events mean no password changes occurred. Passwords, hashes, tokens, session IDs and source IPs are excluded. The existing password-audit migration must be installed; unavailable storage returns 503. No migration or deployment is included in this batch.

Lists and summaries accept `limit` 1–100 (default 25) and `offset` 0–100000; details accept no query. Lists sort creation time descending, then ID descending. Summaries count stored labels and paginate groups, so `pagination.total` counts groups. Responses are uncached (`no-store`). Empty lists/groups return 200; absent/unowned details 404; invalid requests 400; inactive sessions 401; tenant mismatch 403; mutations 405; source throttling 429; unavailable/malformed data 503.

OpenAPI documents provide schemas, examples and errors. Reproducible registrations add ownership predicates and existing screen links for page blueprints and the API execution inventory; no new role grants or screen-ready claims. Unit tests exercise projection, ownership, validation, throttling and gateway routing. PostgreSQL CI checks UUID and text auth identities, real ownership isolation, paging, group counts, unassigned threads and existing password-audit timestamps.
