# Password recovery requirements gap

Observed 2026-09-28. Not implemented and not production-ready.

The registry contains POST /v1/auth/forgot-password and POST /v1/auth/reset-password,
but neither has a request schema, response schema or permission key. The currently
configured GitHub repository secrets provide Cloudflare and database connectivity;
no recovery-delivery configuration is present. This report does not approve a provider.

Proposal for validation before a governance migration or implementation:

- Forgot-password accepts a normalized email and always returns the same generic
  response, whether or not an active account exists.
- Deliver a cryptographically random, short-lived token through the approved email
  provider. Store only its hash. Never return tokens in the public response or logs.
- Reset requires the token and a password satisfying the approved password policy.
  Consume the token atomically, update the password, revoke all sessions, and audit
  the event in one transaction. Reject expired and already-used tokens identically.
- Explicitly approve token lifetime, per-account and per-source limits, delivery
  retry policy, retention, sender identity, and allowed reset-page origins.
- No administrator bypass, role assignment or tenant switching through recovery.

Affected roles: all roles eligible for login. Security impact: this grants a new
credential-recovery path, so delivery ownership and token handling are release gates.

Proposed database changes after validation: governed endpoint contracts and recovery
policy records; a PostgreSQL token-hash table with user reference, expiry and consumed
state; recovery audit records. Exact migration follows the approved policy values.

Required tests: unknown/known email indistinguishability, delivery failure without
enumeration, expired/used tokens, concurrent redemption, session revocation, database
rollback, unauthorized tenant/role overrides, throttling and secret-free responses.
