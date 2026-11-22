# Kitchen sink catalog

Developer-only metadata shared by the web and Flutter showcases. `tools/kitchen_sink/generate.py` reads the existing component/data/widget registrations and the source-audited Fuse-inspired mapping. It emits `catalog.json`, immutable metadata snapshots and `lib/primecare_kitchen_sink_catalog.dart`.

There are 36 example stories, EN/FR/ES labels and 72 reference entries. Existing registration IDs, proposal dispositions and component names are retained. The metadata creates no route, authority, API grant or production acceptance.

Run `python tools/kitchen_sink/generate.py --check` from the repository root. Implementation packages consume this private catalog; hosts enter through the master.
