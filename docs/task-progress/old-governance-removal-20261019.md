# Remove operational SQLite governance files

Base: 64324c5915945afa97426c30157ce0080496ba83. Live authority stays in production PostgreSQL, schema governance_68b0b02dd1215f58630d2c1a, using govt_ tables. No production rows, grants, schema or application databases are deleted.

Remove tracked copies:
- .agents/governance/governance.db
- .agents/governance/governance_backup_before_screen_sections.db
- governance.db
- testingFramework1.0/governance.db
- testingFramework1.0/src/test/java/testNG/PointClickCare/governance.db

Ignore these paths so legacy test output cannot accidentally reintroduce them. Preserve historical Git data, the compressed recovery evidence, unrelated index/education databases and test_runs.db.

Some legacy checks still require historical SQLite data. prepare-ci-fixture.py explicitly reconstructs the allowlisted baseline from Git commit 64324c5915945afa97426c30157ce0080496ba83 only in CI with GOVERNANCE_ALLOW_SQLITE_FIXTURES=1 and no production credentials. It verifies SHA256 42d350b6b3ab46540cbc58f2696d896f3afe6658b1f5153bec410dfce87d1262 and refuses unknown local edits. This fixture is untracked and is not live authority. Historical full-checkpoint CLI restoration also now requires explicit fixture mode without production credentials.

Production release governance validation uses the pinned read-only production connector; it no longer commits SQLite registration output back to main. Clean-rebuild fixture checks retain their evidence without staging the removed database.

Local checks: four fixture guard/integrity tests pass and all edited YAML parses. Inspect current PR CI before merging; repair actual failures without bypasses. The operational consumer/writer migration remains incomplete; see governance-production-cutover-20261019.md and tools/governance-production/reference-inventory.json. Removing files is not proof that all legacy writers are migrated or business workflows verified. Legacy manual production jobs that still read SQLite require migration before use; do not supply historical fixtures as live authority.

Live workflow count previously read from production: 147 = 11 missing + 134 implemented-unverified + 0 verified + 2 blocked; DONE=0, PENDING=147. This deletion does not promote workflows.
