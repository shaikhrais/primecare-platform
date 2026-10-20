# Administrator session revocation repair — 2026-10-20

Inspected current remote main at d8db97e641a31e81879268c6dd27e9622738dcf3. Remote branch inventory contained only main; the GitHub open-PR inventory was empty. No branch or PR was created.

The existing native fault producer in tools/auth-verification/test-admin-revocation-fault.mjs demonstrated an administrator revocation that acknowledged success while a database trigger retained one target session. The handler now verifies zero remaining target sessions before writing the success audit or committing. A nonzero or malformed count throws and the existing transaction rolls back. The existing streamed-body helper is shared with administrator dispatch so a zero-byte DELETE reaches the unchanged method/query/actor/tenant checks; any content bytes remain invalid.

Local validation: 242 tests passed across administrator API, self sessions, auth API, management, recovery, password, bootstrap, client, source limits, rate limits, maintenance, cleanup and schema suites. Worker auth TypeScript checking and git diff --check passed. New regressions cover partial deletion, invalid remaining counts, empty streamed bodies, forbidden roles, foreign tenants, invalid queries and nonempty bodies.

Two browser producers could not start because Playwright is absent. The recovery browser producer additionally directly reads the removed operational SQLite path; it must be migrated to the pinned authority before production acceptance, rather than recreating governance.db. Native PostgreSQL fault tests were not run locally: this container lacks a PostgreSQL service and cannot change user/group identity to start the disposable PostgreSQL binaries. These checks remain required in CI.

Live blockers in this session: neither GOVERNANCE_DATABASE_URL nor PRODUCTION_DATABASE_URL is configured. The pinned reader fails closed with `configuration / ERR_INVALID_URL`. Protected workflow dispatch via the GitHub REST API returned HTTP 401 Requires authentication. No production metadata, acceptance status, business records or deployed Worker was changed by this local verification. Existing live-mail proof is recorded in auth-live-mail-20261020.md; it is historical evidence, not a new delivery test in this session.

Full auth acceptance remains incomplete. This change repairs an existing contract; it does not invent new workflow definitions or promote verification tags.
