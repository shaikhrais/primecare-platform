# Table inventory preparation (synthetic only)

This module is NOT a production entrypoint. It has no database connection constructor,
credential environment lookup, production workflow, or key generation entrypoint.
The accompanying workflow uses synthetic in-memory cursor fixtures only. Its tests
are not PostgreSQL integration verification and do not establish production readiness.

Inventory returns no individual records. It reports non-system ordinary and
partitioned tables, materialized views and foreign tables. It skips foreign tables
and parents containing foreign descendants. SELECT privilege failures, timeouts,
RLS-visible counts and exhausted time budgets remain explicit. Planner estimates
are stale-capable estimates, not exact counts. Parent/child counts overlap and
must never be summed. Counts use separate table snapshots. Purposes require reviewed
application-source evidence. The fixed overall budget prevents starting later
counts but an active query can run up to its five-second statement timeout.

## Private output design, not yet enabled

1. Confirm intended production tenant, approved schemas, exact existing secret,
   connection role, expected pinned authority, and verified TLS configuration.
   A shared provider hostname is not tenant identity. Review implications of RLS
   and user-defined functions; READ ONLY alone is not a complete sandbox.
2. Obtain required approval before binding a credential to any new workflow.
3. Generate a one-use RSA-3072 or stronger encryption key in the private cloud
   workspace. Keep its private half there only, never in repository, CI, chat,
   artifacts or logs. Pin/review the public half and intended recipient.
4. Review and pin the eventual runner code and dependencies. Validate recipient
   key before opening the DB. Use read-only role if available and fixed SQL.
   Catch errors at the top level with a fixed non-sensitive failure message.
   Neither query errors nor table names/counts enter logs or job summaries.
5. Pass returned JSON bytes directly to envelope.seal. Only the resulting
   authenticated ciphertext may be written to the artifact staging directory.
   Do not write plaintext inventory to files or environment variables. Do not
   upload on failure. Use an exact single filename, short retention, and no caches.
6. List the verified run's artifacts, download the exact ciphertext ZIP with the
   GitHub artifact connector, materialize through its returned supported file
   reference, and extract the single expected bounded entry without path traversal.
   No temporary private download URL is a user-facing delivery link.
7. Decrypt in the private cloud workspace, verify authentication and JSON shape,
   and deliver only to the requesting user. Public repository artifacts are not
   private storage: the ciphertext must remain cryptographically protected.
   Private key loss makes the report unrecoverable. No persistent access or
   credentials need to be created. Do not claim an end-to-end route is verified
   until the artifact download/materialization path has actually succeeded.

The synthetic encryption test validates round-trip, non-determinism, tamper
rejection, wrong-recipient rejection and minimum key size on GitHub only. Its
private test key is in runner memory and its artifact contains synthetic ciphertext.
No production recipient key has been generated or approved by this change.
