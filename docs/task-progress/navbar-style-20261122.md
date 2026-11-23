# Native navbar Fixed/Static

Add an independent horizontal Navbar Style selector using the existing shared
radio control. Fixed remains visible; Static scrolls with the page. The toolbar's
setting and all existing public class names remain separate and unchanged.

Register the optional control and EN/FR/ES copy on the existing authorized host
before adopting its verified export. No new routes, grants, APIs, schema or
business data. The registration phase does not claim implementation.

Persist the native choice in the existing account-scoped appearance settings,
which are device-local. Old v1-v4 appearance files and strict workspace v1 layouts
must keep working. The cloud workspace API contract is not extended or bypassed.
Save/load of the complete native settings file must preserve the new choice.

Behavior verification must cover toolbar independence, real scrolling in both
horizontal layouts, hidden/vertical navbar compatibility, draft-state preservation,
account boundaries and restored settings. Implementation metadata may advance
only to implemented-unverified after native checks; no full Fuse or deployment
acceptance is inferred.

Initial production attempt hit PostgreSQL lock timeout and rolled back. The
writer retries only SQLSTATE 55P03 using fresh transactions, at most eight
attempts with delays capped at eight seconds. Other errors remain failures. A
native lock-contention fixture proves rollback and successful fresh registration.
