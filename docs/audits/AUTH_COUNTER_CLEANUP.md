# Expired authentication counter cleanup

The existing login rate limiter resets an expired counter when its email is used
again, but never removes counters for abandoned email addresses. This maintenance
job bounds that growth without changing the configured login limits or expiry.

The production workflow runs hourly at minute 17. Manual runs default to preview;
select `apply` to delete. It uses the existing protected production environment and
PRODUCTION_DATABASE_URL secret. No accounts, sessions or audit logs are touched.

Each run deletes at most ten batches of 1,000 counters whose existing `reset_at`
has passed. Row locks and SKIP LOCKED preserve counters in use by concurrent logins.
A login that refreshed a counter before cleanup acquired it remains protected.
Output contains only counts and whether the batch limit was reached, never subject
hashes, emails, credentials or database errors. A full final batch may indicate
backlog; the next scheduled run continues. Locked rows can also defer to a later run.

Preview: `node scripts/cleanup-auth-rate-limits.mjs`

Apply: `node scripts/cleanup-auth-rate-limits.mjs --apply`

Four unit tests cover preview defaults, validation and bounded execution. The
disposable PostgreSQL test checks active, expired, locked and refreshed counters,
with isolated fixture tables. No production execution is claimed by these tests.
This closes counter housekeeping only; source/IP abuse controls and password
recovery delivery remain separate work.
