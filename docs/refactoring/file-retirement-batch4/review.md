# Generated screen-context retirement

Baseline: `a870a7caa571eb18aee9008d3988adfac6a2f437`.

Retire 948 root `SCREEN_DATA_CONTEXT_*.md` files and one generated
`screen_agent_context/psw_dashboard.json` snapshot. These 949 removals bring the
cumulative cleanup total to 20,616 files.

The original bytes were archived, hash-verified and saved before deletion as
`PrimeCare_Retired_Screen_Context_Records.zip`. The recovery archive includes the
948 screen requirement/configuration snapshots, PSW export, per-file records and
summary. Historical requirements remain useful for future review and rewriting;
their retirement does not establish implementation in the current skeleton.

## Reference and generator review

External tracked text was scanned for exact context filenames/paths. Every text
column of the governance database was checked read-only for both output naming
patterns. No exact-file reference or registered path binding was found.

`tools/governance/generate_all_governed_screens.py` writes the root Markdown
documents from governed database records. `export_screen_agent_context.py`
creates its output directory and writes the screen JSON. Both generators remain
unchanged, as do current screen implementations and governance data. Regeneration
was not run or claimed as validated; exact snapshots remain recoverable regardless
of later database/schema changes. Generated outputs are now ignored by Git.

## Per-file record

`000.json.gz` records all 949 original paths, hashes/sizes, importance, decisions
and pinned recovery commands. Markdown records capture screen code, section
headings and recorded route/source file; the JSON record captures export keys.
These descriptions are an inventory, not a complete semantic specification.
The complete original content supplies details needed for future rewriting.

Restore a file from the source archive by its recorded path, or use its manifest
command to restore it from the pinned Git baseline. Verify SHA-256 before treating
restored content as equivalent.

## Files deliberately retained

The Java framework under `testingFramework1.0` is still invoked by the automated
test workflow for page-object coverage and website setup checks. Its older format
does not make it disposable. The HTML previews still supply the maintained
screenshot workflow. Native platform runners and imported application/service
source likewise require dependency/replacement evidence before removal.

No active source, native runner, maintained test framework, database, contract
fingerprint or deployment binding is retired in this batch. Workflow/API counts
are unchanged; this is output cleanup, not workflow completion.

## Validation

All 949 proposed deletion paths were checked against the Git index; every original
archive entry matches its recorded SHA-256. The database, both generators, Java
test framework/CI configuration, active query helper and four retained evidence
files remain unchanged. Provider-retirement, workflow-contract, contract-factory
and bulk-codegen suites pass (41 tests), plus all three generation consistency
checks. No historical utility or generator was executed.
