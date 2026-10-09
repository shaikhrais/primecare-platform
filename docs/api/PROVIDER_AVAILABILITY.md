# Provider availability detail and weekday summary (Batch 16)

`GET /v1/provider/availability/{availabilityId}` returns one owned availability record as `availability: {id, day_of_week, start_time, end_time}`. It binds provider profile, tenant and exact record ID. Absent, other-provider and foreign-tenant records return 404. IDs follow the existing bounded alphanumeric/underscore/hyphen convention. Query parameters and request bodies are rejected.

`GET /v1/provider/availability/summary` returns `groups: [{day_of_week, count}]` and `pagination: {limit, offset, total, hasMore}`. Groups use stored integer weekday values in ascending order. Total counts weekday groups. The summary counts records, including multiple records on the same day; it does not calculate booking capacity, merge overlapping intervals, interpret timezone or assume weekday numbering.

Summary paging accepts only limit 1–100 (default 25) and offset 0–100000 (default 0). Empty data returns an empty array and total zero. Unsupported filters, repeated parameters and bodies receive 400; mutations receive 405. The literal summary route is reserved before ID matching.

Both routes require an explicit active, unexpired bearer session, exactly one owned provider profile and matching tenant. They retain source throttling, read-only repeatable-read transactions, no-store responses and explicit projections. Backend failures and ambiguous profiles return 503. No new role grants or write audit events are introduced.

The reproducible registration script links both contracts to the existing provider profile screen, making their metadata available through governance page blueprints. See `provider-availability-batch-16.openapi.json`. Screen production readiness remains unchanged.

Validation: 180 local API fixtures, worker TypeScript checking and governance guardian checks pass. Real PostgreSQL tests add owned/foreign detail checks, same-weekday aggregation, stable group pagination and empty summaries for both auth identity types in CI. Local evidence makes no PostgreSQL or production verification claim. Availability write workflows and legacy domain-route hardening remain outstanding.
