# Auth namespace routing reconciliation

This package removes two scanner-created namespace declarations from the active API checklist: POST /v1/auth (ID1490) and POST /v1/auth/ (ID822). Exact historical insertion execution is not retained; the record shape matches the URL-literal scanner, and the current matching Dart strings classify authentication paths rather than issue root requests. Gateway forwarding and the Worker confirm both paths are service-status metadata, not authentication workflows.

Retirement preserves the endpoint rows as tombstones, legitimate PSW registry-domain screen mappings, and the known closed coverage diagnostic. It refuses changed identities, new artifacts, authority, contracts, callers, or unreviewed references. Both changes are atomic and repeat application is safe. Existing runtime root metadata remains compatible; login, logout, recovery, password reset and authenticated /me contracts are unchanged.

The prerequisite metadata repair is included in this backend package: 79,936 proven generated permission rows and 2,498 placeholder schemas are quarantined in derived local/CI catalogs with original records and provenance retained. Unknown metadata fails validation. The tracked seed and production databases are unchanged. Architecture migration no longer fabricates grants, schemas, or implemented handlers.

The scheduling changes in PR141 remain separate because that service change triggers the existing failed screen-governance audit. Its identical failure was reproduced at base a87bcaea. This package modifies no scheduling, screen, UI, database seed, or screen-audit workflow input; CI checks are unchanged.

Finite historical ledger after this package: 1,415 unique operations = 343 with unit evidence + 4 retired declarations + 1,058 pending + 10 explicitly blocked. Two unique declarations are resolved by retirement; zero new APIs are implemented. The eight remaining auth operations require explicit workflow authorization/contracts before implementation. No field or metadata repair earns API completion credit.

Validation: 12 auth retirement regressions, 34 metadata integrity/quarantine regressions, the complete 3,608 API fixture suite, root gateway/Worker behavior with zero SQL, Worker type checking, and real PostgreSQL CI in UUID/text configurations. CI and operation-specific production evidence remain separate from unit evidence. See auth-root-retirement-package.json and foundation-quarantine-validation.json for scope and provenance.
