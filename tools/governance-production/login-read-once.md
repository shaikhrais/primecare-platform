# One-shot Login read wrapper, not activated

`login_read_once.py` connects once using the existing strict URL/TLS parser,
validates the existing local production pin/home policy, calls only the fixed
Login candidate and closes the connection. No workflow references a production
secret or dispatches this wrapper. Synthetic GitHub tests use fabricated values
and an explicit test-only loopback connector, not production credentials.

Normal stdout contains exactly a fixed status plus false authority/completeness/
release flags and privateDataExported=false. It discards the candidate's richer
status receipt. It does not log the URL, username, database records, exception
messages or grants. No output file/artifact is created. Connection failure,
manifest mismatch, timeout, denied SELECT and close failure cannot report success.
Python signal limits are defense in depth, not an independent hard resource
boundary; future execution must add a protected external timeout and memory cap.

## Before a credentialed run

Approve the final immutable wrapper, candidate, parser, pin and locked dependency
bytes, plus the specific protected one-shot workflow and its event/ref. Identify
the exact existing GitHub secret and confirm it is the intended provider project,
PostgreSQL database and governance schema. Confirm the existing credential's
privileges and trusted physical relations/ownership/RLS; a shared provider hostname
or successful login does not establish either project identity or least privilege.
Do not add, rotate or expand credentials as part of this task. Any persistent
secret binding or expanded access requires separate action-time confirmation.
Do not lower branch/environment approvals or expose secrets to PR-controlled code.

For a status-only run, the only recipient is the Actions run's ordinary viewers,
and the only output is the fixed diagnostic receipt. This is not a private raw
contract export. If actual contract content is required, the user must approve a
specific private destination/recipient and a separately reviewed output design.
No private raw-data destination has been verified by this work. Do not put
plaintext metadata into this public repository's logs or artifacts.

The wrapper accepts GOVERNANCE_DATABASE_URL or PRODUCTION_DATABASE_URL as process
variables through the existing parser. These are variable names, not evidence
that identically named GitHub secrets exist. A future reviewed workflow must map
the user-confirmed existing secret exactly; do not guess its name.

No table creation, repair, population, grants, data mutation or production run is
performed. Missing data returns a diagnostic failure/unverified result. Creating
production governance contracts would need exact owner-approved content and a
separately scoped write operation, never invented policy.
