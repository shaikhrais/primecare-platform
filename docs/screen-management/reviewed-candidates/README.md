# Reviewed direct-widget candidate inventory

Source review: `1ab9d15510c60de9e07cdc01a4546cd684a11de3`.

**438 / 1396 candidate identities statically classified**; **958 remain unclassified**. Runtime-verified by this inventory: **0**.

Identity is exact file + class + direct base, not a unique production screen.

## Categories

| Category | Count |
| --- | ---: |
| abstract_presentation_base | 1 |
| demo_scaffold | 1 |
| direct_router_screen | 5 |
| embedded_control_or_section | 3 |
| module_declared_placeholder | 138 |
| module_declared_screen_via_alias | 1 |
| nested_scaffold_not_selected_by_governance_router | 22 |
| owner_module_binding_unresolved | 64 |
| owner_module_selects_other_file | 197 |
| unresolved_scaffold_screen | 1 |
| unselected_coordinator_placeholder | 4 |
| unselected_generated_placeholder | 1 |

## Scope and next actions

`inventory.csv` contains each exact file/class, reason, evidence location and next action. It combines the initial 38 and four subsequent 100-entry static reviews. The four 100-entry batches were the first scanner-ordered identities not in earlier batches.

An exact owner-module declaration is **not production dispatch evidence**. A source-selected route is not proof of authorized access, API connectivity, working actions, localization, accessibility, or release readiness. Static classification is not tested behavior. No production access or screen migration is performed by this inventory.

The 197 same-name alternatives and 64 unresolved owner-module bindings must not be called dead code. Their scope is the inspected owner module, not all navigation paths. The three embedded controls and abstract base are not standalone screen migration targets. Existing router boundaries must be preserved; a direct widget base alone does not prove missing management.

The 138 exact owner-module placeholders need dispatch/authorization investigation and authoritative requirements before implementation. The four 100-entry batches include 247 unsupported completion-text placeholders and 152 scaffolds importing TODO sections. Neither is evidence of implemented business behavior.

## Reproduce and maintain

From the repository root:

```sh
python3 scripts/check_screen_inheritance.py
python3 scripts/check_reviewed_screen_inventory.py
python3 scripts/test_reviewed_screen_inventory.py
```

The checker scans current source, checks unique candidate membership, all cited file paths/line ranges, SHA-256 hashes of reviewed source dependencies, category/batch totals and this generated summary. It fails closed when reviewed source changes. It does not auto-refresh source hashes or classify new candidates. After a deliberate source review, update the affected rows and hashes, then use `python3 scripts/check_reviewed_screen_inventory.py --write-summary` to regenerate this page.

The manifest records original batch commits and refreshed fields. All five classifications were rerun against the recorded source commit: 23 initial-batch rows needed current evidence line numbers; the four 100-entry CSVs were unchanged. Hashes cover transitive barrel-resolution inputs too, so unrelated barrel edits may conservatively require review. Do not blindly rehash to silence the checker.

The Flutter counter-demo entry is separately classified as demo_scaffold; its MaterialApp home declaration is not a production route or implementation approval.

The lexical scanner is library-only and can miss indirect inheritance or alternative naming. The import review is not a Dart analyzer or runtime route resolver. Test fixtures outside lib trees are outside the denominator. No completeness, dead-code or production-readiness claim follows.
