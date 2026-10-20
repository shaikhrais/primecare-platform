Authentication maintenance repair

The current email-configuration save and test-email clients accepted any HTTP200
JSON as success. An empty object produced the unrelated account-created message.
Both clients now require the existing operation-specific acknowledgement before
the UI refreshes or displays a localized confirmation. Malformed, unavailable and
replaced-session responses remain failures and preserve the current login.

The production maintenance workflow binder now covers the three existing duties:
auth.inspect-email-config, auth.save-email-config and auth.test-maintenance-email.
It binds their already-declared methods/routes to existing APIs16493/16494/16495,
screen1264 and the existing CEO/maintenance view/edit rows. It does not create
duties, routes, business data, permissions or review approvals. Exact pinned scope,
schema, source, API role and screen role checks fail closed. Binding changes
invalidate previous evidence.

Validation includes acknowledgement/session regression tests, native PostgreSQL
metadata safety tests, and a credential/browser/gateway/native-database/reload
producer for each mutation. Capture-only synthetic email acceptance is distinct
from inbox delivery. The producer covers malformed responses, offline retry,
save/audit rollback, provider failure, denied actors, cross-tenant access, invalid
inputs and concurrent same-revision saves. Protected execution records production
attempts and evidence; these tests alone do not establish full verification.

Full auth acceptance remains dependent on current specifications, deployed edge
and cookie behavior, PWA/cross-platform acceptance, missing registered account and
session controls, recovery policy cutover and independent review gates. A provider
send cannot be rolled back after external acceptance; ambiguous retry/delivery
requirements require an explicit registered decision before full verification.
