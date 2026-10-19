# Runtime theme and layout management

DevExpress research informed the separation of theme management, live layout customization, stable identity and explicit save/restore. Official sources:
- https://docs.devexpress.com/WindowsForms/2307/controls-and-libraries/form-layout-managers/layout-and-data-layout-controls/design-time-and-runtime-customization/default-runtime-customization
- https://docs.devexpress.com/WindowsForms/2178/controls-and-libraries/form-layout-managers/layout-and-data-layout-controls/design-time-and-runtime-customization/runtime-undo-redo
- https://docs.devexpress.com/WindowsForms/2179/Controls-and-Libraries/Form-Layout-Managers/Layout-and-Data-Layout-Controls/Miscellaneous/Save-and-Restore-Layout
- https://docs.devexpress.com/WPF/DevExpress.Xpf.Core.ApplicationThemeHelper.ApplicationThemeName

## Implemented website foundation

`layout_profile.ts` is a renderer-independent versioned presentation contract. `BaseThemeManager` captures and restores the governed portal tokens; light/dark presets and optional hexadecimal accent update presentation without rebuilding inputs. Accent text uses the higher-contrast black/white foreground. `BaseLayoutManager` validates changes, applies shell CSS attributes, retains a bounded undo/redo history, and saves/restores explicitly to local browser storage per authenticated account and role. `XmlLayoutManager` serializes only this presentation profile, with a 16 KiB limit and strict validation before any change.

Every authenticated website role gets Appearance through the existing shared shell. Changes are immediate; Save persists only on this browser. The editor supports en/fr/es labels where the caller selects that locale. Sidebar left/right and compact/expanded widths, content width 75–100% on desktop, spacing and themes remain responsive. Mobile retains the navigation drawer and full content width. The default portal theme and layout remain available via Reset. Reset is live; use Save after Reset to persist it.

Only explicit v1 XML fields are accepted. Unknown versions, elements, namespaces, attributes, directives, entities, script/CSS/URL payloads and out-of-range settings are rejected atomically. The XML does not contain identity, credentials, records, routes, permissions or API definitions. Appearance cannot hide the top bar, remove required form fields, create controls or grant access. No extra backend request is made for personalization.

## Boundaries and next adapters

This is the first shared website implementation, not a DevExpress replacement. Arbitrary drag/drop form design, nested/tabs/docking, field visibility, tenant-wide administration and synchronized server profiles are not implemented. Existing Flutter ThemeSettingsNotifier and ThemeSettingsDrawer are retained; a future Flutter XML adapter should map the same v1 contract into those classes rather than fork native theme state. Layout design must use registered stable component IDs before supporting section reordering. A future server profile service needs explicit scope, optimistic versions and audit/rollback; it must not treat XML as authorization.

## Example and validation

See `layout-profile-v1.xml`. Theme: default/light/dark; accent: empty or #RRGGBB; sidebar: left/right; navigation: expanded/compact; density: comfortable/compact; contentWidth: integer 75–100. Validation rejects unknown/missing fields and object coercion. Browser acceptance tests cover invalid XML, round trip, persistence, per-account isolation, undo/redo, retained form/header/sidebar DOM, navigation, the editor and mobile overflow. Platform browser regression additionally exercises live customization and XML export/import against the real authenticated website.
