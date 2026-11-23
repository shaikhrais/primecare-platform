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

## Registration receipt and source adoption

Run 45090950277 at 800a7d4a passed all five native PostgreSQL boundary tests,
committed 16 resource records / 48 translation records and independently read
back exact parity. New labels have reviewed=0 and approved=0. The generated
option catalogue is adopted byte-for-byte from that readback artifact. The
isolated historical fixture generator now uses the same 16 names.

The legacy Theme Center editor now uses the registered option catalogue as a
fallback when its older screen-copy catalogue lacks a key, while preserving
downloaded screen text overrides. Regression tests cover EN/FR/ES labels and
opening the full existing editor, including its disabled-color field.

This closes the missing source label after verification; it does not claim
independent language review, app-wide adoption, navbar-style support or full
Fuse dashboard acceptance. Application publishing remains separate.

## Shared-UI contrast expectations

At d2186d6 the complete core suite passed 3,089 cases; the later shared-UI suite
passed 110 and exposed two stale expectations. Both expected the preset's white
onPrimary after the test overrides primary to white. Runtime correctly resolves
black for readable contrast. Both expectations now require black, retaining
contrast-ratio checks, hero-gradient checks, draft-input preservation and large
mobile-text coverage. Both affected cases pass locally. No production color
behavior is changed by this follow-up.
