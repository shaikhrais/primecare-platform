# Shared admin UI localization

Admin Role Carousel now resolves its UI labels, search placeholder, tooltips,
status labels, counts, dialog labels and feedback from the shared `en`, `es`
and `fr` catalogs in `packages/primecare_ui/lib/src/localization/admin_role_carousel/`.
The generated Dart catalog ships with every Flutter app using primecare_ui;
individual app translation files do not need duplicate copies of these keys.
The active Material locale selects the catalog, so language changes rebuild
labels while preserving the search controller and filters.

`scripts/audit-ui-localization.py` inventories direct Flutter text candidates
and compares existing en/es/fr JSON catalogs for missing keys, empty values
and named/positional placeholder differences. Identical values are reported
for review, not automatically treated as translation defects. Existing
catalog gaps are reported without marking unrelated legacy screens complete.

After editing JSON sources, run `python3 scripts/check-admin-localization.py`.
CI runs `python3 scripts/check-admin-localization.py --check`: it verifies key
parity, nonempty values, named interpolation parameters, referenced keys,
generated output, and direct UI literals on this screen. The widget regression
changes locale through en/es/fr, checks the actual search placeholder and
health dialog, and verifies that a typed search survives language changes.

Names, route paths, file names, registry descriptions and other record data
remain unchanged. Unknown role-category codes remain visible as record data.
An empty missing-items list is described as empty; it is not treated as proof
of production readiness.

Theme Center's three font choices, ten color-field labels, invalid-color
feedback and default duplicate-name suffix now use shared en/es/fr resources.
Stored font/color codes and user-created names remain stable. Hex color input
keeps the locale-independent `#RRGGBB` format. Register the resources with
`python3 scripts/register-theme-center-options.py`; `--check` verifies export
against a read-only governance copy with the migration applied. Translation
rows remain unreviewed until a language review approves them.

Reality Check now resolves its interface text from 35 shared en/es/fr
resources: header, KPIs, filter bar, counters, purpose labels, known status
labels, alerts and empty-state text. Record names, routes, purpose descriptions
and unknown status codes remain record data. Named count/label parameters are
replaced once, preserving parameter-like text within record values. The widget
test verifies visible labels and filtering while changing locale without losing
the selected filter or search query.
Run `python3 scripts/register-admin-reality-filters.py` to register and export;
`--check` validates the export against a read-only governance copy with the
migration applied. Translation rows are pending language review. The binary
database is excluded from the code change. This legacy screen's mobile layout
and record-data translations remain separate work.

Scope: the carousel, Reality Check interface and Theme Center option group are covered.
Screenshot Gallery, other Theme Center inline labels and other legacy screens still
need their own localization migrations. This is not an application-wide
translation-completion claim. Responsive testing of this legacy admin screen
is currently at desktop width; its older mobile layout remains separate work.


Reality Check text is now grouped in one screen JSON document:
`packages/primecare_ui/lib/src/localization/screens/admin_reality_check.json`.
Its version, screen ID and locale maps form the editable transfer format.
Programmatic updates use
`python3 scripts/register-admin-reality-filters.py --import-json /path/to/screen.json`.
The importer checks en/es/fr key parity, nonempty text, size limits and named
parameters before writing governance and regenerating the shared Dart catalog.
Existing resource keys and translation row identities are preserved; changed
translations return to unreviewed status. Ordinary regeneration preserves later
reviewed governance translations. Bundled programmatic updates require a rebuild. The shared live screen-text
service adds authenticated in-app editing, audit history and runtime refresh;
see live-screen-text.md for its deployment prerequisites and supported surfaces.
