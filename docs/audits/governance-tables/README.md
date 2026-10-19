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
