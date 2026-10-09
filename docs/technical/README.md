# PrimeCare technical specification and operating manual

## Purpose and evidence boundary

This documentation baseline describes how to develop, validate, operate, and release PrimeCare, and records the work still required before its unresolved workflows can run. Source baseline: `3979ed1028c8b7dfdb9acca72b1ea53d4d034127`. The documents are technical requirements and operating instructions, not a statement that every requirement is implemented or that production is ready.

The governing repository rules are `.agents/AGENTS.md`. Governance declarations, explicit grants, actual callers, persistence models, handlers, and tests must agree. A generated file, descriptive route name, an `active` database label, or a passing nonblocking aggregate cannot establish that agreement alone.

### Requirement vocabulary

| Label | Meaning | Implementation consequence |
| --- | --- | --- |
| Observed | Verified against the cited source at the baseline commit | Preserve and test the actual behavior; investigate conflicting evidence |
| Required | Repository rule or acceptance criterion for the planned implementation | Work is incomplete until evidence demonstrates it |
| Proposed | An engineering or business choice awaiting a recorded decision | Do not treat it as an approved permission, workflow, or production setting |
| Open | Source does not define the needed rule, or sources conflict | Record the question, owner responsibility, options, and dependent tasks |
| Verified | A specific test or inspection passed against an identified version | State exactly what it proves and what it does not prove |

## Reading order

For a single-file version of all chapters and the family register, open [the complete technical manual](PRIMECARE_TECHNICAL_MANUAL.md).

1. [System requirements](system-requirements.md): product boundaries, project inventory, detailed requirements and acceptance criteria.
2. [Architecture and data](architecture-data.md): runtime topology, bounded contexts, models, transactions and invariants.
3. [Security and authorization](security-authorization.md): observed identity/session behavior, role/tenant/resource boundaries and unresolved policies.
4. [API and workflow contracts](api-workflow-contracts.md): the 16 required contract sections, field-level authoring rules and domain-specific questions.
5. [Runtime operations](runtime-operations.md): prerequisites, local development, configuration, deployment, database operations and incident procedures.
6. [Testing and release](testing-release.md): test layers, evidence requirements, release gates, rollback and artifact validation.
7. [Implementation plan](implementation-plan.md): ordered work packages, dependencies, task breakdown and exit criteria.
8. [Identity work package](identity-work-package.md): a concrete example of reconciling primary evidence, conflicting methods, DTOs and incorrect grant attribution.
9. [Family decision register](family-decision-register.md): exact operation membership and actual outstanding decisions for all 106 reviewed families.
10. [Operation register](operation-register.json): every exact method/path pair, declaration IDs, baseline evidence stage and contract obligations.
11. [Project inventory](project-inventory.json): source-pinned project directories and manifest blob identities.

## Current finite baseline

| Stage | Unique operations | Interpretation |
| --- | ---: | --- |
| Unit evidence recorded | 343 | Evidence of focused tests exists; operation-specific PostgreSQL and production evidence is not mapped |
| Retired with evidence | 9 | Declaration retired with an explicit reason; this is not a new runtime implementation |
| Needs contract and verification | 1,049 | Implementation and/or contract evidence is unresolved |
| Explicitly blocked | 14 | A known blocker prevents progression |
| Total | 1,415 | Fixed method/path baseline; duplicate references never multiply this count |

The 1,063 unresolved operations belong to 106 reviewed families. The earlier contract factory produced 1,063 draft structures with 17,008 missing decision slots. Those counts describe documentation gaps, not the number of independent business approvals necessarily required: a verified shared policy can address several operations, but equivalence must be explicit.

## How to use these specifications

For a selected operation, locate its immutable `API-…` requirement ID in the operation register, then follow its family IDs to the actual decision questions and evidence paths. Recover all defined fields and rules before proposing missing ones. Record any method migration separately from implementation so the historical baseline remains auditable. Never automatically relabel a POST declaration as a GET implementation merely because its URL looks like a read.

For a release, use the runbooks and testing criteria for the selected runtime. Record commit SHA, governance database fingerprint, migration set, configuration names, artifact digests, applicable CI results and rollback version. Do not copy secret values into this book or evidence artifacts.

## Maintaining the baseline

Regenerate operation/family traceability after an approved finite-checklist or review change:

```sh
python3 scripts/build-technical-operation-register.py
python3 scripts/build-technical-operation-register.py --check
python3 scripts/check-technical-docs.py
```

These commands update documentation or validate it; they do not activate routes, approve grants, mutate governance, or complete APIs. The project inventory is a reviewed snapshot; refresh it from Git trees and manifest blobs when project structure changes, rather than inferring project count from old chat messages.

Any claimed implementation completion must link the governing contract, actual code, relevant tests, exact CI head and mapped runtime evidence. Changes to a document's wording or generated fields do not count as completed operations.

## First executed implementation step

P00 grant-evidence recovery was implemented and merged in PR #151, commit `8bea69963c12d73f0c000a2632f41d27acdf76ef`, after two applicable workflows passed against head `208806f588f6688a9faa36c582c850c0178ab8f0`. The audit's 16 tests passed. The tracked governance database was not changed.

The actual report audited all 1,063 unresolved operations, retaining 52,096 raw grant rows across 814 operations. All returned registry correlations had differing method/path identities. This is a concrete integrity problem to investigate; a string/key correlation alone does not prove the original grant's approved business meaning. No endpoint was activated. The detailed source-bound findings and remaining phases are recorded in [execution-state.json](execution-state.json).
