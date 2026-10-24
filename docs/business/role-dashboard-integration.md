# Shared role dashboard integration

The existing governance snapshot contains 115 dashboard surfaces. Of these, 110
generated Dart entries contained synthetic success, hardcoded readiness and empty
actions. They now inherit `GovernedWorkspaceEntry`, joining the three previously
integrated CEO/HR entries. The resulting 113 entries span 61 catalog owner-role
codes; that is not a count of independently verified business processes or every
possible active role. Roles still receive only the pages allowed by the server.

`care_delivery` and `founder_growth_dashboard` do not use those generated files.
Their specialized implementations and navigation are preserved. No substantive
custom implementation, external provider reference, role grant, API, route or
clinical workflow is replaced by the template migration.

## What is connected

Every integrated entry uses the existing `/v1/governance/workspace` API. The server
resolves current session and scope, supplies permitted pages and available
organization/personal overview data, and marks missing business sources as
unavailable. The browser receives no PostgreSQL connection or credentials.

The shared renderer displays registered business purpose, user story, acceptance
criteria and unfinished-work notices alongside available metrics and navigation.
These are requirements and limitations, not claims that their business actions
have been completed. No invented finance, recruitment, risk or clinical data is
introduced; account/session counts are not substituted for domain outcomes.

User, tenant, token or role changes replace the workspace state. Cached private
data and search state are discarded, and late responses cannot revive a disposed
session. The existing no-cache API transport and server authorization remain.
Diagnostic keys redact the session value.

## Reproducible integration

`tools/integrate-role-dashboards.py` defaults to a dry run. It reads the governed
snapshot, recognizes only the known generated template signature, preserves
non-template actions and external provider references, and writes wrappers only
with `--apply`. `--check` verifies no eligible placeholders remain and the compiled
Dart route fixture agrees with the snapshot. It never opens a database.

The old `scripts/audit-role-dashboards.py` remains a legacy SQLite consumer and
must not be run against a recreated operational governance database. The new
dashboard identity check uses the pinned production PostgreSQL reader instead.

The read-only CI check compares integrated screen IDs, codes and routes with
active production governance records. It does not change metadata, grant access,
create business records or certify complete domain workflows. Drift aborts the
check rather than silently rewriting production registrations.

## Verification scope

Seven Python tests check template classification, preservation, identity matching,
duplicates and code-injection rejection. The generated Flutter fixture imports
all 113 entry classes. Parameterized widget tests verify each registered route
uses the common API and renders only its fixture server's permitted page with
registered requirements and explicit unfinished status. Existing tests cover
permission denial and user/tenant/token/role lifecycle changes.

Those widget/transport fixtures do not prove real credential login or deployed
domain transactions for all 61 owner roles. Production identity readback verifies
catalog linkage only. Complete role acceptance still requires real login,
role/tenant-denied cases, action → API → database result → reload, accessibility,
domain data bindings and the required independent reviews.

The HR, CEO, growth, board, communication and provider guides remain the detailed
implementation requirements. Recruiting, financial approvals, board decisions,
live Twilio routing, Gmail authorization, clinical policy binding and department
tenant selection remain separate work; shared dashboard integration does not
activate them.

## Final checked evidence

Source `38a95efcbcda3db62daeff5c6c2ec8529b2c1998` passed all 12 jobs in
[40079268342](https://github.com/shaikhrais/primecare-platform/actions/runs/40079268342).
The workspace Flutter job passed 232 tests. Native PostgreSQL checked 74 roles
from the union of overview permissions and screen view grants, passing 88 checks.
The role list deliberately includes ordinary roles absent from the three special
overview-permission entries. Each native fixture role must receive the exact
permitted page set and scope, reject foreign pages/tenant headers, and avoid
creating accounts, sessions or mutation-audit rows during dashboard reads.

Independent pinned production readback verified all 113 dashboard IDs/codes/routes,
with no metadata/grant writes or business-record reads. That readback does not
certify production business workflows or replace current runtime authorization.
See `evidence/role-dashboard-integration.json` for the source-specific receipt.
