# Legacy backup retirement — 11 October 2026

## Result and scope

Retire 16,343 unused files from `generated_screen_backup_before_template_reset`.
Keep four original source files used by contract-review evidence and fingerprints.
This follows the 946 redundant-file removals in PR 172; combined removals are
17,289 files. Active apps, packages, services, schemas and deployment files stay.

The source baseline is `556f7a9a3990ce8be894b0081c81c2c04fdef8b1`.
The complete 16,347-file baseline backup directory was exported before further
deletion, verified against every retirement hash, and saved as
`PrimeCare_Legacy_Backup_Source.zip`. It includes exact original code, per-file
retirement records and a summary. Git history is an additional recovery route.

| Retired category | Files | Importance and preservation |
| --- | ---: | --- |
| Exact copies at original canonical paths | 7,360 | Canonical behavior remains; only historical copies removed |
| Historical files differing from or missing at canonical paths | 8,983 | Potentially valuable old behavior; exact source preserved for future review/rewrite |
| Original evidence files retained | 4 | Required by existing reviewed-contract evidence and source fingerprints |

The retired files contain 25,098,348 uncompressed source bytes. The 8,983 historical
files are **not** claimed as behaviorally migrated, fully specified or implemented
by the new skeleton. The user authorized retirement of unused code for future
rewriting. Complete source preservation avoids relying on a short summary as the
only record of that work.

## Per-file records

The ordered `000.json.gz` through `016.json.gz` manifests record each path,
original SHA-256/size, purpose classification, declared classes/types, imports,
TODO count, canonical path where identifiable, replacement-verification result,
importance, decision and pinned recovery command. Decompress with Python's
`gzip` module or a gzip-capable archive tool. The recovery ZIP includes one
uncompressed `retirement-records.json` for convenient reading.

Purpose classification follows source declarations and file roles. It is not a
complete semantic specification of each old workflow. Exact original source is
preserved for details the inventory cannot describe reliably.

## Reference review

All tracked files outside the backup were scanned for backup-directory and exact
backup-file references. There are no active app/service imports or build-manifest
bindings to the retired paths. All text columns of all tables in the current
governance SQLite database were queried read-only; none contain a reference to
this backup directory.

References that remain are historical reports, four contract-review evidence
paths, the provider-retirement negative scanner/test, CI path filters, inventory
tooling and the historical template-reset utility. The scanner remains unchanged
and still rejects newly introduced archived callers. The template-reset utility
can create a fresh backup when deliberately executed; it was not run here.

The four evidence files remain at their original paths and hashes. No contract
review or historical source fingerprint is rewritten to suggest past checks ran
against different source. No governance database is modified.

## Recovery and deferred work

Restore any retired file from the source ZIP using its recorded path, or run its
manifest's pinned `git restore --source=... -- <path>` command after fetching the
baseline commit. Compare SHA-256 with the manifest before treating a reconstruction
as equivalent.

For future rewriting, inspect the original classes/imports and actual behavior,
then define contract fields, authorization, tenant scope and tests in the current
shared skeleton. Archive retirement gives zero completed-workflow/API credits.

Other files outside the sample skeleton remain subject to their own dependency
review. Being untouched by inheritance conversion is insufficient evidence that
an active source file, native runner, migration, test or operational tool is unused.

## Validation

All 16,343 proposed deletion paths and all four retained evidence hashes were
checked against the baseline archive and the Git index. Every canonical-equivalent
replacement was verified by SHA-256. All source archive entries were verified
against the per-file records before saving.

Local provider retirement, workflow-contract coverage, contract factory and
bulk-codegen suites pass (41 tests). All three generation consistency checks pass.
These checks preserve source fingerprints and pending-workflow counts; no
production database or network generator was executed.
