# Production governance cutover checkpoint

Base main: 5fd2de0177461653416443546d7b7c4c2bc9954f.

Production has 335 govt_ tables in governance_68b0b02dd1215f58630d2c1a; 490765 source rows preserved. Rename evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39238510770.

This change introduces a pinned, read-only production connector. It refuses missing credentials, conflicting URLs, unexpected host/database/manifest, unknown relations, writes and cross-schema queries. Explicit isolated fixture mode has no production fallback. SQLite is used only for source schema introspection, never for production records.

Cutover is incomplete. Existing callers are not yet switched. The reference-inventory.json is from the current sparse checkout, not a full-repository inventory: 44 reader candidates, 180 writers requiring semantic review, 12 workflows, 977 documentation/generated references. Historical evidence must remain unchanged.

Local verification: three production-reader fixture tests passed. A staged portal exporter produced all nine manifests identical to the old implementation (excluding generation timestamp). The staged exporter and three audit callers are not included until their CI dependencies and production runs are validated.

Next: run protected production reader verification; resolve any manifest/schema compatibility errors; migrate exporter and read-only audit entrypoints with explicit isolated CI fixture wiring. Then migrate writer transactions, identity/default/unique semantics and SQLite-specific SQL. The imported snapshot has 751 all-null columns stored as JSONB, no mixed columns, and no executable SQLite views or natural-key/default constraints. Do not point legacy reset/write scripts at production or infer permission grants.

Workflow verification is unaffected: 147 = 11 missing + 134 implemented-unverified + 0 verified + 2 blocked; DONE=0, PENDING=147. Recalculate from live business_process records after the production reader succeeds. Full browser/API/database/evidence gates remain required.
