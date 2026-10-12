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

Scope: this screen is covered. Admin Reality Check, Screenshot Gallery,
Theme Center's remaining raw option labels and other legacy screens still
need their own localization migrations. This is not an application-wide
translation-completion claim. Responsive testing of this legacy admin screen
is currently at desktop width; its older mobile layout remains separate work.
