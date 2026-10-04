# PrimeCare architecture explorer

Interactive Archify maps cover every discovered Dart/Flutter and Node workspace manifest under apps, services, packages, and websites, plus registered TypeScript websites and the standalone governance Worker. The explorer also indexes source files and candidate type/function declarations, and reads app, route, API, and screen-function metadata from the authoritative `.agents/governance/governance.db` without changing it.

## Generate and view

Requirements: Git, Node 18+, Python 3, and Chrome/Chromium for Archify's browser gate.

```sh
python -m pip install -r tools/architecture/requirements.txt
# If Chrome is not discoverable, set ARCHIFY_CHROME to its executable path.
python tools/architecture/build.py
```

The build downloads the upstream Archify renderer into ignored `.architecture-tools/` at the exact revision recorded in `tools/architecture/tooling.json`. It does not install a personal agent skill or modify product runtime dependencies. To use an existing checkout, set `ARCHIFY_CLI` to its `archify/bin/archify.mjs`; the pinned revision is still enforced.

Open `docs/architecture/generated/index.html` in a browser. All views work from local files. Search source paths or declaration names, click source links at the recorded Git revision, or open an Archify dependency/request-path map. API and screen-function statuses come from governance metadata and remain distinct from verified runtime results.

Each map includes its JSON specification, delivery evidence, and build receipt. `validation.json` reports every map's gates. A nonzero build or skipped browser gate is not success. Generated files are ignored: CI publishes them as a downloadable artifact so they can be refreshed without committing dozens of large standalone viewers.

## What the views establish

- Project dependency edges come from local manifest dependencies, not inferred runtime calls.
- Cloudflare service bindings and the Dart gateway mesh are separate runtime paths.
- API client configuration permits an override; browser defaults are same-origin, native defaults target the Worker gateway. The source map does not prove deployment configuration or proxy availability.
- PostgreSQL relationships cite the actual client/query sites.
- Source declarations are extracted heuristically. Dynamic dispatch, callbacks, multiline signatures, generated code, and runtime execution require additional analysis. This is not an exhaustive function call graph.
- Tests, build output, dependency directories, and archives are excluded from the production source index. Code presence and governance statuses do not prove a working screen or endpoint.

The diagram JSON is reproducible from the recorded source revision and governance DB. No new application routes, permissions, endpoints, or governance records are introduced by this documentation tooling.

Archify is MIT licensed: https://github.com/tt-a1i/archify . Its standalone generated output is used here; upstream source is fetched separately and pinned.

## Validation of the initial implementation

Python compilation, source-path and declaration-range checks, and explorer DOM/search tests passed. Archify schema, layout, committed-source, and artifact checks passed for the generated maps. Local Chrome browser gates remain unverified: this execution environment rejects Chrome's process-singleton socket creation. The CI build fails on any unsuccessful gate and uploads its receipts for review. No screenshots or perceptual visual review are claimed.
