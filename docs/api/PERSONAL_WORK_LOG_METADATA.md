# Personal work-log metadata: batches 66–70

| Batch | GET route | Projection |
| --- | --- | --- |
| 66 | `/v1/auth/me/shift-logs`, `/{recordId}` | Shift ID, recorded date/start/end and stored shiftStatus |
| 67 | `/v1/auth/me/shift-logs/summary` | Counts by stored shiftStatus |
| 68 | `/v1/auth/me/daily-entry-records`, `/{recordId}` | Entry ID, stored status, creation/update timestamps |
| 69 | `/v1/auth/me/daily-entry-records/summary` | Counts by stored status |
| 70 | `/v1/auth/me/adl-log-records`, `/{recordId}` | Log ID and creation time |

Active explicit bearer authentication and a matching non-null tenant are required. Every query binds actor User ID and tenant, using provider_shift_logs.provider_id or adl_care_logs.provider_id (both reference User), or daily_entries.staff_id (references User). These relationships differ from provider-profile IDs used by other provider APIs. No arbitrary user/client/tenant/role filters or new role grants are included.

Responses exclude client/visit identifiers, GPS coordinates, signature URLs/data, ADL contents, medications, mood, vitals, notes and clinical care details. Authorship grants metadata access only; it does not grant access to patient records or clinical writes. Stored status labels and timestamps do not establish attendance, completed care, payroll eligibility or clinical correctness. Nullable shift end times remain null. GET does not update shift state or care records.

Collections and summaries accept `limit` 1–100 (default 25) and `offset` 0–100000. Details accept no query. Shift collections sort recorded date descending then ID; other collections sort creation time descending then ID. Summaries paginate stored status groups; pagination total counts groups, not records. The existing camel-case shiftStatus column is quoted in SQL projections and grouping and preserved in responses; no schema rename/migration is introduced.

Empty lists/groups return 200; absent/unowned details 404; invalid requests 400; inactive sessions 401; tenant mismatch 403; mutations 405; source throttling 429; unavailable/malformed data 503. Reads use repeatable-read transactions and no-store caching. OpenAPI: personal-work-log-batches-66-70.openapi.json, including schemas/examples/errors. Reproducible registration validates existing ownership/order/projection columns before runtime generation, and adds existing account screen links for page-blueprint/API execution metadata without claiming complete screens. Tests cover exact actor/tenant isolation, alternate owner columns, quoted status fields, stable paging, summaries, excluded clinical fields, validation, gateway routing and UUID/text PostgreSQL identities. No deployment or migration is included.
