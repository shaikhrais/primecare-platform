# Production governance audit — 19 October 2026

The protected production audit completed successfully. It covered **335 physical tables: 334 imported tables containing 490,765 rows, plus one manifest row**. All table row counts match the import manifest. No tables are missing or unexpected. No data was changed.

See [every table and its source/reference evidence](2026-10-19.md). The compressed JSON contains the original aggregate-only audit output; decompress it to reproduce the Markdown with `tools/governance-production/audit-report.py`.

## What accounts for the volume

The largest tables are permission registrations (79,936), translations (56,665), translation values (34,518), workflow steps (18,750), component test registrations (13,615) and component selector registrations (13,612). These are individual metadata, mapping or test records, not distinct business processes. The live business-process denominator is **147**, with 11 missing, 134 implemented-unverified, zero verified and two blocked.

## Decisions before cleanup

| Finding | Audit result | Decision |
|---|---|---|
| Required metadata, provenance and dependencies | 72 tables have explicit requirements, migrated reader dependencies or populated declared incoming references | Retain. A consumer migration and dependency review are required before any consolidation. |
| Historical/verification evidence | 12 tables; 1,794 rows | Retain evidence and source binding. No retention policy or evidence hold release is established. |
| Exact duplicate rows | Zero, comparing all source columns except the import ordinal | There is no supported exact-row deduplication batch. |
| Repeated non-key payloads | 18,607 excess payloads across 16 tables | Not a deletion count: removing primary keys erases workflow, role, screen or operation identity. |
| Explicit retired/obsolete/deprecated/superseded/deleted/archived markers | Zero on inspected lifecycle/status fields | No registration is confirmed obsolete by these markers. A live-consumer/replacement review is still required. |
| Inactive records | One application and one screen | Retain until lifecycle ownership, references and replacement are resolved. Inactive does not establish obsolescence. |
| Other populated tables | 172 tables require owner/consumer review | Retain pending unresolved purpose, active-consumer, replacement and retention checks listed per table. Static mentions are incomplete evidence. |
| Empty schema | 79 tables | No row cleanup benefit. Keep schema until its intended functionality and consumers are resolved. |

The 72 dependency/metadata tables comprise 11 required-metadata, two provenance, 15 migrated-reader and 44 populated-reference tables. Together with 12 evidence tables, 172 tables requiring owner/consumer review and 79 empty tables, these assessments total 335.

### Repetition that must preserve its keys

10,551 repeated workflow-step payloads omit `(flow_id, step_order)`; 5,968 repeated source-link payloads omit `(flow_id, source_table, source_key)`. Their keys carry the workflow binding. These two tables account for 16,519 of the 18,607 repeated payloads and are explicitly required by the user. Other repetitions include role grant/policy matrices and screen-specific configuration. Identical payloads do not make their distinct role or screen keys interchangeable.

The remaining review queue includes 690 repeated test-case payloads, six code-verification payloads, two screen-governance payloads and two issue-resolution payloads. The audit has not established whether they are repeated seeds, distinct executions, distinct issues or intentional registrations. Resolve source ownership, record identity, execution/issue binding and replacement before proposing record-level changes. Preserve the 335 workflow evidence records and 309 workflow attempt records.

### Overlapping registries need an authority decision

Within-table equality does not establish whether two different tables are redundant. These families require an explicit source-of-truth and replacement contract before consolidation:

| Family | Tables to reconcile | Exact unresolved decision |
|---|---|---|
| API identity | `govt_api_endpoints`, `govt_api_endpoint_registry`, `govt_api_registry`, `govt_api_request_schemas`, `govt_api_response_schemas`, `govt_api_permissions` | Establish canonical endpoint identity and reconcile method/path plus source IDs. Existing numeric-key mismatches prohibit a simple ID join or grant remap. |
| Localization | `govt_translations`, `govt_translation_values`, `govt_translation_keys`, `govt_language_resources`, `govt_language_resource_values`, `govt_screen_translation_map` | Resolve which tables author keys, hold locale values or bind screens, and which generators/readers own each representation. Table names and differing counts do not prove redundant translations. Preserve EN/FR/ES requirements. |
| Component/test registration | `govt_component_selector_registry`, `govt_component_test_registry`, `govt_component_test_cases`, `govt_qa_test_id_registry`, `govt_screen_component_map` | Resolve selector identity, test-case/execution identity and stable test-ID consumers before combining registrations. Similar row counts do not prove one-to-one equivalence. |
| Workflow catalogues | `govt_virtual_workflow_definitions`, `govt_virtual_workflow_steps`, `govt_virtual_workflow_source_links`, `govt_virtual_role_flow_guides`, `govt_virtual_flow_catalog_snapshots` | Preserve the 147 `business_process` definitions and their source/acceptance/evidence bindings. Supporting guide overlap is intentional catalogue context and does not create additional business processes. |

Cross-table semantic equivalence, replacement compatibility and undeclared JSON/external references have **not** been established. No cross-table merge or obsolete-table removal is approved. The source references and declared relationship findings in the full report are the starting evidence for these decisions.

### Integrity problems are not cleanup approval

All 465 supported declared unique/primary-key checks completed without a duplicate-key violation. Of 324 declared foreign-key checks, 204 were checked and 120 remain explicitly unresolved because the source affinity/type/collation or target relationship needs review. Checked relationships reported 23,110 orphan occurrences across 12 tables; occurrences can overlap and are not distinct deletable rows.

The permission audit repeats the known identity problem: 57,984 registry/endpoint mismatches and 21,952 missing endpoint references among 79,936 permission rows. Other gaps include API request/response schema links, screen references and 368 workflow-step references to screen functions. Do not remap numeric IDs, enable grants or delete these records without establishing the intended identity. They may be evidence of prior generation defects. The full report names each affected relationship and unresolved check.

## Evidence and validity

- Audited source: `1ef4b60aa8c74b57a9d1096f5b0d7711ef800353`.
- Database snapshot: `211413:211413:`; transaction timestamp `2026-10-19T12:55:43.926Z`.
- [Successful protected audit and fixture checks](https://github.com/shaikhrais/primecare-platform/actions/runs/39255793251).
- Artifact: `governance-table-audit`, ID `12188430553`; downloaded ZIP SHA256 verified as `6e9a2cbc274f8ed3b43908d3040dfa6e13fed4e295d1c684975968b56a146195`.
- Every table has a live content fingerprint. The JSON records the source scan scope and limitations. It exports no raw record payloads.

No workflow completion status was changed. Rerun the audit if bound source, schema or data changes. Next action: review per-record identities and dynamic/JSON/external consumers for the unresolved tables, establish ownership and retention, and prepare a reversible cleanup proposal with explicit keep/remove mappings. **No deletion batch is approved by this audit.**
