# Batch B01 — Theme adoption reconciliation and registration preparation

Requirement: user requested the next batch of the 18-batch original PrimeCare theme adoption plan on 2026-10-31.

**Status: source preparation validated; GitHub production connection and pinned manifest verified. Registration gaps remain; B01 is not complete.**

## Delivered

- A data-only proposal covering 72 feature groups, including all 24 existing reference core families, 15 application templates, four dashboard templates and eight supporting-page groups.
- Candidate mappings for every one of the 389 files in the existing skeleton inventory. Mapping a file is not adoption or runtime verification.
- Dispositions for all 78 recorded Material UI component/style/type imports. Import names are references, not a request to copy a vendor implementation.
- 25 proposed/existing control identities and 40 proposed resource keys with English, French and Spanish text: 120 text entries. Translations remain unreviewed and unapproved.
- Source hashes for mapped PrimeCare implementations; candidate component codes, existing source-host paths and semantic-token source files. Source presence is recorded as unverified.
- A strictly read-only production metadata preflight and nine passing local test groups for coverage, identity conflicts, translation preservation, missing/disabled registrations, denied hosts and parameterized SQL.
- Separate source-validation and production-connection receipts. Both explicitly deny production activation and runtime-verification claims.

## Files

| File | Purpose |
| --- | --- |
| `tools/governance-production/theme-adoption-contract.json` | Proposed feature/control/resource contract; not an authoritative production registry |
| `tools/governance-production/theme-adoption-preflight.mjs` | Source checks and read-only production reconciliation |
| `scripts/test-theme-adoption-preflight.mjs` | Isolated tests; synthetic fixture IDs have no production meaning |
| `docs/appearance/theme-adoption-source-preflight.json` | Local contract-validation receipt |
| `docs/appearance/theme-adoption-production-preflight.json` | Production connection attempt and blocker receipt |

## Run checks

From the repository root:

```sh
node --test scripts/test-theme-adoption-preflight.mjs
node tools/governance-production/theme-adoption-preflight.mjs --check
node tools/governance-production/theme-adoption-preflight.mjs --production --out docs/appearance/theme-adoption-production-preflight.json
```

`--check` validates local proposal coverage, file hashes, resource completeness and non-activation claims. It does not contact production.

`--production` uses the existing pinned `read-bridge.mjs`, which opens a read-only PostgreSQL snapshot and validates the production manifest. The tool reads only an allowlist of UI components, languages/resources/translations, screen/control metadata and existing screen-view grants. Values are parameterized; unknown or mixed schema columns fail. It does not add grants, register controls, modify settings, write business data or alter the manifest.

Exit status 2 means connection blocked or unresolved registration gaps. A successful source check does not satisfy the production gate. Even a complete isolated metadata fixture yields only candidate registration matches, never activation or runtime proof.

## Production blocker and remaining B01 work

The local attempt returned `MISSING_DATABASE_URL` before a production snapshot opened. Existing repository workflows use `secrets.PRODUCTION_DATABASE_URL` through the GitHub `production` environment. The new `.github/workflows/theme-adoption-preflight.yml` follows that existing pattern and runs on relevant pushes to main or manual dispatch. It keeps the credential inside GitHub Actions and publishes read-only reconciliation receipts as workflow artifacts. The local receipt does not establish which controls, hosts or resources already exist in production; inspect the exact workflow run before reporting live results.

The repository rule in `.agents/AGENTS.md` states: “Everything must exist in the pinned production governance database before implementation.” New live Theme Center controls therefore remain unexposed.

To finish B01:

1. Run the dedicated GitHub workflow with the existing `production` environment secret. Check its artifact and exact commit before claiming a connection or production reconciliation succeeded. A local URL is optional; do not extract, print or commit the GitHub secret.
2. Run the production preflight against the pinned manifest. Resolve exact existing host screen IDs, component identities, resource IDs, reviewed translations and existing grants from returned records.
3. Review the proposed feature/template mappings and draft translations. An existing reviewed translation conflict must be reconciled explicitly, never overwritten automatically.
4. Specify any unresolved business-template API/workflow/permission bindings from existing authority. Do not invent endpoints, screens, role grants or acceptance credit.
5. Prepare the exact scoped production registration writer using the observed schema and bindings; pin its allowed tables and payload hash. No general metadata writer is added by this batch.
6. Execute an idempotent registration transaction, read back independently, export approved identifiers/resources and retain honest implementation tags. A read-only preflight is not a registration transaction.
7. Update B01 evidence before enabling B02's live controls. Keep B02–B18 planned until their dependencies are satisfied.

The existing shell, Theme Center, authentication and working application permissions are unchanged. Planning and isolated source/test preparation can proceed while this production dependency is unresolved.

## Verified GitHub production result

Run `41225732414`, production job `124609431208`, on commit `119b0094b071e03c1f3707e0abbf749b5d1b6229` used the existing environment secret without retrieving its value. Source CI passed. The production snapshot and pinned manifest check succeeded; the reconciliation correctly exited 2 because it found registration gaps. The receipt records `productionChecked: true`, `writes: 0`, `runtimeVerified: false` and `productionActivationAllowed: false`.

Observed gaps: all 25 proposed/existing-selector control bindings and all 40 new resource keys were absent under the requested identities; `prime_button` and `prime_text_field` exist, but `prime_dropdown` does not; no host was resolved by the known helper-source paths. These are exact-key results, not proof that no equivalent component or settings host exists under another name. Bounded metadata discovery now inspects candidate theme/layout host and dropdown/select component names without treating discoveries as authoritative bindings.
