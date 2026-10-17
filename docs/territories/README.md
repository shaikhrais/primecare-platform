# Territory sales and allocation

One new section in Platform Administration, shared with tenant administrators. Implementation is local and API-connected; PostgreSQL concurrency CI, public-source publication permission, production rollout and human approval remain pending. No real territory sale has been recorded.

1. **Done — governed catalog.** Registered 30 geographic pieces, 24 sale territories, two APIs, presentation components, semantic colors and EN/FR/ES resources before implementation. The 24 draft territories contain **1,246,300 residents aged 65+**; six reserves contain 32,335. Each sale territory has 50,000–55,000 seniors. Every one of the 226 selected postal FSAs occurs once.
2. **Done — numbered map.** Natural Earth roads/water and GeoNames place labels provide geographic context. Available territories are green; sold territories are red; reserves are grey. Select a green map piece with a mouse or keyboard, or choose a territory from the selector/table. Zoom to the selection or restore the full map. Sold pieces are disabled for allocation; details remain readable.
3. **Done — tenant allocation.** A platform or central administrator chooses an active tenant, PSW and/or home care, an approved sale reference, and confirmation. Recording the sale assigns that entire territory exclusively to one tenant. There is no independent second sale for its other service. This records an approved sale; it does not collect money, execute an agreement, or create care visits.
4. **Done — persistence and access.** All reads/writes use authenticated APIs. The browser has no database adapter. Tenant administrators receive only their own allocations and no global tenant picker. Staff and unknown roles are denied. A sale, its actor/tenant audit record and replay receipt commit together. A row lock plus a unique territory key prevent duplicate ownership. Retries reuse an idempotency key; mismatched requests and later sales return 409. There is no reassignment or unsell endpoint.
5. **Done — summaries and local review.** The board shows sold/available counts and senior totals, plus each territory’s name, number, code, postal areas, population, operating tenant, services, reference and recording date. Six browser cases cover English/French/Spanish at 320 and 1440 CSS pixels in headless Chromium, with keyboard selection, failed-save draft retention, successful sale, lock, refresh, reload and tenant views. These are emulated viewports, not physical-device tests. Screenshots use synthetic tenants and test sales; counts in screenshots are not business results.
6. **Pending — release.** Apply migrations to the target database, run the PostgreSQL CI race test, deploy API and web assets, and obtain human admin review. GitHub read access is verified, but an earlier automatic approval review rejected publishing private source to the public repository without explicit permission. Cloudflare/database credentials are not configured. Nothing has been deployed.

## Evidence

- Territory suite: 16 local cases pass; one independent-connection PostgreSQL race case is skipped locally because PGlite uses a shared engine. CI runs the race on PostgreSQL 16. Local retry checks are not claimed as concurrency proof.
- Added recovery checks: a stale browser receives 409 after another administrator sells an area, automatically refreshes to its locked red state and shows the actual owner. A server-committed sale followed by a simulated lost response retries with the original key and creates exactly one audit record. These sequential checks do not replace the PostgreSQL race test.
- Existing administrator workflows: all eight browser regression cases pass against worker handlers and disposable PGlite data.
- Clean-checkout installation check passes against the committed governance database, with registration performed in memory; no local database changes need to be published.
- TypeScript 5.9.3 compilation and all nine website builds pass. The territory browser bundle has zero database or worker modules.
- Both test suites drop their synthetic schemas and verify removal.
- Human approval, full WCAG audit, live database verification and production performance checks are pending. This adds no completion credit to the existing legacy API backlog.

## Screenshots

All images below show **synthetic QA data, not actual sales**.

| Screenshot | What it proves visually |
| --- | --- |
| [Before sale](screenshots/before-sale-desktop.png) | Selected green area, services, tenant and reference retained after a simulated transport failure |
| [After sale](screenshots/after-sale-1440.png) | Same area red and locked; ownership and summary updated |
| [Conflict recovery](screenshots/conflict-recovered.png) | A stale form refreshes to the other tenant’s sold allocation without a duplicate sale |
| [Mobile summary](screenshots/after-sale-320.png) | Responsive summary at 320 CSS pixels |
| [Mobile map and details](screenshots/mobile-map-details.png) | Zoomed numbered area and read-only sold details |

## Reproduce and deploy

Install Shapely 2.2.0 for geographic export. `python3 scripts/register-territory-governance.py` registers the source inputs in governance.db and exports the API policy, map paths, catalog SQL and OpenAPI. Use `--check` to verify the exports in an isolated governance copy. The registrar first installs the existing approved admin/growth registrations, so a clean checkout does not depend on an edited local database. `--database PATH --check` verifies exports against an isolated copy of a chosen governance database. Geography, IDs and Census counts must not be changed to reuse an already sold territory.

Apply, in order:

1. Existing identity/session migrations and `20261011_platform_administration.sql`.
2. `20261015_territory_allocation.sql`.
3. Generated `20261015_territory_catalog.sql`.

The migrations accept canonical UUID or text tenant/user keys. Catalog insertion is repeatable and never overwrites an existing territory. Reads and direct sale writes fail closed when a territory’s number, name, code, FSA membership, senior count, population or reserve flag differs from governance. Unregistered territory IDs cannot be sold, even if someone inserts a row into the application catalog.

With the normal test dependencies installed, run:

```sh
PLATFORM_TEST_DATABASE_URL=postgresql://... node --test scripts/test-territory-allocation.mjs
node scripts/build-typescript-websites.mjs
```

The CI workflow is `.github/workflows/platform-admin-acceptance.yml`. See [OpenAPI](openapi.json) for request schemas, permissions, validation, errors and the mutation rate limit. New endpoints are `GET /v1/governance/platform/territories` and `POST /v1/governance/platform/territories/{id}/sale`. Bearer sessions are required. Query tenant overrides and `X-Tenant-Id` are rejected.

## Data and mapping limits

Population means age 65+ in the **2021 Census**, not current population, qualified leads, demand or clients. Source: [Statistics Canada table 98-10-0027-01](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810002701). Boundaries are whole Census-derived postal FSAs, not current six-character postal delivery polygons. The supplied urban-screened plan still includes rural pockets; travel times and address eligibility are not verified. The browser uses simplified display paths; retained source GeoJSON remains the geographic planning reference. Existing six reserves cannot be sold through the API.

Roads/water use [Natural Earth public-domain data](https://www.naturalearthdata.com/about/terms-of-use/). Place names/coordinates use [GeoNames, CC BY](https://www.geonames.org/export/); credit: GeoNames contributors. GeoNames population values in the source context only determined place-label selection in the earlier map work and never feed the senior totals. This feature uses no external map tiles, no live Facebook audience counts and no purchased campaigns.
