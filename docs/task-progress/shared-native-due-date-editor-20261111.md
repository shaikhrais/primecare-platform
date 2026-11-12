# Shared native due-date editor

Batch summary before implementation: reuse the existing shared PrimeDataKit date input in authorized task due-date editors rather than adding another picker implementation. Add an enabled state and lifecycle ownership to the shared typed field so an outstanding date/time dialog cannot write into a replaced, disabled or disposed field. Preserve task contracts, explicit save/readback, ISO dates, labels, registered IDs and existing permission decisions. This improves native calendar/tasks/notes/board editor behavior; contacts remain read-only.

Base main: `d803c1e2043b7073428d2c473f5ae61b2845c2fd`. Strict boundary and contract gates pass on that exact head, while its full Theme Center matrix is queued. The preceding calendar cleanup head `a7bc28aa` passed all five targeted jobs: browser, PostgreSQL and Flutter Linux/Windows/macOS. These are predecessor results, not new-head acceptance.

No new business endpoint, grant, registration or palette is introduced. Native behavior and lifecycle checks must execute in GitHub Actions. The source scan and source mappings alone confer no acceptance credit.

## Implementation

PrimeDataKit.field gains an optional enabled flag (default true). Its private shared field owner serializes picker opening, tracks scope/controller/kind/bounds/enabled identity, dismisses only the captured picker route after identity invalidation or disposal, and rejects late results or results superseded by a newer controller edit. Existing typed-field validation, masks, date/time formatting, public exports, theme controls and cancellation behavior are retained. The caller keeps controller ownership.

Authorized work-module date fields now use that same shared implementation. Manual ISO entry and existing save validation remain available. The picker supports the existing four-digit nonzero-year domain rather than narrowing task acceptance to the calendar view's year range. Selecting a date does not submit a mutation or declare success. A test port requires the normal independent readback before the module can report a saved date.

Eight new native regression cases cover disabled typing/picker, date and time scope/controller replacements independently, newer-edit preservation, owned-route-only dismissal under another dialog, and actual work-module date selection/save/readback. The data-controls workflow retains queued/running validation with cancellation disabled. Every changed native implementation composes through exact reversible receipts; original historical source hashes remain unchanged. Native tests are authored, not locally executed.

Counts remain strict previous 0/current 0/new removals 0; fully accepted features 0/72, pending 72; source-mapped 45/unreconciled 27. This closes part of the native editor implementation gap, not an entire calendar or task business feature or production deployment gate.

## Local validation

All 284 historical migration regressions, 28 strict boundary regressions and three workflow regressions pass. The exact 293-source contract guard still validates 1063 unresolved operations and grants zero API credits. The shared-source audit passes (19 reviewed mappings; 45/72 source-mapped total), strict source findings stay zero, and native delimiters/whitespace are checked. The original work-module and data-control hashes are retained in reversible receipts, not refreshed. GitHub Actions will perform Dart analysis and the authored native widget tests on the published head; these local checks do not establish native acceptance.

## Predecessor foundation acceptance

Before publication, exact base `d803c1e2043b7073428d2c473f5ae61b2845c2fd` Theme Center run 43134008698 completed all 11 jobs successfully: native, website and the nine migrated app importer matrices. Its strict boundary and contract gates also pass. This verifies the preceding calendar and validation repairs on their final code/CI head. It does not verify the new due-date editor batch and does not close the full B01-B18 business/host/device/human release gaps.
