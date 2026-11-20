# Isolated PrimeCare screen preview

This exports a self-contained HTML5 preview using checked-in PrimeCare UI modules, central MasterDashboard/Theme Center and styles, and an allowlisted projection of screen-registration metadata. It does not download production records, use production sessions, or connect to providers.

## Build and open

```sh
node tools/screen-preview/build.mjs /absolute/output/directory
```

Open `PrimeCare_Interactive_Preview.html` in a modern browser. No server, account, key or external asset is needed. The initial view is the real Code Admin EMS renderer with synthetic traffic. The role selector, screen search and gallery cover the entire checked-in registry. Code Admin views reuse the actual renderer. Other screens are explicitly labelled **registry-based structural previews**: registered sections, fields and actions projected into the actual central master shell. They are not conversions of custom Flutter widgets and do not establish missing business-workflow implementations.

The scenario picker exercises populated, empty, slow-response, unavailable and denied states. The traffic button advances a synthetic five-minute window. Organization creation, account/reference edits, and registered-field saves are simulated in memory. Unsupported API contracts return an explicit unavailable response and appear in exported session coverage; they never fall through to a network. No email, SMS, calls, payments or real provider actions execute. Reload/reset discards preview changes. Production security checks remain untouched.

## Browser screenshots and video

```sh
node --test tools/screen-preview/test.mjs
node tools/screen-preview/capture.mjs /absolute/output/directory
```

The recorder serves only the exported HTML on an ephemeral loopback HTTP server, blocks other HTTP requests, captures the real EMS renderer at desktop/tablet/mobile sizes, records Code Admin views and representative role screens, scans **every** registered screen for renderer errors, and writes a WebM walkthrough plus `browser-report.json`. Set `PREVIEW_CAPTURE_ALL=1` to additionally save a screenshot of every registered page. The generated report distinguishes source renderer, synthetic data, structural coverage, unsupported contracts, and actual browser errors. Browser captures are not production acceptance.

The dedicated GitHub workflow runs on Ubuntu 24.04 with no production environment or provider/database credentials. Its artifact includes HTML, screenshot/video outputs and coverage reports. It does not deploy to the production app or change accounts/permissions. Preview builds explicitly refuse production database and Cloudflare credential variables.

## Extending coverage

Add API scenarios only to `data.ts`, following the corresponding real client response types. Add dedicated renderer adapters to `entry.ts` when available. Keep unknown contracts visibly unavailable, preserve the preview banner, and never mark a registry template as a dedicated implementation. Only the allowlisted `code`, name, route, role, app, renderer and section/element metadata are exported from the registry. The root-tenant JSON import is replaced with a synthetic object during this build. Stock image assets are embedded from an explicit allowlist.
