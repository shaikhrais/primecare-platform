# Parallel foundation package

Six parallel work streams checked existing handlers, callers, authorization metadata, and finite catalog accounting. No new API operation is marked complete by this package.

The reproducible local catalog bootstrap now quarantines 79,936 proven generated permission rows and 2,498 generated placeholder schema rows before artifact generation. Source records, identities, digests, and pointer provenance are preserved. Repeat application removes zero rows. The tracked seed and production databases are unchanged; the repair applies to derived local and CI catalogs. Unknown metadata fails validation instead of acquiring invented authority. The architecture migration no longer fabricates schemas, all-role grants, or implemented handlers.

An immutable catalog identity baseline rejects new or changed corruption while permitting reviewed legacy groups to be removed. It is not an authorization source.

The mounted scheduling router has 13 screen reads and 13 actions that previously returned empty or successful placeholder responses. These now return HTTP 501 with no-store and without parsing a body or initializing database access. They remain unimplemented operations and receive no completion credit. Twenty-seven actual router tests and static analysis cover this behavior.

Historical finite ledger: 1,415 unique operations = 343 with unit evidence + 2 retired declarations + 1,060 pending + 10 explicitly blocked. Pending operations still require individual contracts and defined authorization; parallel execution cannot supply missing product decisions. Field, metadata, and false-success repairs do not change these counts.

Validation includes repeat application on a disposable seed copy (see foundation-quarantine-validation.json), 34 new Python regression tests, 27 Dart router tests, the complete API fixture suite, Worker type checking, and CI. Repository-wide foreign-key checking is prevented by the existing unrelated translations-to-languages schema defect; quarantine checks are scoped to affected tables and reject incoming references.
