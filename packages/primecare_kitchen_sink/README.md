# Flutter kitchen sink

Private developer gallery reusing the existing Flutter component, data-control and chart factories. Hosts import `package:primecare_master/kitchen_sink.dart` and mount `PrimeKitchenSinkGallery`. Existing classes keep their names. `kitchenSinkTheme()` delegates to the canonical Theme Center presets.

The gallery has 34 native examples; autocomplete and metric examples are explicitly marked as web-only previews. The same shared catalog lists all 36 stories and 72 audited reference entries without marking full business parity complete. The widget owns and disposes its controllers; factories retain their own asynchronous/overlay/timer lifecycles.

The master-only example host is `examples/kitchen_sink_flutter`. From this package, run `flutter test test/gallery_test.dart`. The SQLite source hook is root-only test dependency resolution; the gallery has no database operations or production metadata writes. Consumers retain their own root hook settings.

The expandable shared asset gallery renders all 121 canonical PrimeCare assets using the existing registered web/native primitives. Captions expose technical asset keys; decorative drawings are excluded from screen-reader output. English, French and Spanish section labels use the shared catalogue. No vendor asset is copied into runtime source.
