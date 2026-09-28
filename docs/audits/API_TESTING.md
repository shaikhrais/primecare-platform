# API test coverage

Run `node scripts/test-worker-endpoints.mjs` to regenerate the governed inventory
and exercise the actual gateway and Worker handlers for every registered operation.
The test bundles TypeScript in memory with esbuild. PostgreSQL connections are
intercepted and rejected; bcrypt is stubbed. No real credentials or database are used.
Each operation currently has one test: the registry requires authentication, so
an anonymous request should receive 401/403 before database access. A 404 fails
rather than being treated as a successful authorization test.

This tests a registry requirement, not all business behaviors. In particular,
public login returning 400 for empty input is correct runtime behavior but conflicts
with the registry's authentication requirement. Idempotent anonymous logout may
also be intentional; its mismatch needs a reviewed governance decision.

Additional tests verify rejection of untrusted origins on all 12 services, empty
login input, and the current GET session endpoint. The JSON report includes every
test and failure; the process exits nonzero when any assertion fails.

Run `python3 scripts/test_public_api_health.py` for limited production smoke tests.
It checks gateway/service health, credential-free authentication rejection, and
documentation availability with three concurrent requests and 20-second timeouts.
It never submits business mutations, credentials, or patient data and never records
response bodies. The reports are generated under `docs/audits/`.

Neither suite proves successful login, authorized payload correctness, tenant
isolation, data persistence, or transaction behavior. These require approved
contracts and isolated integration fixtures. A passing health response only shows
that the health handler works, not that business operations are implemented.
