# Synthetic-only Login bootstrap

This is an isolated read-plan experiment, not a production reader, complete
Login contract, screen implementation or approval to run against production.
No production connection/CLI is provided. The existing seven-route candidate
is unchanged and still excludes Login.

`login_bootstrap_fixture.py` accepts only the test harness's TLS connection to
127.0.0.1:55432/postgres. It reads only the hard-coded schema
`synthetic_login_contract_fixture` and requires exact synthetic manifest format
`primecare-login-bootstrap-synthetic-v1`. A production manifest is rejected.
No environment target, SQL, schema, path, credential or expected hash override
is accepted. Importing the module does not connect; invoking it as a command
refuses execution. It returns a fixed sanitized diagnostic, never raw rows.

## Source and identity limits

Source inspection at `0bea071e608cef8b606e572225706436d15a47ec` found native
dispatch `SharedAuthRoutes -> LoginView -> PrimeAuthExperience`. Presentation
feature `auth.login` and role label `Public` do not establish database grants.
The source codes `login` and `auth_login_web` remain separate. Missing/inactive
native records are not rescued by the web registration. Current source-path
equality is only observed; app ownership remains unverified even if one active
app row is present. Eight source-evidence Git blob hashes are checked in the
test file so later changes require review rather than silent reinterpretation.

The bootstrap reads a synthetic manifest and six logical relations:
`auth_route_registry`, `screens`, `apps`, `screen_api_links`, `api_endpoints`,
`api_endpoint_registry`. It does not read users, sessions, passwords, grants,
clinical/business records, presentation payloads, translations or themes.
Every projection is enumerated in `FIELDS`. Only exact Login code/path
identities are selected; app/link/registry IDs come from prior scoped results.

**Fixed endpoint discovery is independent of screen links.** It inspects only
POST /v1/auth/login, GET /v1/auth/me, POST /v1/auth/me and POST /v1/auth/logout.
These exact source-observed pairs are checked even when a screen link is absent,
so missing associations are visible rather than inventing them. Arbitrary linked
endpoint IDs are not followed. `nativeLinkObserved` and `webLinkObserved` report
an actual captured link only; coincident numeric screen/endpoint/registry IDs
never create a link. Duplicate endpoint pairs or reused endpoint IDs remain
ambiguous. Out-of-scope links are counted without fetching their payloads.

Source policy versions include `credential_login` and `public_password_exchange`.
They are not normalized into an approved policy. Captured permission values
are never output and `policyReviewRequired` remains true. Disabled legacy grants
do not establish a denial of public password exchange; this bootstrap does not
consult or alter grants. JSON contracts are checked for syntax/shape only;
external references are never followed and examples/defaults are not output.

## Controls and GitHub tests

The reader opens a repeatable-read read-only transaction, sets pg_catalog-only
search path and statement/lock/idle timeouts, checks transaction_read_only,
and attempts rollback on every snapshot exit. Failure cannot become a receipt.
It permits at most 16 normal statements, 64 result rows, 8 KiB selected text
fields, 1 MiB cumulative decoded results and a 30-second checked execution
budget. These byte/time checks are not hard pre-allocation/native-code limits;
the GitHub harness also has an external timeout and job deadline.

`test-login-bootstrap-postgres.py` runs only in the secret-free isolated GitHub
workflow with a fresh hash-locked Python environment, digest-pinned PostgreSQL,
generated local TLS certificate, cleared environment and empty HOME/TMPDIR.
All fixture data and database roles are fabricated and discarded with the
container. Tests cover typed/tagged SQL, independent native/web identity,
missing/inactive/ambiguous identities and app owners, fixed method/path scope,
numeric-domain separation, policy nonpromotion, every free-text sentinel,
malformed JSON/tags, real empty metadata, missing manifest/live schema,
SELECT-only privileges, read denial, actual read-only write rejection, actual
statement timeout, rollback errors, TLS rejection, and exact SQL/parameter
inventory including manifest-first order. No tests run on a laptop or outside
GitHub for this work. Test implementation is not a claim that CI has passed;
use the exact commit's workflow result.

All receipts retain `productionAuthorityEstablished=false`, `releaseReady=false`,
`contractComplete=false` and `nativeWebEquivalenceEstablished=false`.

## What remains before Login G1 or a credentialed run

The native Login contract still needs authoritative identity/version, business
acceptance, native sections/elements/components and their action bindings,
finite EN/FR/ES key set, theme ownership and exact policy reconciliation. Web
layout registration and shared auth localization prefixes cannot fill those
missing native bindings. No filler object or synthesized grant may close G1.

A production-capable reader would be a separately reviewed implementation,
not a fixture flag change. The governance/security owner must approve its exact
immutable bytes/runtime, narrowly bounded query inventory, intended provider
project/database/schema, existing SELECT-only credential, protected runner,
external time/memory limits and private contract-review destination. Verify
live physical relation ownership/types/RLS, tenant identity, TLS/CA provenance,
credential privileges and environment controls. Keep raw contract/grant data
out of public CI logs/artifacts. No production access, new credential, persistent
access, registration, repair, merge or deployment is implied by these tests.

Do not substitute `read-auth-session-contracts.py`, which prints and writes raw
contracts, or the MFA/public-login registration writers (including dry runs).
Neither is this proposed safe metadata-only path.
