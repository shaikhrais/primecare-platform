# Web kitchen sink

Private developer showcase composed from the existing `PrimeComponentFactory`, `PrimeDataControls` and `PrimeDashboardWidgets`. It supplies 36 local examples across actions, forms, content, overlays, feedback, data and charts. Search and category filters retain mounted controls; locale rebuilds preserve field drafts. Each mounted example has scoped IDs and owned teardown.

Hosts use `@primecare/master/kitchen-sink` and the master's CSS exports. The implementation exports the same original factory classes without renaming or copying them. No preview callback calls a business API or saves a user preference.

Build with `node tools/kitchen_sink/build.mjs`; serve `packages/primecare_kitchen_sink_web/dist`. This is a private monorepo package with relative imports to canonical UI source, not a standalone npm distribution. Production host registration and publication remain separate.

The expandable shared asset gallery renders all 121 canonical PrimeCare assets using the existing registered web/native primitives. Captions expose technical asset keys; decorative drawings are excluded from screen-reader output. English, French and Spanish section labels use the shared catalogue. No vendor asset is copied into runtime source.
