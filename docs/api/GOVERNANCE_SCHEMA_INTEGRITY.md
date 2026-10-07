# Governance schema integrity repair

The architecture hydrator historically inserted the same generic `{type:object,properties:{id:{type:integer}}}` request and response for every registry entry, using registry IDs as API foreign keys. Those rows are placeholders, not verified API contracts. The schema's numerical API ID can point at an unrelated canonical operation.

`quarantine-api-schemas.py` recognizes only rows with that exact parsed placeholder, matching Req_/Res_ generator names, and matching registry ID. It atomically archives their full original rows, SHA-256 digests, registry provenance, linked endpoint snapshots and every cleared endpoint pointer relationship, detaches active schema pointers, and removes them from active request/response tables. It never overwrites canonical inline schemas, remaps identities, alters permissions or records completed APIs. Archive identity collisions abort and roll back the entire operation. Manual or meaningful schema rows are preserved.

Run against an explicit local SQLite database copy:

```sh
python scripts/quarantine-api-schemas.py /absolute/path/to/governance.db
python scripts/test-governance-schema-integrity.py
```

On a clone of main's database, 1,249 request and 1,249 response placeholders were quarantined (2,498 rows). A second execution changed zero rows. All archived digests verified and related api_endpoints/request/response foreign-key checks remained clean. The database-wide foreign-key check is independently blocked by an existing translations-to-languages foreign-key definition mismatch.

Nine focused tests cover numerical identity collision, preserving canonical/manual schema data, quarantine archive collision rollback, outer transaction rollback, canonical contract hydration rejection, multiple pointer preservation, digest/provenance corruption, and unreviewed trigger/reference/layout rejection. `canonical_schema_rows` can materialize only explicit canonical inline contracts after method/path identity has been validated by its caller; it rejects generic placeholders instead of promoting them.

No binary database or runtime handler changes are included. Zero newly completed APIs.

The repair rejects unreviewed mutation triggers, incoming schema references beyond canonical endpoint pointers, and changed source/archive table layouts or identities. Before deleting any active row it verifies the archived digest and all preserved provenance, including every endpoint whose schema pointer will be cleared.
