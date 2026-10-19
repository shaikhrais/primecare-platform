# Production governance cutover checkpoint

Current implementation branch: work/governance-production-cutover-20261019; draft PR https://github.com/shaikhrais/primecare-platform/pull/204.

Base main: 5fd2de0177461653416443546d7b7c4c2bc9954f.

Production has 335 govt_ tables in governance_68b0b02dd1215f58630d2c1a; 490765 source rows preserved. Rename evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39238510770.

This change introduces a pinned, read-only production connector. It refuses missing credentials, conflicting URLs, unexpected host/database/manifest, unknown relations, writes and cross-schema queries. Explicit isolated fixture mode has no production fallback. SQLite is used only for source schema introspection, never for production records.

Cutover is incomplete. Three read-only diagnostic callers now use the shared production connection (db_table_counts, inspect_architecture_counts, inspect_tables_content). They pass against the restored explicit SQLite fixture. The local reference inventory is from the current sparse checkout, not a full-repository inventory: 44 reader candidates, 180 writers requiring semantic review, 12 workflows, 977 documentation/generated references. Historical evidence must remain unchanged.

Local verification: three production-reader fixture tests passed. A staged portal exporter produced all nine manifests identical to the old implementation (excluding generation timestamp). The staged exporter and three audit callers are not included until their CI dependencies and production runs are validated.

Next: run protected production reader verification; resolve any manifest/schema compatibility errors; migrate exporter and read-only audit entrypoints with explicit isolated CI fixture wiring. Then migrate writer transactions, identity/default/unique semantics and SQLite-specific SQL. The imported snapshot has 751 all-null columns stored as JSONB, no mixed columns, and no executable SQLite views or natural-key/default constraints. Do not point legacy reset/write scripts at production or infer permission grants.

Workflow verification is unaffected: 147 = 11 missing + 134 implemented-unverified + 0 verified + 2 blocked; DONE=0, PENDING=147. Recalculate from live business_process records after the production reader succeeds. Full browser/API/database/evidence gates remain required.

Production read validation passed at https://github.com/shaikhrais/primecare-platform/actions/runs/39242527957 (commit 205ea0209870b539029599c49ed12874a05195cf). Downloaded receipt artifact 12182142386 verified ZIP SHA256 e5374a43a54fe8cec4872a421405f1abaa520e66924bd24f17fce99aa51fd068. Live counts confirm 147 business processes: 11 missing, 134 implemented-unverified, 0 verified, 2 blocked. No writes were attempted. The current branch additionally runs the migrated diagnostic entrypoints in the protected production job; inspect that result before merging.

Pending exporter and three audit caller edits are saved as governance-consumer-candidates.patch. Apply only after reviewing their CI/dependency changes and production validation. The exporter was compared with its predecessor against the restored complete fixture: all nine portal JSONs matched except generatedAt. This does not verify production exporter execution. No permission grants were added.
