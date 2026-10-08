# API diagnostics in one report

Import `PrimeCare.postman_collection.json` and `PrimeCare.local.postman_environment.json` into Postman. The collection contains every active exact method/path from the finite checklist; retired declarations are excluded. Dynamic record identifiers are synthetic. Requests use no authentication and `{}` mutation bodies. The collection refuses remote destinations by default. Its collection variables `operationResults` and `errorReport` collect status summaries without response bodies or credentials.

With repository dependencies installed, run from the repository root to generate the importable collection and the reproducible offline report:

```sh
npm install --no-save --package-lock=false --ignore-scripts newman@6.2.1
node scripts/generate-primecare-postman.mjs
PRIMECARE_NEWMAN_PACKAGE=/tmp/primecare-wave-node/package.json node scripts/run-primecare-api-diagnostics.mjs
PRIMECARE_NEWMAN_PACKAGE=/tmp/primecare-wave-node/package.json node --test scripts/test-primecare-api-diagnostics.mjs
```

The runner verifies exact active checklist membership before execution. It executes Newman requests on a randomly assigned IPv4 loopback port against the actual bundled gateway and Worker service sources. Every PostgreSQL connection/query is denied before SQL, external Worker `fetch` is denied, email is disabled, and rate-limit fixtures permit requests. The offline view strips scripts, credentials, imported payloads and arbitrary variables; uses synthetic identifiers and empty JSON; preserves each declared HTTP method; and does not follow redirects. A separate integration test executes the generated collection's original pre-request and aggregation scripts in the actual Newman sandbox.

`primecare-api-error-report.json` is the single aggregate artifact, with one result per exact method/path and distinct authentication-required, route-not-found, method-rejected, request-contract-needed, server/unsupported/database-probe-blocked and transport-failure classifications. A received 2xx response is only an observation. A 401 or 403 does not verify authorized behavior. A 5xx result can reflect the intentionally blocked offline database probe and does not establish a production outage. The report records neither request/response bodies nor raw exceptions.

The finite baseline remains 1,415 operations: 1,406 active and nine retired. This scan supplies no API completion credit, no business authorization proof and no production verification. Importing the collection does not connect the offline runner to production.

By default Newman resolves from the repository dependencies; PRIMECARE_NEWMAN_PACKAGE selects an optional separate dependency directory. Newman is pinned to 6.2.1. Its Node API and package are maintained at https://github.com/postmanlabs/newman and https://www.npmjs.com/package/newman.

The local environment defaults to `http://127.0.0.1:8787`; use your local development server there when running directly in Postman. The offline runner starts and closes its own loopback fixture automatically. To use Newman from an isolated installation, set `PRIMECARE_NEWMAN_PACKAGE` to that installation’s absolute `package.json` path.
