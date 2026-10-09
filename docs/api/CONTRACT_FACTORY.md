# Bulk contract factory

Run the full finite checklist in one command:

```sh
python3 scripts/primecare-contract-factory.py
```

The utility verifies the reviewed source fingerprints, preserves every exact method/path and declaration ID, and generates all unresolved workflow structures together. It reads the existing governance-derived checklist and reviews; it never changes the governance database or readiness ledger.

Generated files in `docs/api/contract-factory/`:

| File | Purpose |
| --- | --- |
| `bundle.json` | One source-bound contract structure per unresolved operation, with workflow-family assignments |
| `openapi-drafts.json` | OpenAPI 3.1 review drafts; explicitly nondeployable |
| `decision-index.json` | Missing decisions by operation and structure slot |
| `execution-summary.json` | Exact operation counts, provenance hashes and separate structure/API credits |

Each operation has request, response, validation, authentication, authorization, permission, rate limits, audit, errors, version, workflow, persistence, idempotency, tests, client binding and example slots. Missing values remain null. Route-based archetypes are routing hints, never business requirements or authorization. Evidence is stored once per review and linked by `reviewSourceReferenceId`; family policy questions are linked by `policyQuestionFamilyKey`. The decision index stores operation identities once in `operationReferences` and common questions once in `questions`, with exact `{api, slot}` decision records.

Validate the generated snapshot without writing:

```sh
python3 scripts/test-primecare-contract-factory.py
python3 scripts/primecare-contract-factory.py --check
```

The utility also accepts explicitly defined structures with `--contracts path/to/contracts.json`. The input envelope contains `version: 1`, `noActivation: true` and a `contracts` array. Each record identifies its exact `api` and `declarationIds`, has `noActivation: true`, and supplies all sixteen slots as `{ "value": ..., "sourceReferences": [{ "path": "...", "sha256": "..." }] }`. Every reference must match reviewed evidence. Use `SLOT_KEYS` and `validate_contract()` in the utility and the test fixture for the exact structural shape; the fixture is test data, not business authorization.

Explicit compilation checks schema vocabulary, local references, parameter uniqueness, required path parameters, exact caller bindings, positive rate bounds and complete actor/tenant/ownership/delegation/state descriptions. Schema support is intentionally conservative; unsupported keywords fail rather than being silently ignored. Source attribution and structural validation do not establish governance approval or prove that a policy is correct.

All outputs retain `noActivation: true`. Fully supplied structures remain unimplemented. The factory generates no runtime handlers, permissions, database migrations or API completion credit. Existing handlers, operation-specific authorization enforcement, database behavior and meaningful workflow tests must establish API completion separately.

CI runs the factory regression tests and source-verified stale-output check on relevant changes. Output paths are preflighted before writes; checks fail without rewriting stale artifacts.
