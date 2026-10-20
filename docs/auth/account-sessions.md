# Shared account session controls

The shared authenticated account route `/success` now renders the registered own-session controls from `packages/shared/src/account-sessions.json`. Production metadata owns screen 2519, route registry 7, API 16425 (GET) and API 16426 (DELETE), the existing `authenticated_self_session` permission, eleven controls and English/French/Spanish resources. No new role grants or tenant selectors are introduced.

The presentation uses SessionsController for loading, pagination, explicit confirmation and navigation, and SessionsClient for session-bound transport and strict response projection. The shared account form retains password change. A failed revocation preserves the browser session for retry. A replaced browser session cannot be erased by an older request.

Validation: contract/controller tests and TypeScript compilation passed in Actions run 39444999407. Tests reject malformed responses and unexpected fields (including token hashes), check query bounds and stale-session rejection, require confirmation, prevent duplicate submission, preserve failed requests and isolate replacement sessions. Browser coverage is isolated presentation evidence with synthetic API responses; it must not be counted as deployed API/database verification.

Production builds compare the catalog with the pinned production registration. Explicit isolated fixture builds compare its immutable specification and refuse production credentials.

Pending: deployed browser/API/database/reload proof, revocation rollback/fault checks, denied and cross-tenant evidence, required accessibility/performance/localization/security review and independent acceptance. Database tags and whole-workflow verification remain pending; this change does not declare either business process fully verified.
