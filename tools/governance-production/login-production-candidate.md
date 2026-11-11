# Inactive Login production-read candidate

`login_production_candidate.py` provides `read_candidate(db)` for an already
established connection. It creates no connection, reads no environment, accepts
no credential, and has no executable CLI. No production workflow or secret binding
is provided. Do not invoke its private fixture seam in production.

The public API fixes host pooled.db.prisma.io, port 5432, database postgres,
verify-full TLS with the system CA bundle, governance schema and manifest hash
68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42.
It rejects hostaddr/service overrides, non-idle or non-autocommit connections.
That provider hostname does not authenticate the intended project/tenant.

It validates manifest bytes and each of the six relations' selected column
storage types, supporting per-column mixed typed/tagged import storage. It reads
only Login route/screen metadata, referenced app IDs, screen API link IDs, four
fixed auth method/path pairs, and their endpoint-registry rows. No users, grants,
sessions, challenge payloads, localization text or secrets are queried. The
receipt contains fixed statuses/counts/booleans, never raw rows. All authority,
contract-completeness and release-readiness flags remain false. Errors have
fixed codes; transaction rollback is attempted on every read-path exit.

The implementation independently retains the synthetic bootstrap's SQL and
reducer; it does not patch or repurpose that module or the seven-route reader.
The synthetic manifest builder is deliberately absent from this candidate.
Its test uses the private hash seam solely for fabricated PostgreSQL data under
the production-shaped schema name inside the disposable loopback container.
Fake connection metadata is used only to test guards and the fixed production
pin dispatch. It is never evidence of a credentialed connection.

Before actual use, approve the exact final candidate/runtime bytes and a
protected one-shot runner; confirm intended provider project/database/schema,
existing SELECT-only identity, trusted physical relations/owners/RLS, TLS CA and
native dependency provenance. Enforce external hard memory/time limits; decoded
byte budgets do not prevent allocations before checking. Confirm the intended
private review destination if any contract data is ever needed. This candidate
only emits sanitized diagnostic statuses and cannot itself supply a full native
screen contract. It never repairs, creates or populates missing production data.

No production access, credential setup, security setting changes, merge or
release is authorized by this file. Existing broad exports/writers remain out
of scope. A missing/incompatible pinned manifest or relation fails closed.
