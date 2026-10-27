# Callback production storage release

Registers the nine-column callback table in the pinned production governance
database before creating native storage. This uses the existing exact storage
writer base and does not update API schemas, role grants, users or content.

The generated additive SQL creates only `public.communication_callback_requests`
and its pending-request index. It refers to the already registered voice task
table. The source SQL, prerequisite SQL and generated bundle are hashed. Changed
sources, metadata, manifest, native prerequisites, existing schema or non-private
table permissions cause failure without repair or replacement.

The workflow gates production on native metadata registration tests, PostgreSQL
schema reference tests and the real callback task/approval/persistence acceptance
suite. Production uses the pinned direct database host for a rolled-back dry run
and the actual migration, followed by independent pooled read-only verification.
No migration creates callback content, grants privileges or enables a Vapi tool.

Independent schema comparison covers columns, defaults, indexes, primary/foreign
keys, checks, identity/generated attributes and row-security flags. Existing
approval and contact structures are compared with the tested reference before
and after the change. Owner-only access is required for all relevant tables.

This is storage readiness, not complete callback operation. A live host still
needs native app identity and approval, current task permissions and staff pickup
or fulfilment. Existing Vapi task routing stays disabled until that full path is
verified. No call, SMS, live app approval or human callback is claimed by this
release.

Run the existing callback workflow for business acceptance. Storage release
evidence is produced by `callback-storage-production.yml` in
`test-results/callback-storage-schema`. Record the resulting production receipt
before describing the migration as complete.
