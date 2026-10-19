# Isolated availability API fixture

Run `node --test scripts/test-care-availability-api.mjs` with esbuild and the CI-pinned PGlite dependency installed. `python3 tools/workflow-verification/progress.py --run-small-checks` records a source-bound receipt and updates the engineering tracker in governance.db.

The fixture creates a fresh in-memory PostgreSQL engine, synthetic tenants, users and session hashes. It applies the real care migrations twice and calls the production care handler, repository, authentication and staffing commands. Business results are created through the handler rather than seeded. The adapter only maps the pg Client interface to the embedded engine; it does not rewrite SQL. It has no production database connection.

Five sequential checks cover persistence and audit events, idempotent retry, role denial and cross-tenant staff selection, fresh API snapshot and foreign withdrawal denial, invalid dates and expired sessions, changed-payload replay, and injected audit failure with rollback and safe retry. Checks are grouped into five test cases.

This evidence covers authenticated API calls using synthetic pre-created sessions. It does not cover credential login, browser interaction, video, native PostgreSQL connection handling or concurrent transactions. A shared in-memory connection is intentionally unsuitable for concurrency tests. The registered PSW workflow stays pending until its full acceptance criteria and review gates pass.
