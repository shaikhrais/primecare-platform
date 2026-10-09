# Bulk requests and code placement

Generate the source-bound request batch and place all generated contract-review code:

```sh
python3 scripts/primecare-bulk-codegen.py
```

Execute that exact batch explicitly:

```sh
python3 scripts/primecare-bulk-codegen.py --requests docs/api/contract-factory/code-requests.json
```

The batch covers every unresolved exact method/path in the existing finite checklist. Source fingerprints, declaration IDs, families, missing slots and output destinations must match the contract factory. Added requests, changed methods, fake approvals, altered output targets or stale source bindings are rejected before writes.

| Generated destination | Purpose |
| --- | --- |
| `docs/api/contract-factory/code-requests.json` | Complete input batch for the utility |
| `packages/domain/src/generated/unimplemented-workflow-contracts.ts` | Typed, immutable TypeScript contract-review descriptors and execution refusal guard |
| `packages/flutter_core/lib/src/generated/unimplemented_workflow_contracts.dart` | Matching const Dart descriptors and execution refusal guard |
| `cloudflare/workers/contracts/unimplemented-workflows.json` | Worker review manifest, outside gateway registration |
| `docs/api/contract-factory/code-placement.json` | Output paths, content hashes and honest unique operation counts |

The two language representations describe the same operations; they never multiply the API count. No generated descriptor is an implemented workflow. Runtime guards throw for known unresolved operations and unknown operations. The code creates no request or response DTOs, authorization grants, database writes or HTTP handlers. It is not imported into the gateway or public Flutter barrel.

The existing contract factory supplies evidence and missing business decisions. This generator places code for reviewing those contracts in the corresponding packages; it cannot infer missing policy or safely implement its data mutations. Zero API completion credit is recorded.

Check reproducibility without writing:

```sh
python3 scripts/test-primecare-bulk-codegen.py
python3 scripts/primecare-bulk-codegen.py --check
```

The generator preflights all fixed destinations before writes and refuses unsafe symlinks or unmarked existing files. CI also typechecks the TypeScript module and tests/analyzes the Dart module. Real workflow implementation and authorization enforcement remain separate requirements.
