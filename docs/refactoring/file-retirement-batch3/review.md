# Historical utilities and generated exports retirement

Baseline: `f787038bc0b134d94c157e4849585d1d33754528`.

Retire 2,378 files, bringing cumulative removals across the cleanup stages to 19,667.
The batch's source and generated content were saved and hash-verified in
`PrimeCare_Retired_Utilities_And_Exports.zip` before deletion.

| Group | Files | Purpose and importance |
| --- | ---: | --- |
| Root scratch files | 279 | Historical audit, database repair, source repair and prototype utilities; preserve exact source for future review |
| Generated agent-context exports | 2,096 | Historical app/role/screen governance snapshots; current database and export generators retained |
| DOM logs | 3 | Historical inspection output with no caller or governance binding found |
| HTML preview files retained | 1,058 | Used by maintained screenshot and preview-report workflows |

## Evidence and decisions

External tracked content was checked for filenames, direct paths and module
imports. Database text references were queried read-only, including registered
commands and code-file paths. Dependencies of referenced scratch utilities were
considered. No reference resolves to a retired top-level scratch file.

The apparent `query_db.py` match in Cypress configuration resolves explicitly to
`tools/governance/query_db.py`. The retired `scratch/query_db.py` is a distinct
hard-coded historical role audit. The maintained query helper is preserved.
Database references to other/nested scratch areas do not identify files in this
retired top-level group; those other areas remain untouched.

`tools/governance/sync_d1.py` and `test_flow_runner.py` write temporary SQL files
under root `scratch`, so the directory remains with a tracked README. Generated
workspace contents, agent exports and DOM outputs are ignored to prevent them
being accidentally tracked again. Maintained export generators create their
output directories when deliberately run; they were not executed here.

Preview pages are retained because `scripts/deploy_and_selenium_screenshot.py`
loads the generated role index, and the preview/report generators write there.
Generated agent-context exports have no application importer or governance DB
directory references. DOM logs have no external directory references.

## File records and recovery

`000.json.gz` through `002.json.gz` contain every retired path, hash, size,
purpose, importance and pinned restore command. Utility records also capture
declared functions/classes, imports and detected SQL operations/table identifiers;
JSON export records capture their top-level data keys. These are source inventories,
not complete semantic specifications or permission to execute old repair scripts.
Exact original bytes are preserved in the recovery ZIP and Git history.

Useful maintenance behavior has not been ported merely because its scratch copy
was retired. Future rewriting must review the original source and current schema,
authorization and contract requirements. No database operation or API is credited
as implemented by this change. No retired utility was executed.

## Validation

All 2,378 deletion paths were verified against the Git index and every archive hash
against the retirement manifest. All 1,058 preview files remain tracked. Maintained
query helper, database, export generators and SQL writers remain tracked and
byte-identical to the baseline. Non-Python scratch files were separately checked
for database bindings. Provider-retirement, workflow-contract, contract-factory
and bulk-codegen suites pass (41 tests); all three generation consistency checks
pass. No retired utility or export generator was executed.
