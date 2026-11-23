# Theme Center option resource registration

Readback 45088373731 found no records under the expected
`themeCenter.options.*` namespace. The existing 15-name generated catalogue also
omits the shared editable `color.disabled` field. This leaves one broad native
test failing and can break the legacy editor when it requests the missing label.

The pinned migration registers exactly 16 resource names and 48 EN/FR/ES values
in the existing language tables. Fifteen names preserve the existing source
copy; disabled text adds unreviewed copy for the already existing color field.
No generated runtime catalogue is changed before independent production readback.

The writer inherits the shared production store, requires exact catalogue bytes
and explicit flags, checks physical schema against the manifest, locks metadata
tables, and rejects unrelated fields or approval claims. Existing edited values
cause rollback instead of replacement. Native PostgreSQL tests cover idempotency,
exact scope, preservation, rollback and opt-in/hash enforcement. The production
job runs only after those tests pass and checks the expected main head.

Only the two language metadata tables receive inserts. No schema, grants,
business data, application deployment or runtime activation changes. New labels
remain reviewed=0 and approved=0. Readback exports a candidate for subsequent
source adoption; it does not claim independent language review or full Fuse
acceptance. The horizontal-navbar and full-dashboard gaps remain separate.
