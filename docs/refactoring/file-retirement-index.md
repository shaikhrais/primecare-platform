# PrimeCare file retirement register

Files are retired by role, dependency evidence and source preservation, not merely
because they were untouched during inheritance conversion. The sample skeleton
does not list every required runtime, runner, test, tool or evidence file.

| Stage | Removed files | Purpose and preserved record |
| --- | ---: | --- |
| PR 172 | 946 | Redundant test backup copies and interpreter caches; per-file hashes/canonical paths |
| PR 173 | 16,343 | Unused backup snapshots; complete original source plus importance/definitions/imports/recovery records |
| PR 174 | 2,378 | Historical scratch utilities, generated agent-context exports and DOM logs; complete archive and file records |
| Screen-context output retirement | 949 | Generated screen requirement/configuration snapshots; full content and section/route/source inventory |
| Total | 20,616 | Counts are file removals; no API/workflow implementation credit |

## Recovery packages

- `PrimeCare_File_Retirement_Review.zip`: initial repository inventory and first removal evidence.
- `PrimeCare_Legacy_Backup_Source.zip`: exact remaining baseline backup directory plus detailed retirement manifests.
- `PrimeCare_Retired_Utilities_And_Exports.zip`: exact historical utilities/context exports/DOM logs and their records.
- `PrimeCare_Retired_Screen_Context_Records.zip`: exact screen-context outputs and their records.

Each manifest gives its own pinned source commit and SHA-256. Historical code
that differs from the current implementation is deferred for future review and
rewriting; its source is preserved rather than summarized away. Git history is
an additional recovery route.

## Retention decisions

| Group | Reason to keep |
| --- | --- |
| Current apps, shared packages and service/Worker source | Current callers, entrypoints and shared inheritance layers; retire only after dependency/replacement review |
| Windows/Linux/Android/iOS/macOS/web runners and assets | Required platform/build support, even when absent from a sample skeleton |
| `testingFramework1.0` and maintained Cypress/CI tooling | Current automated tests still invoke these frameworks |
| 1,058 HTML preview files | Maintained screenshot/report workflows use these pages |
| Four old backup source files | Existing contract-review evidence and source fingerprints require exact original paths/hashes |
| Governance database, schemas and maintained generators | Current authority and generation inputs, not obsolete output copies |
| Root scratch directory README | Maintained tools still need a directory for temporary SQL files |
| Other historical reports and screenshot evidence | Still need reference/evidence review; not automatically declared disposable |

The removed groups have been reviewed at the documented boundaries. This is not
a completed semantic review of every remaining repository file. Remaining active
source must not be deleted solely because its name or language differs from the
sample skeleton. Future retirement records must state what is important, where
the required behavior is retained or explicitly deferred, and how to recover it.
