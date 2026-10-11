# File retirement review — 11 October 2026

Baseline: `af61336bac522e2ab4a82cd61c562f2a57807258`.

## Decision

Do not bulk-delete files because they were untouched by inheritance conversion.
Existing migration reports explicitly preserve incomplete workflows, old import
paths and placeholder contracts. The example skeleton is not a complete inventory
of required production behavior.

The read-only audit read and hashed all 54,313 tracked files. It records path,
size, SHA-256, a content-heading/declaration or path-based purpose, review status,
and byte-identical copies. This is an inventory, not a completed semantic review.
`scripts/audit-file-retirement.py --output-dir /absolute/output/path` reproduces it.
The audit does not run old utilities or change the governance database.

## Findings

| Group | Files | Decision and reason |
| --- | ---: | --- |
| Pre-template-reset backup | 17,291 | Retain pending behavioral and reference review |
| Backup files with an identical copy outside backup | 8,304 | Prioritize review; identical bytes do not prove relative imports or callers are equivalent |
| Historical scratch utilities | 279 | Retain until effects, replacement and dependencies are reviewed |
| Tracked Python interpreter caches | 2 | Remove; both source scripts exist, parse and have no exact cache-path/name references |

The backup has 8,987 files without a byte-identical copy outside that directory.
This does not prove unique business behavior, but it rules out blanket claims
that all backup content has already been preserved elsewhere.

The backup directory is mentioned by the template-reset utility, provider-profile
retirement scanner/test, and workflow-contract CI path filters. These consumers
must be considered before retiring the directory.

The API-feature migration preserves 533 route bindings, including unfinished
handlers; the remaining-model migration preserves 945 empty DTOs. These are
structural migrations, not proof that their workflows can be removed. Existing
compatibility exports preserve import paths and class identity.

## Removal record

`file-retirement-removed.json` records the two removed caches, original hashes,
retained source paths, importance, reconstruction instructions and reference
results. No application source, database, contract, platform runner, migration,
test fixture or deployment configuration is removed in this change.

The baseline commit remains the recovery reference for the original files.
Python recreates the two caches from the retained source. No runtime compilation
or application tests are required for interpreter-cache removal; both generator
sources were parsed without executing their database/network side effects.

## Required evidence for the next deletion

Record the actual behavior/fields/permissions and any unique information; locate
static and dynamic imports, manifests, generators, tests and governance references;
identify the replacement or explicitly deferred workflow; preserve recovery commit
and original hash; then run checks appropriate to the affected dependency boundary.
Keep a file if a required behavior has no verified replacement. Future rewriting
is a reason to preserve a usable specification before removing implementation.

The machine inventory labels unreviewed files accordingly. It makes no claim
that the whole repository is converted, tested or safe to discard.
