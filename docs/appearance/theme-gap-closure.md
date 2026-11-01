# Theme gap-closure work

Runtime changes are on main at `4c29795d4fe2e36dd1c978d0e4c16a2f0226e3b2`. B10 run 41310167831 passed web and all three native platforms. B16 run 41310167833 passed web, native PostgreSQL and all three native platforms.

## Corrected code gaps

- B10 native structured-editor links now use an explicit host-supplied safe HTTPS action, show failures, disable duplicate taps and suppress late updates after scope/disposal. Document replacement also clears link/image input drafts. App-specific host navigation remains a separate binding.
- B16 operational counts preserve explicit unavailable/null fields instead of failing the complete dashboard. Both renderers label missing metrics rather than reporting zero. Absent fields, invalid numbers and null task counts still fail validation. The real-handler fixture exercises an absent optional operational table.
- B17 now has a reproducible developer catalogue: 72 proposal features with source APIs/owners/usage, 1,200 records from the existing reference inventories with explicit dispositions, and nine native apps/nine web portals in the adoption inventory. These different audit scopes are not a unique vendor-feature count. Import presence and blocked dispositions do not establish migration or reviewed parity.
- B18 now has a combined model/browser/native PostgreSQL/Linux/Windows/macOS verification workflow. `check-theme-release.py --require-complete` rejects release closure when any of the eighteen batches lacks full functionality, deployed runtime, human review or release evidence. This tool is a declared-evidence gate, not a replacement for independent verification or an automatic deployment policy.

## Work that remains blocked or unverified

Approved app/host/source/role bindings and live UI → API → database → reload checks remain open in earlier batches. Richer editor/table/upload variants, advanced chart families and broad app migration remain source/feature work. The catalogue lists the owning package and remaining scope; those items are not silently dropped.

Standalone contacts/notes, timed calendar/recurrence, board ranking, general file/mail/message operations, academy/commerce/AI-image/help and financial examples need confirmed approved workflow/service/provider mappings. Earlier searches established missing queried candidates, not proof that no equivalent service exists. Resolve the authoritative mapping and access policy before exposing new business actions; do not invent routes, roles, provider credentials or successful transactions.

Localization/accessibility signoff and physical Android/iOS acceptance require actual reviewer/device evidence. None is manufactured by source tests, a passing build or a generated report. All eighteen batches therefore remain short of full production/release closure until those gates and remaining source features are resolved.

## Reproduce

- `python scripts/build-theme-developer-catalogue.py --check`
- `python scripts/audit-theme-batches.py --check`
- `python scripts/check-theme-release.py --require-complete` (currently returns nonzero as intended)
- `.github/workflows/theme-closure.yml` for combined source/browser/database/native verification

No work branch is created. Remaining implementation and evidence stay on main.

## Native table pinning repair

The shared B10 Flutter table now keeps pinned columns and selection/expansion actions at the logical leading edge while unpinned columns scroll. Header/body keep one cell instance each, retain vertical virtualization, and use direction-aware horizontal offsets. Added LTR/RTL position and selection regressions. Six shared JavaScript model tests pass locally. Native analysis/widget execution awaits CI: local Flutter startup was stopped after automatic review rejected an unexpected cloud metadata request. Local browser launch also failed; neither is counted as passing. This repair does not establish host activation or close B01–B18 release gates.

A fresh SELECT-only production registry read in run 41311286317 inspected 1,312 endpoint rows and found 187 keyword candidates across the unresolved service groups (calendar 36, contacts/notes 19, messaging/files 46, academy 29, commerce/finance 42, images/help 15; groups overlap). This corrects any inference that only the earlier queried endpoint names could exist. No candidate is automatically considered a matching workflow, executable implementation, provider entitlement or role grant. The report records the registered method/service/auth/permission fields for contract triage, performs no endpoint calls and reads no business records. See `theme-service-candidates.json`.

The combined workflow's first run exposed orchestration gaps: four native oracle fixtures were not prepared before the combined native command, the sidebar browser assertion raced responsive layout, and the native PostgreSQL job omitted PGlite's package even though an imported fixture module requires it. The harness now generates/downloads those oracles, waits for the same sidebar width invariant and installs the declared fixture dependency. These corrections do not waive tests or turn pending release gates into passes.
